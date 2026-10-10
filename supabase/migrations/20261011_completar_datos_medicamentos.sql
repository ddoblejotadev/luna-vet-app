-- Migración: Completar datos faltantes en medicamentos clave
-- Objetivo: Poblar campos de mecanismo, farmacocinética, precauciones
-- Fecha: 2026-10-10

-- ============================================================
-- Crear columnas faltantes (si no existen)
-- ============================================================

ALTER TABLE public.medicamentos
ADD COLUMN IF NOT EXISTS farmacocinetica TEXT,
ADD COLUMN IF NOT EXISTS precauciones TEXT,
ADD COLUMN IF NOT EXISTS embarazo_lactancia TEXT;

-- ============================================================
-- Actualizar medicamentos comunes con datos completos
-- ============================================================

UPDATE public.medicamentos
SET
  mecanismo_accion = COALESCE(mecanismo_accion,
    CASE nombre
      WHEN 'Amoxicilina' THEN 'Beta-lactámico: inhibición de síntesis de pared bacteriana'
      WHEN 'Metronidazol' THEN 'Nitroimidazol: daña ADN bacteriano anaeróbico'
      WHEN 'Enrofloxacina' THEN 'Fluoroquinolona: inhibición de topoisomerasa II y IV'
      WHEN 'Cefalexina' THEN 'Cefalosporina: inhibición de síntesis de pared bacteriana'
      WHEN 'Dipirona' THEN 'AINE: inhibición de prostaglandinas, analgésico y antipirético'
      WHEN 'Tramadol' THEN 'Opioide sintético: agonista μ, bloquea recaptura de monoaminas'
      WHEN 'Meloxicam' THEN 'AINE: inhibición selectiva de COX-2'
      WHEN 'Prednisolona' THEN 'Corticoesteroide: inmunosupresor y antiinflamatorio'
      WHEN 'Omeprazol' THEN 'Inhibidor de bomba de protones: reduce ácido gástrico'
      WHEN 'Ranitidina' THEN 'Antagonista H2: reduce producción de ácido'
      WHEN 'Metoclopramida' THEN 'Antagonista dopamina: antiemético y procinético'
      WHEN 'Ondansetrón' THEN 'Antagonista 5-HT3: antiemético selectivo'
      WHEN 'Dexametasona' THEN 'Corticoesteroide: antiinflamatorio e inmunosupresor potente'
      WHEN 'Vitamina B12 (Cianocobalamina)' THEN 'Cofactor enzimático: síntesis DNA y metabolismo'
      ELSE mecanismo_accion
    END),
  farmacocinetica = COALESCE(farmacocinetica,
    CASE nombre
      WHEN 'Amoxicilina' THEN 'Absorción oral 60-90%. Metabolismo hepático. Eliminación renal 60%. Vida media 1-1.5h'
      WHEN 'Metronidazol' THEN 'Absorción rápida 90%. Metabolismo hepático. Eliminación renal. Vida media 8-12h'
      WHEN 'Enrofloxacina' THEN 'Absorción rápida oral. Metabolismo desacetilación hepática. Vida media 4-12h especie dependiente'
      WHEN 'Cefalexina' THEN 'Absorción oral 60%. Metabolismo mínimo. Eliminación renal. Vida media 0.5-2h'
      WHEN 'Dipirona' THEN 'Absorción rápida. Metabolismo extenso hepático. Eliminación renal. Vida media 2-3h'
      WHEN 'Tramadol' THEN 'Absorción oral 70%. Metabolismo hepático activo. Eliminación renal. Vida media 5-6h'
      WHEN 'Meloxicam' THEN 'Absorción rápida. Metabolismo hepático. Eliminación renal y biliar. Vida media 15-20h'
      WHEN 'Prednisolona' THEN 'Absorción oral rápida. Metabolismo hepático. Eliminación renal. Vida media 18-36h'
      WHEN 'Omeprazol' THEN 'Absorción 35-40% con alimentos. Metabolismo hepático CYP2C19. Vida media 1h con efecto 24-72h'
      WHEN 'Ranitidina' THEN 'Absorción oral 50%. Metabolismo hepático. Eliminación renal. Vida media 2-3h'
      WHEN 'Metoclopramida' THEN 'Absorción rápida. Metabolismo hepático. Eliminación renal. Vida media 4-6h'
      WHEN 'Ondansetrón' THEN 'Absorción oral 55-60%. Metabolismo hepático. Eliminación renal. Vida media 3-5h'
      WHEN 'Dexametasona' THEN 'Absorción IM rápida IV inmediata. Metabolismo hepático. Vida media 36-72h acción prolongada'
      WHEN 'Vitamina B12 (Cianocobalamina)' THEN 'Absorción compleja por factor intrínseco. Almacenamiento hepático. Vida media 9 días depósitos prolongados'
      ELSE farmacocinetica
    END),
  precauciones = COALESCE(precauciones,
    CASE nombre
      WHEN 'Amoxicilina' THEN 'Insuficiencia renal ajustar dosis. Alergia a penicilinas. Diarrea asociada a C. difficile'
      WHEN 'Metronidazol' THEN 'Neuropatía periférica con uso crónico. Evitar en hepatopatía severa. Neurotoxicidad con altas dosis'
      WHEN 'Enrofloxacina' THEN 'Lesión cartílago en jóvenes. Evitar en gatos toxicidad retiniana a altas dosis. Tendinitis posible'
      WHEN 'Cefalexina' THEN 'Insuficiencia renal. Alergia cruzada con penicilinas 1-5%. Monitorear signos GI'
      WHEN 'Dipirona' THEN 'Riesgo agranulocitosis vigilancia. Evitar en deshidratación. No usar más de 7 días sin supervisión'
      WHEN 'Tramadol' THEN 'Riesgo de síndrome serotoninérgico con IMAO. Puede deprimir SNC. Convulsiones en dosis altas'
      WHEN 'Meloxicam' THEN 'Monitorear función renal. Evitar con otros AINE. Ulceración GI posible. Dosis ajustada en gatos'
      WHEN 'Prednisolona' THEN 'Inmunosupresión. Hiperglucemia. Úlcera GI. Uso prolongado insuficiencia adrenal. Monitoreo veterinario'
      WHEN 'Omeprazol' THEN 'Uso prolongado malabsorción B12. Hipomagnesemia. Interacciones múltiples. Ajustar otras drogas'
      WHEN 'Ranitidina' THEN 'Insuficiencia renal ajustar. Posible inhibición de absorción de otras drogas. Menos potente que IBP'
      WHEN 'Metoclopramida' THEN 'Efectos extrapiramidales con uso prolongado. Contraindicada en obstrucción mecánica. Sedación posible'
      WHEN 'Ondansetrón' THEN 'Constipación posible. Bien tolerado. Costo elevado. Usar dosis mínima efectiva'
      WHEN 'Dexametasona' THEN 'Potente inmunosupresión hiperglucemia úlcera GI. Nunca suspender bruscamente. Hospitalización recomendada'
      WHEN 'Vitamina B12 (Cianocobalamina)' THEN 'Segura en dosis recomendadas. Bien tolerada. IM preferida para absorción. Equilibrio con ácido fólico'
      ELSE precauciones
    END)
WHERE activo = true AND (
  mecanismo_accion IS NULL
  OR farmacocinetica IS NULL
  OR precauciones IS NULL
);

-- ============================================================
-- Crear columna dosis_por_especie
-- ============================================================

ALTER TABLE public.medicamentos
ADD COLUMN IF NOT EXISTS dosis_por_especie JSONB DEFAULT '{}'::jsonb;

COMMENT ON COLUMN public.medicamentos.dosis_por_especie IS
  'JSON con dosis específicas por especie. Ej: {"Perro": {"min": 10, "max": 15}, "Gato": {"min": 5, "max": 10}}';

-- ============================================================
-- Semilla de dosis por especie para medicamentos clave
-- ============================================================

UPDATE public.medicamentos
SET dosis_por_especie = COALESCE(dosis_por_especie, '{}'::jsonb) ||
  CASE nombre
    WHEN 'Amoxicilina' THEN '{"Perro": {"min": 10, "max": 15}, "Gato": {"min": 10, "max": 15}}'::jsonb
    WHEN 'Enrofloxacina' THEN '{"Perro": {"min": 5, "max": 10}, "Gato": {"min": 5, "max": 8}}'::jsonb
    WHEN 'Meloxicam' THEN '{"Perro": {"min": 0.2, "max": 0.3}, "Gato": {"min": 0.1, "max": 0.2}}'::jsonb
    WHEN 'Tramadol' THEN '{"Perro": {"min": 4, "max": 6}, "Gato": {"min": 2, "max": 4}}'::jsonb
    WHEN 'Dipirona' THEN '{"Perro": {"min": 15, "max": 25}, "Gato": {"min": 15, "max": 25}}'::jsonb
    WHEN 'Metronidazol' THEN '{"Perro": {"min": 10, "max": 15}, "Gato": {"min": 10, "max": 15}}'::jsonb
    WHEN 'Cefalexina' THEN '{"Perro": {"min": 15, "max": 30}, "Gato": {"min": 15, "max": 30}}'::jsonb
    WHEN 'Prednisolona' THEN '{"Perro": {"min": 0.5, "max": 2}, "Gato": {"min": 0.5, "max": 2}}'::jsonb
    ELSE '{}'::jsonb
  END
WHERE activo = true AND dosis_por_especie = '{}';
