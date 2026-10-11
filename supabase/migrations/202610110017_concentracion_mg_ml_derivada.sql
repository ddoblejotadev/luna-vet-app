-- ==========================================================================
-- Migración: 202610110017_concentracion_mg_ml_derivada.sql
-- Deriva concentracion_mg_ml (numérico) desde el campo concentracion (varchar)
-- que ya está poblado 240/240 y respaldado por fuentes oficiales
-- (Plumb's, Merck Vet Manual, DailyMed, VMD SPC).
-- No inventa datos: parsea el valor textual existente en la base.
-- Casos especiales:
--   - µg/ml  → conversión a mg/ml (÷ 1000), ej. Vitamina B12 1000 µg/ml = 1 mg/ml
--   - Polvos para reconstituir (Anfotericina B), soluciones sin fármaco
--     (Lactato de Ringer, Cloruro de sodio 0.9%), multiproductos (Mastilac)
--     y presentaciones "Variables" NO se derivan (no hay concentración fija).
-- ==========================================================================

-- Derivación directa: "X mg/ml"
UPDATE public.medicamentos
SET concentracion_mg_ml = ((REGEXP_MATCH(concentracion, '([0-9]+(?:[.,][0-9]+)?) *mg/ml'))[1])::numeric
WHERE activo = true
  AND concentracion_mg_ml IS NULL
  AND concentracion ~* '[0-9]+(?:[.,][0-9]+)? *mg/ml';

-- Conversión µg/ml → mg/ml (÷ 1000)
UPDATE public.medicamentos
SET concentracion_mg_ml = (((REGEXP_MATCH(concentracion, '([0-9]+(?:[.,][0-9]+)?) *µg/ml'))[1])::numeric) / 1000
WHERE activo = true
  AND concentracion_mg_ml IS NULL
  AND concentracion ~* '[0-9]+(?:[.,][0-9]+)? *µg/ml';
