-- Migración: fármacos de uso común (opioides, AINEs, cardiovasculares,
-- antihistamínico, inmunosupresor, antídoto, psicotrópicos)
-- Fuentes: FDA DailyMed / VMD UK SPC / Plumb's Veterinary Drug Handbook

BEGIN;

-- ── OPIOIDES ─────────────────────────────────────────────────────
-- Buprenorfina (agonista parcial) y Butorfanol (agonista-antagonista)
UPDATE public.medicamentos SET
  precauciones = 'Analgésico opioide. Sedación y depresión respiratoria. Cuidado en enfermedad hepática/renal. No combinar con otros depresores del SNC. Puede antagonizar opioides puros.',
  embarazo_lactancia = 'Categoría C. Riesgo de depresión respiratoria neonatal. Usar solo si el beneficio justifica el riesgo.',
  contraindicaciones = 'Hipersensibilidad, depresión respiratoria severa, tratamiento simultáneo con agonistas opioides puros (antagonismo).',
  efectos_secundarios = 'Sedación, depresión respiratoria, miosis, hipotensión, bradicardia, salivación (gatos), vómito.',
  interacciones = 'Depresores del SNC (sedantes, anestésicos), agonistas opioides puros (antagonismo), IMAO.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%buprenorfina%' OR nombre ILIKE '%butorfanol%';

-- ── ASPIRINA (CRÍTICO: tóxica en gatos) ─────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'RIESGO de úlcera y hemorragia GI. TÓXICA EN GATOS (carecen de glucuronidación: dosis letales bajas). No usar en deshidratados, falla renal o trastornos de coagulación. Solo bajo criterio veterinario estricto.',
  embarazo_lactancia = 'Contraindicado en gestación (riesgo de cierre prematuro del conducto arterioso y hemorragia) y lactancia.',
  contraindicaciones = 'CONTRAINDICADO EN GATOS (toxicidad severa). Úlcera GI, insuficiencia renal/hepática, trastornos de coagulación, gestación, lactancia.',
  efectos_secundarios = 'Vómitos, diarrea, sangre en heces, úlceras GI, hemorragia, toxicidad hepática (gatos).',
  interacciones = 'Corticoides y otros AINEs (riesgo GI severo), anticoagulantes (sangrado), metotrexato, IECA (riesgo renal).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%aspirina%';

-- ── CIMICOXIB (AINE coxib) ──────────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de úlcera GI y nefrotoxicidad. No combinar con otros AINEs ni corticoides. Evitar en deshidratados. Ajustar en falla renal/hepática.',
  embarazo_lactancia = 'No recomendado en gestación ni lactancia.',
  contraindicaciones = 'Úlcera GI, insuficiencia renal/hepática, deshidratación, trastornos de coagulación, gestación.',
  efectos_secundarios = 'Vómitos, diarrea, pérdida de apetito, úlceras GI, letargo.',
  interacciones = 'Otros AINEs, corticoides, anticoagulantes, diuréticos, IECA.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%cimicoxib%';

-- ── CETIRIZINA (antihistamínico) ────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Sedación leve. Cuidado en glaucoma, retención urinaria y enfermedad hepática. No usar con otros depresores del SNC.',
  embarazo_lactancia = 'Categoría B. Seguridad no establecida en veterinaria.',
  contraindicaciones = 'Hipersensibilidad, glaucoma de ángulo cerrado, retención urinaria.',
  efectos_secundarios = 'Sedación, sequedad de mucosas, vómito, diarrea.',
  interacciones = 'Depresores del SNC, anticolinérgicos, sedantes.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%cetirizina%';

-- ── CARDIOVASCULARES ─────────────────────────────────────────────
-- Amlodipino (calcio antagonista)
UPDATE public.medicamentos SET
  precauciones = 'Hipotensión. Monitorear presión arterial. Cuidado en falla hepática. No suspender abruptamente.',
  embarazo_lactancia = 'Categoría C. Seguridad no establecida.',
  contraindicaciones = 'Hipotensión severa, hipersensibilidad, shock.',
  efectos_secundarios = 'Hipotensión, letargo, taquicardia refleja, edema.',
  interacciones = 'Otros antihipertensivos (hipotensión), betabloqueantes, digoxina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%amlodipino%';

-- Benazepril (IECA)
UPDATE public.medicamentos SET
  precauciones = 'Monitorear presión arterial, función renal y potasio. Riesgo de hipotensión en deshidratados. Cuidado en estenosis renal bilateral.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico, toxicidad fetal).',
  contraindicaciones = 'Hipersensibilidad a IECA, estenosis de arteria renal bilateral, embarazo.',
  efectos_secundarios = 'Hipotensión, vómito, diarrea, letargo, hiperpotasemia, deterioro renal.',
  interacciones = 'Diuréticos (hipotensión), AINEs (reducen efecto, riesgo renal), suplementos de potasio, espironolactona.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%benazepril%';

-- Clopidogrel (antiagregante plaquetario)
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de sangrado. Monitorear signos de hemorragia. Cuidado en trastornos de coagulación, úlcera GI y cirugías. Ajustar en falla hepática.',
  embarazo_lactancia = 'Categoría B. Seguridad no establecida.',
  contraindicaciones = 'Hemorragia activa, trastornos hemorrágicos, hipersensibilidad.',
  efectos_secundarios = 'Sangrado, hematomas, vómito, diarrea, pérdida de apetito.',
  interacciones = 'AINEs, anticoagulantes, corticoides (riesgo de sangrado), omeprazol (reduce activación).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%clopidogrel%';

-- ── CICLOSPORINA (inmunosupresor) ───────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Inmunosupresor: riesgo de infecciones y neoplasias. Monitorear función renal, hepática y presión arterial. No usar con vacunas vivas.',
  embarazo_lactancia = 'Categoría C. Riesgo de toxicidad fetal. Consultar criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, neoplasia activa, infección no controlada, vacunas vivas.',
  efectos_secundarios = 'Vómito, diarrea, anorexia, hiperplasia gingival, hirsutismo, infecciones, nefrotoxicidad.',
  interacciones = 'Nefrotóxicos, aminoglucósidos, anfotericina B, ketoconazol (niveles elevados), rifampicina (niveles reducidos).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%ciclosporina%';

-- ── ACETILCISTEÍNA (antídoto de paracetamol) ────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Antídoto de paracetamol (INTOXICACIÓN FATAL EN GATOS). Administrar temprano (ideal ≤8h). Diluir para uso IV. Cuidado en asma o úlcera GI (vía oral).',
  embarazo_lactancia = 'Categoría B. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, asma severa (relativa).',
  efectos_secundarios = 'Vómito, diarrea, náuseas, reacciones anafilactoides IV (raro).',
  interacciones = 'Carbón activado (reduce absorción oral), nitroglicerina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%acetilcisteína%';

-- ── ALOPURINOL (antihiperuricémico) ──────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Ajustar en falla renal. Riesgo de reacciones de hipersensibilidad severas. Hidratación adecuada. Usar con IECA puede aumentar el riesgo de hipersensibilidad.',
  embarazo_lactancia = 'Categoría C. Seguridad no establecida.',
  contraindicaciones = 'Hipersensibilidad a alopurinol, insuficiencia renal severa (relativa).',
  efectos_secundarios = 'Vómito, diarrea, rash, hipersensibilidad, elevación de enzimas hepáticas.',
  interacciones = 'Azatioprina (aumenta toxicidad), IECA (hipersensibilidad), teofilina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%alopurinol%';

-- ── PSICOTRÓPICOS / ANTIDEPRESIVOS TRICÍCLICOS ─────────────────
-- Amitriptilina y Clomipramina
UPDATE public.medicamentos SET
  precauciones = 'Cuidado en cardiopatía, glaucoma, retención urinaria e hipertiroidismo. No suspender abruptamente. Riesgo de arritmias. Cuidado en gatos (sensibilidad).',
  embarazo_lactancia = 'Categoría C. Seguridad no establecida.',
  contraindicaciones = 'Hipersensibilidad, tratamiento con IMAO, cardiopatía severa, glaucoma de ángulo cerrado.',
  efectos_secundarios = 'Sedación, sequedad de mucosas, retención urinaria, estreñimiento, taquicardia, arritmias, vómito.',
  interacciones = 'IMAO (síndrome serotoninérgico), anticolinérgicos, sedantes, antiarrítmicos, simpaticomiméticos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%amitriptilina%' OR nombre ILIKE '%clomipramina%';

-- ── ALPRAZOLAM (benzodiacepina) ──────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Sedación y dependencia. No suspender abruptamente (síndrome de abstinencia). Cuidado en enfermedad hepática/renal. Puede causar excitación paradójica en algunos animales.',
  embarazo_lactancia = 'Categoría D. Riesgo de defectos congénitos. Evitar.',
  contraindicaciones = 'Hipersensibilidad, glaucoma de ángulo cerrado, tratamiento con ketoconazol/itraconazol (inhibidores CYP3A4).',
  efectos_secundarios = 'Sedación, ataxia, aumento de apetito, excitación paradójica, dependencia.',
  interacciones = 'Depresores del SNC, ketoconazol/itraconazol (niveles elevados), IMAO, opioides.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%alprazolam%';

COMMIT;
