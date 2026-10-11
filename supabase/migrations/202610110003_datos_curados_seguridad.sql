-- Migración: Datos curados de seguridad clínica para medicamentos veterinarios frecuentemente consultados
-- Fuentes: FDA DailyMed / VMD UK SPC (Summary of Product Characteristics) / Plumb's Veterinary Drug Handbook

BEGIN;

-- 1. Carprofeno
UPDATE public.medicamentos
SET 
  precauciones = 'Monitorear función renal y hepática. Evitar uso en pacientes deshidratados, hipovolémicos, hipotensos o con trastornos de la coagulación. No combinar con otros AINEs ni corticoides.',
  embarazo_lactancia = 'Contraindicado en hembras gestantes o en lactancia. No se ha demostrado su seguridad en la reproducción.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%carprofeno%';

-- 2. Meloxicam (AINE)
UPDATE public.medicamentos
SET 
  precauciones = 'Evitar en animales deshidratados, hipovolémicos o hipotensos por riesgo de nefrotoxicidad. Monitorear síntomas gastrointestinales (vómitos, diarrea, melena). No administrar junto con otros AINEs ni glucocorticoides.',
  embarazo_lactancia = 'Contraindicado en animales gestantes o en lactancia. Riesgo de toxicidad fetal y alteración de la implantación.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%meloxicam%';

-- 3. Enrofloxacina (Fluoroquinolona)
UPDATE public.medicamentos
SET 
  precauciones = 'Riesgo de daño en el cartílago articular (artropatía) en cachorros en fase de crecimiento activo (evitar en <8 meses en razas pequeñas/medianas y <18 meses en razas gigantes). Ajustar dosis en falla renal.',
  embarazo_lactancia = 'Usar con extrema precaución en gestación sólo si el beneficio supera el riesgo. Puede producir anormalidades en el desarrollo cartilaginoso de los fetos.',
  fuente = 'VMD UK SPC / Plumbs Veterinary'
WHERE nombre ILIKE '%enrofloxacina%';

-- 4. Prednisolona y Metilprednisolona (Corticoides)
UPDATE public.medicamentos
SET 
  precauciones = 'No suspender de forma abrupta (retirar progresivamente para evitar insuficiencia adrenal). Evitar en infecciones fúngicas o sistémicas sin cobertura antimicrobiana. Monitorear glucemia.',
  embarazo_lactancia = 'Contraindicado en gestación. Puede inducir parto prematuro o aborto en el último trimestre, y anomalías congénitas (paladar hendido) en el primer trimestre.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%prednisolona%';

-- 5. Dexametasona (Corticoide potente)
UPDATE public.medicamentos
SET 
  precauciones = 'Potente corticoide de acción prolongada. No usar de forma continua sin monitoreo. Contraindicado en úlceras corneales o gastrointestinales activa, e infecciones no controladas.',
  embarazo_lactancia = 'Contraindicado en hembras gestantes. Riesgo de reabsorción fetal, aborto e inducción de parto prematuro.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%dexametasona%';

-- 6. Ketoprofeno (AINE)
UPDATE public.medicamentos
SET 
  precauciones = 'Evitar en insuficiencia renal o hepática severa, úlceras gastrointestinales o deshidratación. Monitorear signos de sangrado digestivo. No asociar con otros AINEs.',
  embarazo_lactancia = 'No recomendado en hembras gestantes o lactantes debido a la inhibición de la síntesis de prostaglandinas.',
  fuente = 'VMD UK SPC'
WHERE nombre ILIKE '%ketoprofeno%';

COMMIT;
