-- ============================================================================
-- Migración 202610110020: Normalización de dosis_min y dosis_max numéricas
-- Limpia ceros sobrantes o imprecisiones en dosis_min_mg_kg y dosis_max_mg_kg
-- ============================================================================

BEGIN;

-- Redondear a 4 decimales limpios
UPDATE medicamentos
SET
  dosis_min_mg_kg = ROUND(dosis_min_mg_kg::numeric, 4),
  dosis_max_mg_kg = ROUND(dosis_max_mg_kg::numeric, 4)
WHERE dosis_min_mg_kg IS NOT NULL OR dosis_max_mg_kg IS NOT NULL;

COMMIT;
