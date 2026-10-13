-- ============================================================================
-- Migración 202610110021: Normaliza ceros redundantes dentro de presentaciones JSONB
-- Limpia "0.0500" -> "0.05", "70.0000" -> "70" en dosis_min/max del JSON.
-- Necesaria porque la 0019 ya aplicada en remoto dejó strings con 4 decimales;
-- reescribir 0019 local no re-aplica en remoto, por eso esta migración de limpieza.
-- También reaplica ROUND de columnas por si 0020 aún no corrió en remoto.
-- ============================================================================

BEGIN;

-- 1) Columnas numéricas (idempotente con 0020)
UPDATE medicamentos
SET
  dosis_minima_mg_kg = ROUND(dosis_minima_mg_kg::numeric, 4),
  dosis_maxima_mg_kg = ROUND(dosis_maxima_mg_kg::numeric, 4)
WHERE dosis_minima_mg_kg IS NOT NULL OR dosis_maxima_mg_kg IS NOT NULL;

-- 2) JSONB presentaciones: normaliza strings numéricos "0.0500" -> "0.05"
--    via trim_scale((...)::numeric)::text (en Postgres ::numeric preserva escala de strings,
--    trim_scale elimina ceros redundantes a la derecha preservando precisión exacta).
UPDATE medicamentos
SET presentaciones = (
  SELECT jsonb_agg(
    elem
    || CASE
         WHEN elem ? 'dosis_min_mg_kg'
          AND elem->>'dosis_min_mg_kg' IS NOT NULL
          AND elem->>'dosis_min_mg_kg' ~ '^[0-9]+\.?[0-9]*$'
         THEN jsonb_build_object('dosis_min_mg_kg', trim_scale((elem->>'dosis_min_mg_kg')::numeric)::text)
         ELSE '{}'::jsonb
       END
    || CASE
         WHEN elem ? 'dosis_max_mg_kg'
          AND elem->>'dosis_max_mg_kg' IS NOT NULL
          AND elem->>'dosis_max_mg_kg' ~ '^[0-9]+\.?[0-9]*$'
         THEN jsonb_build_object('dosis_max_mg_kg', trim_scale((elem->>'dosis_max_mg_kg')::numeric)::text)
         ELSE '{}'::jsonb
       END
  )
  FROM jsonb_array_elements(presentaciones) AS elem
)
WHERE presentaciones IS NOT NULL
  AND jsonb_typeof(presentaciones) = 'array'
  AND presentaciones::text LIKE '%"dosis_min_mg_kg"%';

COMMIT;
