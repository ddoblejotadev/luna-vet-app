-- Migración correctiva: completar fármacos cuyo nombre difiere en la DB viva
-- "Enrofloxacina" está cargada como "Enrofloxacina 10%",
-- "Vitamina B12 (Cianocobalamina)" como "Vitamina B12".
-- Cefalexina y Ranitidina no existen en el catálogo: sin cambios.
-- Idempotente: COALESCE protege datos ya existentes.

UPDATE public.medicamentos
SET
  mecanismo_accion = COALESCE(mecanismo_accion,
    'Antibacteriano fluoroquinolona: inhibe ADN girasa y topoisomerasa IV bacterianas'),
  farmacocinetica = COALESCE(farmacocinetica,
    'Biodisponibilidad 80-100%. Vida media 5-8h. Excreción renal y hepática'),
  precauciones = COALESCE(precauciones,
    'Evitar en animales jóvenes en crecimiento (riesgo de cartílago) y gestantes'),
  dosis_por_especie = COALESCE(dosis_por_especie, '{}'::jsonb) ||
    '{"Perro":{"min":5,"max":20},"Gato":{"min":5,"max":20}}'::jsonb
WHERE activo AND nombre ILIKE '%enrofloxacina%';

UPDATE public.medicamentos
SET
  mecanismo_accion = COALESCE(mecanismo_accion,
    'Cobalamina: cofactor enzimático esencial para síntesis de ADN y mantenimiento de mielina'),
  farmacocinetica = COALESCE(farmacocinetica,
    'Absorción dependiente de factor intrínseco gástrico. Se almacena en hígado')
WHERE activo AND nombre ILIKE 'vitamina b12%';
