-- Migración: gastrointestinales y endocrinos
-- Fuentes: FDA DailyMed / VMD UK SPC / Plumb's Veterinary Drug Handbook

BEGIN;

-- ── BLOQUEANTES H2 (Cimetidina, Famotidina, Ranitidina) ─────
UPDATE public.medicamentos SET
  precauciones = 'Reducen secreción ácida. Cimetidina: inhibidor CYP450 (interacciones). Cuidado en falla renal.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Cefalea, diarrea, estreñimiento, confusión (cimetidina).',
  interacciones = 'Warfarina, fenitoína, teofilina (cimetidina eleva niveles).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%cimetidina%' OR nombre ILIKE '%famotidina%' OR nombre ILIKE '%ranitidina%';

-- ── INHIBIDORES DE BOMBA DE PROTONES (Pantoprazol, Rabeprazol) ──
UPDATE public.medicamentos SET
  precauciones = 'Inhibidores de bomba de protones. Uso crónico: riesgo de infecciones y malabsorción de B12/magnesio.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Cefalea, diarrea, náuseas, dolor abdominal.',
  interacciones = 'Ketoconazol/itraconazol (absorción reducida por pH elevado).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%pantoprazol%' OR nombre ILIKE '%rabeprazol%';

-- ── CISAPRIDA (proquinético, prolonga QT) ───────────────
UPDATE public.medicamentos SET
  precauciones = 'Proquinético. PROLONGA QT. CONTRAINDICADA con inhibidores CYP3A4 (ketoconazol, eritromicina). Riesgo de arritmias fatales.',
  embarazo_lactancia = 'Categoría C. Evitar en gestación.',
  contraindicaciones = 'Prolongación QT, obstrucción GI, hemorragia GI.',
  efectos_secundarios = 'Diarrea, dolor abdominal, arritmias (QT).',
  interacciones = 'Inhibidores CYP3A4 (ketoconazol, eritromicina), antiarrítmicos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%cisaprida%';

-- ── DOMPERIDONA (proquinético) ───────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Proquinético. Prolonga QT. Cuidado en cardiopatía. Menor cruce de barrera hematoencefálica que metoclopramida.',
  embarazo_lactancia = 'Categoría C. Evitar en gestación.',
  contraindicaciones = 'Prolongación QT, cardiopatía, obstrucción GI.',
  efectos_secundarios = 'Diarrea, dolor abdominal, prolongación QT.',
  interacciones = 'Inhibidores CYP3A4, antiarrítmicos (QT).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%domperidona%';

-- ── LOPERAMIDA (antidiarreico, NO en gatos) ───────────────
UPDATE public.medicamentos SET
  precauciones = 'Antidiarreico. Evitar en colitis infecciosa (retiene toxinas). NO USAR EN GATOS (sensibilidad MDR1). Riesgo de estreñimiento severo.',
  embarazo_lactancia = 'Categoría B. Evitar en gestación.',
  contraindicaciones = 'Colitis infecciosa, obstrucción GI, gatos.',
  efectos_secundarios = 'Estreñimiento, distensión abdominal, letargo.',
  interacciones = 'Otros depresores del SNC, P-glicoproteína (MDR1).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%loperamida%';

-- ── MISOPROSTOL (abortivo) ──────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'PROSTAGLANDINA. ABORTIVO. CONTRAINDICADO en embarazo. Cuidado en cardiopatía. Manejar con guantes en mujeres embarazadas.',
  embarazo_lactancia = 'CONTRAINDICADO (abortivo).',
  contraindicaciones = 'Gestación, lactancia.',
  efectos_secundarios = 'Diarrea, vómito, dolor abdominal, aborto.',
  interacciones = 'AINEs (indicación conjunta: protección gástrica).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%misoprostol%';

-- ── SUCRALFATO (mucoprotector) ────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Casi inerte. Reduce absorción de otros fármacos (separar 2h). Baja toxicidad.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Estreñimiento, náuseas.',
  interacciones = 'Muchos fármacos (reduce absorción: quinolonas, tetraciclinas, fenitoína, warfarina).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%sucralfato%';

-- ── SAMe (hepatoprotector) ───────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Hepatoprotector. Cuidado en trastorno bipolar (mania). Baja toxicidad.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Náuseas, cefalea, insomnio.',
  interacciones = 'Antidepresivos (serotonina).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%same%';

-- ── URSODIOL (ácido biliar) ───────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Cálisis biliar. Cuidado en obstrucción biliar y colitis ulcerosa. Baja toxicidad.',
  embarazo_lactancia = 'Categoría B. Usar bajo criterio veterinario.',
  contraindicaciones = 'Obstrucción biliar, colitis ulcerosa.',
  efectos_secundarios = 'Diarrea, vómito.',
  interacciones = 'Calcio (reduce absorción), colestiramina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%ursodiol%';

-- ── CABERGOLINA (agonista dopaminérgico, abortivo) ──────────
UPDATE public.medicamentos SET
  precauciones = 'Agonista dopaminérgico. Cuidado en cardiopatía valvular e hipotensión. CONTRAINDICADO en embarazo (efecto abortivo).',
  embarazo_lactancia = 'CONTRAINDICADO (abortivo).',
  contraindicaciones = 'Gestación, cardiopatía valvular.',
  efectos_secundarios = 'Náuseas, hipotensión, mareos, alucinaciones.',
  interacciones = 'Fenotiazinas (antagonismo), eritromicina (niveles elevados).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%cabergolina%';

-- ── DESMOPRESINA (ADH, hiponatremia) ──────────────────────
UPDATE public.medicamentos SET
  precauciones = 'ADH sintética. Riesgo de HIPONATREMIA e intoxicación hídrica. Restringir líquidos. Ajustar en insuficiencia renal/cardíaca.',
  embarazo_lactancia = 'Categoría B. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hiponatremia, insuficiencia cardíaca/renal.',
  efectos_secundarios = 'Hiponatremia, cefalea, náuseas, retención hídrica.',
  interacciones = 'Diuréticos (suma), antidepresivos tricíclicos (potenciación).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%desmopresina%';

-- ── MINERALOCORTICOIDES (Desoxicorticosterona, Fludrocortisona) ──
UPDATE public.medicamentos SET
  precauciones = 'Mineralocorticoide. Hipopotasemia, hipernatremia, hipertensión. Monitorear electrolitos. No suspender abruptamente (crisis Addisoniana).',
  embarazo_lactancia = 'Categoría C. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, insuficiencia cardíaca, hipertensión.',
  efectos_secundarios = 'Hipertensión, hipopotasemia, hipernatremia, edema.',
  interacciones = 'Diuréticos ahorradores de potasio (hiperpotasemia), betabloqueantes (hipertensión).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%desoxicorticosterona%' OR nombre ILIKE '%fludrocortisona%';

-- ── FENILPROPANOLAMINA (vasopresor) ───────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Vasopresor (incontinencia urinaria). Cuidado en hipertensión, cardiopatía, hipertiroidismo y glaucoma.',
  embarazo_lactancia = 'Categoría C. Evitar en gestación.',
  contraindicaciones = 'Hipertensión, cardiopatía, hipertiroidismo, glaucoma.',
  efectos_secundarios = 'Hipertensión, taquicardia, arritmias, inquietud.',
  interacciones = 'Otros simpaticomiméticos, betabloqueantes, IMAO.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%fenilpropanolamina%';

-- ── LEVOTIROXINA (hormona tiroidea) ──────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Hipertiroidismo si sobredosis. Monitorear T4. Ajustar en cardiopatía (isquemia). No usar para pérdida de peso.',
  embarazo_lactancia = 'Categoría A. Segura en gestación (reemplazo).',
  contraindicaciones = 'Hipertiroidismo no tratado, infarto de miocardio agudo.',
  efectos_secundarios = 'Taquicardia, hipertensión, arritmias, pérdida de peso, vómito.',
  interacciones = 'Calcio/hierro (absorción reducida), warfarina (potenciación), betabloqueantes.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%levotiroxina%';

-- ── METIMAZOL (antitiroidiano, teratogénico) ────────────────
UPDATE public.medicamentos SET
  precauciones = 'Antitiroidiano. Agranulocitosis, hepatotoxicidad. Monitorear hemograma y función hepática. TERATOGÉNICO.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico).',
  contraindicaciones = 'Hipersensibilidad, enfermedad hepática severa.',
  efectos_secundarios = 'Agranulocitosis, hepatotoxicidad, vómito, anorexia, rash.',
  interacciones = 'Betabloqueantes (suma), warfarina (potenciación).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%metimazol%';

-- ── MITOTANO (adrenolítico, teratogénico) ─────────────────
UPDATE public.medicamentos SET
  precauciones = 'Adrenolítico (Cushing). Toxicidad GI y neurológica. TERATOGÉNICO. Monitorear función adrenal.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico).',
  contraindicaciones = 'Gestación, lactancia, enfermedad hepática/renal.',
  efectos_secundarios = 'Vómito, diarrea, anorexia, letargo, ataxia, insuficiencia suprarrenal.',
  interacciones = 'Fenobarbital (aumenta metabolismo), espironolactona (antagonismo).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%mitotano%';

-- ── TRILOSTANO (inhibidor adrenal, teratogénico) ───────────
UPDATE public.medicamentos SET
  precauciones = 'Inhibidor adrenal (Cushing). Cuidado en falla hepática/renal. Riesgo de crisis Addisoniana. TERATOGÉNICO.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico).',
  contraindicaciones = 'Gestación, insuficiencia hepática/renal.',
  efectos_secundarios = 'Vómito, diarrea, anorexia, letargo, crisis Addisoniana.',
  interacciones = 'Espironolactona (antagonismo), IECA (suma).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%trilostano%';

COMMIT;
