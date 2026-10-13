-- ============================================================================
-- Migración 202610110022: Normaliza ceros redundantes en concentracion_mg_ml dentro de JSONB
-- Limpia los artefactos de punto flotante "0.05000000000000000000" -> "0.05"
-- ============================================================================

BEGIN;

-- Normaliza strings numéricos "0.0500000..." -> "0.05"
UPDATE medicamentos
SET presentaciones = (
  SELECT jsonb_agg(
    elem
    || CASE
         WHEN elem ? 'concentracion_mg_ml'
          AND elem->>'concentracion_mg_ml' IS NOT NULL
          AND elem->>'concentracion_mg_ml' ~ '^[0-9]+\.?[0-9]*$'
         THEN jsonb_build_object('concentracion_mg_ml', trim_scale((elem->>'concentracion_mg_ml')::numeric)::text)
         ELSE '{}'::jsonb
       END
  )
  FROM jsonb_array_elements(presentaciones) AS elem
)
WHERE presentaciones IS NOT NULL
  AND jsonb_typeof(presentaciones) = 'array'
  AND presentaciones::text LIKE '%"concentracion_mg_ml"%';

COMMIT;
