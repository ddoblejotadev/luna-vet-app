-- Migración final: completar 10 fármacos con datos parciales
-- (AINEs, dipirona, metoclopramida, omeprazol, ondansetrón, tramadol)
-- Fuentes: FDA DailyMed / VMD UK SPC / Plumb's Veterinary Drug Handbook

BEGIN;

-- ── AINEs (Carprofeno, Ketoprofeno, Ketoprofeno oral, Meloxicam, Meloxicam inyectable) ──
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de úlcera GI y nefrotoxicidad. Carprofeno/Meloxicam: NO USAR EN GATOS (toxicidad severa). No combinar con otros AINEs ni corticoides. Cuidado en deshidratados, falla renal/hepática.',
  embarazo_lactancia = 'CONTRAINDICADO en gestación (riesgo de cierre prematuro del conducto arterioso) y lactancia.',
  contraindicaciones = 'Úlcera GI, insuficiencia renal/hepática, deshidratación, trastornos de coagulación, gestación. Carprofeno/Meloxicam: gatos (toxicidad severa).',
  efectos_secundarios = 'Vómitos, diarrea, pérdida de apetito, úlceras GI, insuficiencia renal, letargo.',
  interacciones = 'Otros AINEs, corticoides, anticoagulantes, diuréticos, IECA.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%carprofeno%' OR nombre ILIKE '%ketoprofeno%' OR nombre ILIKE '%meloxicam%';

-- ── DICLOFENACO (AINE, oftálmico/tópico) ──────────
UPDATE public.medicamentos SET
  precauciones = 'AINE. Riesgo de úlcera GI y nefrotoxicidad. Tópico oftálmico: cuidado en queratitis y cirugía corneal. Evitar en embarazo avanzado (cierre conducto arterioso).',
  embarazo_lactancia = 'CONTRAINDICADO en gestación avanzada.',
  contraindicaciones = 'Úlcera GI, insuficiencia renal/hepática, queratitis (oftálmico), gestación avanzada.',
  efectos_secundarios = 'Vómitos, diarrea, úlceras GI, ardor ocular (oftálmico), úlcera corneal.',
  interacciones = 'Otros AINEs, corticoides, anticoagulantes, diuréticos, IECA, otros AINEs tópicos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%diclofenaco%';

-- ── DIPIRONA (metamizol) ──────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Analgésico/antipirético (pirazolona). Riesgo de AGRANULOCITOSIS (raro pero grave). No usar en trastornos sanguíneos. Cuidado en falla hepática/renal. Hipotensión (IV rápida).',
  embarazo_lactancia = 'Categoría C. Evitar en gestación (riesgo de daño fetal). Consultar criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad a pirazolonas, trastornos sanguíneos, gestación.',
  efectos_secundarios = 'Hipotensión (IV rápida), agranulocitosis (raro), vómito, diarrea, sedación.',
  interacciones = 'Otros depresores del SNC, anticoagulantes, fármacos mielosupresores.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%dipirona%';

-- ── METOCLOPRAMIDA (proquinético/antiemético) ──────────
UPDATE public.medicamentos SET
  precauciones = 'Proquinético/antiemético (antagonista dopamina). Efectos extrapiramidales (dosis altas). No usar en obstrucción GI, hemorragia GI, feocromocitoma. Cuidado en epilepsia.',
  embarazo_lactancia = 'Categoría B. Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Obstrucción GI, hemorragia GI, feocromocitoma, epilepsia, hipersensibilidad.',
  efectos_secundarios = 'Sedación, agitación, extrapiramidales (temblor, rigidez), diarrea, estreñimiento.',
  interacciones = 'Atropina (antagonismo proquinético), opioides, fenotiazinas (extrapiramidales), IMAO.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%metoclopramida%';

-- ── OMEPRAZOL (IBP) ───────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Inhibidor de bomba de protones. Uso crónico: riesgo de infecciones y malabsorción de B12/magnesio. Metabolismo CYP (interacciones).',
  embarazo_lactancia = 'Categoría C. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Cefalea, diarrea, náuseas, dolor abdominal, mareos.',
  interacciones = 'Ketoconazol/itraconazol (absorción reducida), clopidogrel (activación reducida), diazepam, warfarina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%omeprazol%';

-- ── ONDANSETRÓN (antiemético 5-HT3) ──────────────────
UPDATE public.medicamentos SET
  precauciones = 'Antiemético (antagonista 5-HT3). Prolonga QT. Cuidado en cardiopatía, QT prolongado y falla hepática.',
  embarazo_lactancia = 'Categoría B. Seguridad no establecida en veterinaria.',
  contraindicaciones = 'Hipersensibilidad, QT prolongado (relativa).',
  efectos_secundarios = 'Cefalea, estreñimiento, sedación, prolongación QT (raro).',
  interacciones = 'Otros QT-prolongadores, apomorfina (antagonismo), tramadol (reducción de efecto).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%ondansetrón%';

-- ── TRAMADOL (opioide atípico + serotoninérgico) ──────
UPDATE public.medicamentos SET
  precauciones = 'Analgésico opioide atípico (agonista μ débil + inhibe recaptación de serotonina/noradrenalina). SEDACIÓN y depresión respiratoria. Síndrome serotoninérgico con IMAO/ISRS. Cuidado en falla hepática/renal.',
  embarazo_lactancia = 'Categoría C. Riesgo de depresión respiratoria neonatal. Evitar.',
  contraindicaciones = 'Hipersensibilidad, IMAO (últimos 14 días), depresión respiratoria severa.',
  efectos_secundarios = 'Sedación, depresión respiratoria, disforia, vómito, estreñimiento, síndrome serotoninérgico (raro).',
  interacciones = 'Depresores del SNC, IMAO/ISRS/SNRI (serotoninérgico), carbamazepina (niveles reducidos), warfarina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%tramadol%';

COMMIT;