-- Migración: cardiovasculares (IECA, betabloqueantes, calcio antagonistas,
-- digitálicos, diuréticos, prostaglandinas oculares) y vitaminas
-- Fuentes: FDA DailyMed / VMD UK SPC / Plumb's Veterinary Drug Handbook

BEGIN;

-- ── IECA (Captopril, Enalapril, Ramipril, Lisinopril) ─────────────
UPDATE public.medicamentos SET
  precauciones = 'Monitorear presión arterial, función renal y potasio. Riesgo de hipotensión en deshidratados. No combinar con AINEs (riesgo renal).',
  embarazo_lactancia = 'CONTRAINDICADO en gestación (teratogénico). Riesgo de muerte fetal.',
  contraindicaciones = 'Hipersensibilidad a IECA, estenosis de arteria renal bilateral, gestación.',
  efectos_secundarios = 'Hipotensión, tos seca, hiperpotasemia, hiponatremia, erupción cutánea.',
  interacciones = 'AINEs (reducen efecto, riesgo renal), diuréticos ahorradores de potasio, suplementos de potasio, litio.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%captopril%' OR nombre ILIKE '%enalapril%' OR nombre ILIKE '%ramipril%' OR nombre ILIKE '%lisinopril%';

-- ── BETABLOQUEANTES (Carvedilol, Metoprolol, Propranolol, Atenolol, Sotalol) ──
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de bradicardia, hipotensión y fatiga. No suspender abruptamente (taquicardia rebound). Cuidado en asma (no selectivos), falla cardíaca descompensada y diabetes (enmascara hipoglucemia).',
  embarazo_lactancia = 'Categoría C. Riesgo de retraso de crecimiento intrauterino. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, bloqueo AV, bradicardia severa, cardiopatía descompensada, asma (betabloqueantes no selectivos).',
  efectos_secundarios = 'Bradicardia, hipotensión, fatiga, mareos, broncoespasmo (no selectivos), insomnio.',
  interacciones = 'Otros depresores del SNC, AINEs (hipotensión), insulina (enmascara hipoglucemia), antidepresivos tricíclicos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%carvedilol%' OR nombre ILIKE '%metoprolol%' OR nombre ILIKE '%propranolol%' OR nombre ILIKE '%atenolol%' OR nombre ILIKE '%sotalol%';

-- ── BLOQUEANTES DEL CANAL CALCIO (Verapamil, Diltiazem, Nifedipina, Felodipino) ──
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de bradicardia e hipotensión. No usar con betabloqueantes (bradicardia severa). Cuidado en falla cardíaca.',
  embarazo_lactancia = 'Seguridad no establecida. Usar si el beneficio justifica el riesgo.',
  contraindicaciones = 'Hipersensibilidad, bloqueo AV, hipotensión severa, cardiopatía descompensada.',
  efectos_secundarios = 'Bradicardia, hipotensión, edema periférico, estreñimiento, enrojecimiento facial.',
  interacciones = 'Betabloqueantes (bradicardia severa), digoxina (niveles elevados), warfarina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%verapamil%' OR nombre ILIKE '%diltiazem%' OR nombre ILIKE '%nifedipina%' OR nombre ILIKE '%felodipino%';

-- ── DIGOXINA (ventana estrecha) ───────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Ventana terapéutica estrecha. Monitorear niveles séricos y ECG. Riesgo de arritmias. Ajustar en falla renal. Mantener potasio normal (la hipopotasemia aumenta toxicidad).',
  embarazo_lactancia = 'Categoría C. Riesgo de arritmia fetal. Usar solo si el beneficio supera el riesgo.',
  contraindicaciones = 'Hipersensibilidad, arritmias ventriculares, miocardiopatía hipertrófica obstructiva.',
  efectos_secundarios = 'Náuseas, vómito, visión amarillenta, arritmias (flutter/fibrilación auricular), hipopotasemia, diarrea.',
  interacciones = 'Diuréticos (hipopotasemia aumenta toxicidad), AINEs (riesgo de arritmia), IECA (hipotensión), betabloqueantes (bradicardia).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%digoxina%' OR nombre ILIKE '%lanoxina%';

-- ── ESPIRONOLACTONA (ahorrador de potasio) ──────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de hiperpotasemia y arritmias. Monitorear potasio. Cuidado en falla renal. Efecto antiandrogénico (ginecomastia).',
  embarazo_lactancia = 'Categoría C. Riesgo de efectos hormonales fetales. Consultar criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, hiperpotasemia, enfermedad de Addison, insuficiencia renal severa.',
  efectos_secundarios = 'Hiperpotasemia, ginecomastia, irregularidades hormonales, hipotensión, somnolencia.',
  interacciones = 'IECA (hiperpotasemia), suplementos de potasio, ciclosporina (hiperpotasemia), digoxina (niveles).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%espironolactona%';

-- ── DIURÉTICOS (Furosemida, Torsemida) ─────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de deshidratación, hipopotasemia e hiponatremia. Monitorear electrolitos y función renal. Cuidado en falla hepática, asma e hipovolemia.',
  embarazo_lactancia = 'Seguridad no establecida. Riesgo de hipovolemia fetal. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, anuria, edema pulmonar severo no compensado.',
  efectos_secundarios = 'Diuresis, pérdida de electrolitos, hipotensión, polidipsia, vómito, ototoxicidad (altas dosis IV).',
  interacciones = 'Digoxina (hipopotasemia aumenta toxicidad), IECA (riesgo renal), AINEs (riesgo renal), aminoglucósidos (ototoxicidad).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%furosemida%' OR nombre ILIKE '%torsemida%';

-- ── PROSTAGLANDINAS OCULARES (Latanoprost, Bimatoprost, Travoprost) ──
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de cambios en la pigmentación del iris y crecimiento de pestañas. Evitar en glaucoma de ángulo cerrado. Cuidado en inflamación ocular (uveitis).',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Glaucoma de ángulo cerrado, herpes ocular activo, uveitis, hipersensibilidad.',
  efectos_secundarios = 'Rojo ocular, hiperemia conjuntival, pigmentación del iris, crecimiento de pestañas, dolor ocular.',
  interacciones = 'Otros antihipertensivos oculares (suma de efectos).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%latanoprost%' OR nombre ILIKE '%bimatoprost%' OR nombre ILIKE '%travoprost%';

-- ── VITAMINAS Y SUPLEMENTOS ─────────────────────────────────────
-- Biotina, Colina, Cromo, D-pantenol, Melatonina, Niacina, Piridoxina
UPDATE public.medicamentos SET
  precauciones = 'Bajo riesgo en dosis adecuadas. Melatonina: sedación y efectos hormonales. Niacina: enrojecimiento cutáneo. Usar según indicación.',
  embarazo_lactancia = 'Seguridad no establecida para cada uno. Usar si el beneficio justifica el riesgo.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Vómito, diarrea, rash, sedación (melatonina), enrojecimiento (niacina).',
  interacciones = 'Depresores del SNC (sedación aditiva con melatonina), inductores/inhibidores enzimáticos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%biotina%' OR nombre ILIKE '%colina%' OR nombre ILIKE '%cromo%' OR nombre ILIKE '%d-pantenol%' OR nombre ILIKE '%melatonina%' OR nombre ILIKE '%niacina%' OR nombre ILIKE '%piridoxina%';

COMMIT;
