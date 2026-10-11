-- Migración: más datos curados de seguridad clínica (Amoxicilina, Metronidazol, Maropitant,
-- Gabapentina, Ibuprofeno, Paracetamol, Fenbendazol, Ivermectina, Xilacina, Flunixin)
-- Fuentes: FDA DailyMed / VMD UK SPC / Plumb's Veterinary Drug Handbook

BEGIN;

-- 1. Amoxicilina (penicilina de amplio espectro)
UPDATE public.medicamentos
SET
  precauciones = 'Ajustar dosis en insuficiencia renal. No administrar junto con probenecid (eleva concentraciones). Cuidar en alergia a penicilinas y betalactámicos. Causa diarrea por alteración de flora.',
  embarazo_lactancia = 'Categoría C en gestación. Excretada en leche materna; puede causar diarrea o candidiasis en las crías.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%amoxicilina%';

-- 2. Metronidazol
UPDATE public.medicamentos
SET
  precauciones = 'Ajustar en insuficiencia hepática/renal. No usar de forma crónica ni en dosis altas (riesgo de neuropatía periférica y encefalopatía). Puede teñir la orina de oscuro.',
  embarazo_lactancia = 'Categoría C. Teratogénico en roedores; evitar en el primer trimestre. Excretada en leche (sabe amarga, puede causar anorexia).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%metronidazol%';

-- 3. Maropitant (Cerenia) - antiemético
UPDATE public.medicamentos
SET
  precauciones = 'No administrar por vía IV rápida (puede causar hipotensión y taquicardia). Ajustar en enfermedad hepática. No usar con otros antieméticos sin criterio veterinario.',
  embarazo_lactancia = 'Seguridad en gestación y lactancia no establecida. Usar solo si el beneficio justifica el riesgo potencial.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%maropitant%';

-- 4. Gabapentina
UPDATE public.medicamentos
SET
  precauciones = 'Ajustar dosis en insuficiencia renal. Produce sedación y ataxia transitoria al inicio. No suspender abruptamente si se usa crónico (retirar progresivamente).',
  embarazo_lactancia = 'Seguridad en gestación y lactancia no establecida (Categoría C). Consultar criterio veterinario.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%gabapentina%';

-- 5. Ibuprofeno - IMPORTANTE: TÓXICO en GATOS
UPDATE public.medicamentos
SET
  precauciones = 'RIESGO SEVERO de úlcera y hemorragia gastrointestinal. Contraindicado en gatos (toxicidad hepática, renal y GI fatal). Evitar en deshidratados, hipotensos y con falla renal. Solo usar en perros bajo estricta supervisión.',
  embarazo_lactancia = 'Contraindicado en gestación (riesgo de cierre prematuro del conducto arterioso en el feto) y lactancia.',
  contraindicaciones = 'CONTRAINDICADO EN GATOS. Ulceras/gastritis activa, insuficiencia renal o hepática, deshidratación, trastornos de la coagulación, gestación, lactancia, y antes de cirugías.',
  efectos_secundarios = 'Vómitos, diarrea, sangre en heces/orina, pérdida de apetito, ictericia (gatos), letargo, úlceras gástricas y renales.',
  interacciones = 'No combinar con otros AINEs ni corticosteroides (riesgo gastrointestinal severo). Anticoagulantes (sangrado), metotrexato (toxicidad), litio y ciclosporina (niveles elevados).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%ibuprofeno%';

-- 6. Paracetamol - IMPORTANTE: INTOXICACIÓN FATAL en GATOS
UPDATE public.medicamentos
SET
  precauciones = 'GATOS: INTÓXICACIÓN GRAVE Y FATAL (no glucuronidan el fármaco -> metahemoglobinemia, edema facial y de patas, ictericia, muerte). Alergia frecuente en caballos. Cuidar con enfermedad hepática.',
  embarazo_lactancia = 'Seguridad en gestación y lactancia no establecida. Evitar. Consultar criterio veterinario.',
  contraindicaciones = 'CONTRAINDICADO EN GATOS (fatal). Hepatopatía severa. Glomulonefritis. Alergia a paracetamol en caballos.',
  efectos_secundarios = 'Gatos: edema de cara y patas, dificultad respiratoria, coloración marrón de mucosas (metahemoglobinemia), ictericia, muerte. Perros: vómito, dolor hepático, ictericia.',
  interacciones = 'No combinar con fenobarbital, fenitoína o rifampicina (toxicidad hepática aumentada). Warfarina (efecto anticoagulante disminuido). Colestiramina (absorción reducida).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%paracetamol%';

-- 7. Fenbendazol - antiparasitario de amplio espectro
UPDATE public.medicamentos
SET
  precauciones = 'Baja toxicidad. No requiere ajustes por peso exacto. Ocasionalmente causa diarrea leve o anorexia transitoria.',
  embarazo_lactancia = 'Seguro en gestación y lactancia según fuentes veterinarias. Consultar criterio veterinario.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%fenbendazol%';

-- 8. Ivermectina - IMPORTANTE: raza Pastores (MDR1)
UPDATE public.medicamentos
SET
  precauciones = 'NEUROTOXICIDAD FATAL en razas con deficiencia MDR1 (Pastor Alemán, Collie, Shetland, Bobtail y mezclas). No usar concentraciones altas ni en esas razas. Excretada en leche. Cuidado en animales enfermos o ancianos.',
  embarazo_lactancia = 'Seguridad en gestación no plenamente establecida. Consultar criterio veterinario. No usar en hembras lactantes (se excreta en leche).',
  contraindicaciones = 'CONTRAINDICADO en razas sensibles a ivermectina (MDR1/ABCB1) con dosis antiparasitarias altas. Diarrea o úlceras gastrointestinales. Lactancia. Hipersensibilidad.',
  efectos_secundarios = 'Miosis, salivación, vómito, ataxia, mioclonias, ceguera, coma y muerte (neurotoxicidad), especialmente en razas sensibles.',
  interacciones = 'Aumentan neurotoxicidad: espirometrina, milbemicina, moxidectina, abamectina. Ciclosporina (niveles elevados). Digitálicos (toxicidad).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%ivermectina%';

-- 9. Xilacina - sedante alpha-2 - IMPORTANTE: TÓXICO en GATOS
UPDATE public.medicamentos
SET
  precauciones = 'Depresión cardiovascular y respiratoria. Monitorizar ECG y presión arterial. Vómito frecuente en perros (premedicar con antiemético). Causa hiperglucemia y diuresis. No usar en animales descompensados.',
  embarazo_lactancia = 'Contraindicado en gestación (efecto abortivo y teratogénico reportado) y lactancia.',
  contraindicaciones = 'CONTRAINDICADO EN GATOS (puede ser fatal). Hipotensión severa, insuficiencia cardíaca, enfermedad hepática/renal avanzada. Glaucoma.',
  efectos_secundarios = 'Sedación, bradicardia, hipotensión, hiperglucemia, diuresis, vómito (perros), salivación, temblor, miosis y depresión respiratoria.',
  interacciones = 'No combinar con betabloqueantes o antihipertensivos (antagonismo). Aumenta la depresión con opioides, benzodiacepinas y anestésicos. Fenotiazinas (hipotensión severa).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%xilacina%';

-- 10. Flunixin Meglumina (Banamine)
UPDATE public.medicamentos
SET
  precauciones = 'RIESGO de úlcera gastrointestinal y nefrotoxicidad. No combinar con otros AINEs ni corticosteroides. Evitar en animales deshidratados, hipotensos o con falla renal.',
  embarazo_lactancia = 'Contraindicado en gestación (riesgo de aborto y falla placentaria) y lactancia.',
  contraindicaciones = 'Ulceras o hemorragia gastrointestinal, insuficiencia renal/hepática severa, deshidratación, trastornos de la coagulación, gestación y lactancia, y antes de cirugía.',
  efectos_secundarios = 'Vómitos, diarrea, sangre en heces, úlceras gástricas, insuficiencia renal, alcalosis metabólica y shock anafiláctico (raro).',
  interacciones = 'No usar con corticosteroides u otros AINEs (riesgo gastrointestinal severo). Anticoagulantes orales (sangrado). Diuréticos (toxicidad renal). Litio (niveles elevados).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%flunixin%';

COMMIT;
