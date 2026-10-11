-- Migración: opioides, anestésicos (inyectables, inhalatorios, locales,
-- bloqueantes neuromusculares) y sedantes
-- Fuentes: FDA DailyMed / VMD UK SPC / Plumb's Veterinary Drug Handbook

BEGIN;

-- ── OPIOIDES (depresión respiratoria) ───────────────────────────────
-- Alfentanilo, Fentanilo, Hidromorfona, Metadona, Oxicodona, Oximorfona, Remifentanilo, Tapentadol
UPDATE public.medicamentos SET
  precauciones = 'Analgésico opioide. SEDACIÓN y DEPRESIÓN RESPIRATORIA. Cuidado en enfermedad hepática/renal. No combinar con otros depresores del SNC. Dosis ajustada a especie (gatos sensibles).',
  embarazo_lactancia = 'Categoría C. Riesgo de depresión respiratoria neonatal. Usar solo si el beneficio justifica el riesgo.',
  contraindicaciones = 'Hipersensibilidad, depresión respiratoria severa, tratamiento con agonistas opioides parciales.',
  efectos_secundarios = 'Sedación, depresión respiratoria, miosis, hipotensión, bradicardia, vómito, salivación (gatos).',
  interacciones = 'Depresores del SNC (sedantes, anestésicos), IMAO, agonistas opioides parciales (antagonismo).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%alfentanilo%' OR nombre ILIKE '%fentanilo%' OR nombre ILIKE '%hidromorfona%' OR nombre ILIKE '%metadona%' OR nombre ILIKE '%oxicodona%' OR nombre ILIKE '%oximorfona%' OR nombre ILIKE '%remifentanilo%' OR nombre ILIKE '%tapentadol%';

-- ── ANESTÉSICOS INYECTABLES (inducción) ──────────────────────────
-- Alfaxalona, Ketamina, Propofol, Tiopental, Tiletamina + Zolazepam
UPDATE public.medicamentos SET
  precauciones = 'Uso exclusivo en anestesia con monitorización. Depresión respiratoria y cardiovascular. Ajustar por estado físico. Ketamina: evitar en epilepsia, hipertensión y GEP. Propofol: no en hipovolemia.',
  embarazo_lactancia = 'Seguridad no establecida. Usar solo si el beneficio justifica el riesgo.',
  contraindicaciones = 'Hipersensibilidad, depresión respiratoria, hipovolemia (propofol), epilepsia (ketamina), hipertensión (ketamina).',
  efectos_secundarios = 'Sedación, depresión respiratoria, hipotensión, arritmias, excitación (ketamina), apnea (propofol), espasmos (alfaxalona).',
  interacciones = 'Depresores del SNC, anestésicos, opioides, relajantes musculares.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%alfaxalona%' OR nombre ILIKE '%ketamina%' OR nombre ILIKE '%propofol%' OR nombre ILIKE '%tiopental%' OR nombre ILIKE '%tiletamina%';

-- ── ANESTÉSICOS INHALATORIOS ───────────────────────────────────────
-- Desflurano, Isoflurano, Sevoflurano
UPDATE public.medicamentos SET
  precauciones = 'Anestesia con monitorización. Depresión respiratoria y cardiovascular. Evitar en hipertermia maligna. Sevoflurano: riesgo de nefrotoxicidad con cal sodado (compuesto A).',
  embarazo_lactancia = 'Seguridad no establecida. Riesgo de aborto por exposición ocupacional crónica.',
  contraindicaciones = 'Hipertermia maligna, hipersensibilidad.',
  efectos_secundarios = 'Depresión respiratoria, hipotensión, arritmias, hipotermia, irritación de vías aéreas (desflurano).',
  interacciones = 'Depresores del SNC, relajantes musculares (potenciación), opioides.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%desflurano%' OR nombre ILIKE '%isoflurano%' OR nombre ILIKE '%sevoflurano%';

-- ── BLOQUEANTES NEUROMUSCULARES ──────────────────────────────────
-- Atracurio, Cisatracurio, Rocuronio, Succinilcolina
UPDATE public.medicamentos SET
  precauciones = 'BLOQUEANTE NEUROMUSCULAR: requiere ventilación asistida. Monitorizar. Atracurio/cisatracurio: liberación de histamina. Succinilcolina: riesgo de hiperpotasemia e hipertermia maligna.',
  embarazo_lactancia = 'Seguridad no establecida. Usar solo en anestesia justificada.',
  contraindicaciones = 'Hipersensibilidad, miastenia gravis, quemaduras (succinilcolina), hipertermia maligna.',
  efectos_secundarios = 'Parálisis muscular, liberación de histamina, hipotensión, arritmias, bradicardia.',
  interacciones = 'Anestésicos inhalatorios (potenciación), aminoglucósidos (potenciación), anticolinérgicos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%atracurio%' OR nombre ILIKE '%cisatracurio%' OR nombre ILIKE '%rocuronio%' OR nombre ILIKE '%succinilcolina%';

-- ── ANESTÉSICOS LOCALES (toxicidad sistémica) ─────────────────────
-- Bupivacaína, Levobupivacaína, Lidocaína, Ropivacaína, Tetracaína
UPDATE public.medicamentos SET
  precauciones = 'Toxicidad sistémica (cardiovascular y neurológica) si se absorbe en exceso. No usar en tejidos infectados. Aspirar antes de inyectar. Cuidado en bloqueos regionales (dosis máxima).',
  embarazo_lactancia = 'Categoría B/C según fármaco. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, bloqueo cardíaco severo (bupivacaína), aplicación IV accidental.',
  efectos_secundarios = 'Toxicidad sistémica: convulsiones, arritmias, hipotensión, paro cardíaco. Sedación local.',
  interacciones = 'Otros anestésicos locales (toxicidad aditiva), antiarrítmicos, depresores del SNC.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%bupivacaína%' OR nombre ILIKE '%levobupivacaína%' OR nombre ILIKE '%lidocaína%' OR nombre ILIKE '%ropivacaína%' OR nombre ILIKE '%tetracaína%';

-- ── NEOSTIGMINA (reversor NM) ────────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Inhibidor de colinesterasa. Riesgo de bradicardia y espasmos GI. Administrar con anticolinérgico (atropina/glicopirrolato). Cuidado en obstrucción GI/urinaria.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Obstrucción GI/urinaria, bradicardia, hipersensibilidad.',
  efectos_secundarios = 'Bradicardia, salivación, vómito, diarrea, espasmos musculares, broncoespasmo.',
  interacciones = 'Anticolinérgicos (requerido para uso), aminoglucósidos (antagonismo), betabloqueantes (bradicardia).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%neostigmina%';

-- ── NALOXONA (reversor opioide) ──────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Antagonista opioide puro. Revierte analgesia y sedación (síndrome de abstinencia). Vida media corta: riesgo de re-narcosis. Titular según respuesta clínica.',
  embarazo_lactancia = 'Categoría B. Usar solo si justificado (reversión de sobredosis).',
  contraindicaciones = 'Hipersensibilidad, dependencia opioide conocida (abstinencia aguda).',
  efectos_secundarios = 'Abstinencia opioide aguda (agitación, vómito, taquicardia), hipotensión, arritmias.',
  interacciones = 'Opioides (antagonismo), agonistas parciales (antagonismo incompleto).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%naloxona%';

-- ── SEDANTES / BENZODIAZEPINAS ───────────────────────────────────
-- Diazepam, Midazolam
UPDATE public.medicamentos SET
  precauciones = 'Sedación y dependencia. No suspender abruptamente (síndrome de abstinencia). Cuidado en enfermedad hepática. Midazolam: más potente, vía IV rápida. Puede causar excitación paradójica.',
  embarazo_lactancia = 'Categoría D. Riesgo de defectos congénitos. Evitar.',
  contraindicaciones = 'Hipersensibilidad, glaucoma de ángulo cerrado, depresión respiratoria severa.',
  efectos_secundarios = 'Sedación, ataxia, aumento de apetito, excitación paradójica, dependencia, depresión respiratoria.',
  interacciones = 'Depresores del SNC, opioides, ketoconazol/itraconazol (niveles elevados), IMAO.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%diazepam%' OR nombre ILIKE '%midazolam%';

-- ── AGONISTAS ALPHA-2 (Dexmedetomidina, Medetomidina) ─────────────
UPDATE public.medicamentos SET
  precauciones = 'Agonista alpha-2. Depresión cardiovascular y respiratoria. Hipotensión y bradicardia. No usar en cardiopatía, diabetes, embarazo. Reversible con atipamezol.',
  embarazo_lactancia = 'Contraindicado en gestación (efecto abortivo) y lactancia.',
  contraindicaciones = 'Insuficiencia cardíaca, diabetes, gestación, lactancia, hipersensibilidad.',
  efectos_secundarios = 'Sedación, hipotensión, bradicardia, hipotermia, hiperglucemia, diuresis, vómito.',
  interacciones = 'Betabloqueantes (bradicardia severa), opioides, anestésicos (potenciación), fenotiazinas.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%dexmedetomidina%' OR nombre ILIKE '%medetomidina%';

COMMIT;
