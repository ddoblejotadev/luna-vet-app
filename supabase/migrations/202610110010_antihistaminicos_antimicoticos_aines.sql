-- Migración: antihistamínicos, antifúngicos, AINEs y analgésicos
-- Fuentes: FDA DailyMed / VMD UK SPC / Plumb's Veterinary Drug Handbook

BEGIN;

-- ── ANTIFUNGICOS (Clotrimazol, Miconazol) ─────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Uso tópico o sistémico. Cuidado en hepatoxidad. Monitorizar enzimas hepáticas con uso sistémico. Evitar en embarazo salvo indicación urgente.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico/malformaciones). Riesgo de daño fetal.',
  contraindicaciones = 'Hipersensibilidad, gestación, lactancia.',
  efectos_secundarios = 'Elevación de enzimas hepáticas, dermatitis, quemadura, picazón.',
  interacciones = 'Otros antifúngicos (suma tóxica). Ciclosporina (niveles alterados).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%clotrimazol%' OR nombre ILIKE '%miconazol%';

-- ── ANTIHISTAMINICOS (12) ─────────────────────────────────────
-- Diphenhydramina, Fluconazol, Griseofulvina, Hidroxizina,
-- Itraconazol, Ketoconazol, Lokivetmab, Loratadina, Oclacitinib,
-- Prednisona, Terbinafina, Triamcinolona
-- Diphenhydramina: antialérgico sedante
UPDATE public.medicamentos SET
  precauciones = 'Antialérgico con efecto sedante. Cuidado en glaucoma, retención urinaria y enfermedad hepática. No usar con otros depresores del SNC.',
  embarazo_lactancia = 'Seguridad no establecida. Consultar criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, glaucoma de ángulo cerrado, retención urinaria.',
  efectos_secundarios = 'Sedación, sequedad de mucosas, vómito, diarrea.',
  interacciones = 'Depresores del SNC, otros anticolinérgicos, sedantes.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%diphenhydramina%';

-- Fluconazol: antifúngico oral/IV
UPDATE public.medicamentos SET
  precauciones = 'Hepatotoxico. Monitorear enzimas hepáticas. Teratogénico (Categoría D). Evitar en embarazo. Prolonga intervalo QT.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico). Riesgo de malformaciones fetales.',
  contraindicaciones = 'Hipersensibilidad, embarazo, QT prolongado.',
  efectos_secundarios = 'Elevación de enzimas hepáticas, náuseas, vómito, diarrea, prolongación QT.',
  interacciones = 'Otros fármacos QT-prolongadores, antiácidos (absorción reducida), warfarina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%fluconazol%';

-- Griseofulvina: antifúngico oral (dermatomicosis)
UPDATE public.medicamentos SET
  precauciones = 'Teratogénico. Evitar en gestación. Monitorizar función hepática. Puede causar alopecia transitoria. Sabor amargo.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico). Riesgo de daño fetal.',
  contraindicaciones = 'Gestación, enfermedad hepática severa.',
  efectos_secundarios = 'Alopecia transitoria, vómito, diarrea, rash cutáneo, fotosensibilidad.',
  interacciones = 'Terfenadina (aumenta toxicidad), cimetidina (absorción).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%griseofulvina%';

-- Hidroxizina: antihistamínico (psicosis, alergia)
UPDATE public.medicamentos SET
  precauciones = 'Antihistamínico con efecto sedante. Cuidado en glaucoma, retención urinaria, enfermedad cardiovascular. Evitar en animales con historial de convulsiones.',
  embarazo_lactancia = 'Categoría B. Seguridad no establecida.',
  contraindicaciones = 'Hipersensibilidad, glaucoma de ángulo cerrado, retención urinaria.',
  efectos_secundarios = 'Sedación, sequedad de mucosas, vómito, diarrea, hipotensión.',
  interacciones = 'Depresores del SNC, anticolinérgicos, otros antihistamínicos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%hidroxizina%';

-- Itraconazol: antifúngico sistémico
UPDATE public.medicamentos SET
  precauciones = 'HEPATOTÓXICO. Monitorear enzimas hepáticas. Teratogénico. Evitar en embarazo. Inhibidor CYP3A4 (interacciones).',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico/malformaciones).',
  contraindicaciones = 'Hipersensibilidad, enfermedad hepática, gestación.',
  efectos_secundarios = 'Elevación de enzimas hepáticas, náuseas, vómito, diarrea, dermatosis, fotosensibilidad.',
  interacciones = 'Ketoconazol (suma), cisaprida (prolonga QT), cyclosporina (niveles alterados).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%itraconazol%';

-- Ketoconazol: antifúngico (húmido, sistémico)
UPDATE public.medicamentos SET
  precauciones = 'HEPATOTÓXICO severo. Monitorear enzimas hepáticas obligatorio. Teratogénico. Evitar en embarazo. Inhibidor CYP potente.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico y mutagénico).',
  contraindicaciones = 'Hipersensibilidad, enfermedad hepática, gestación.',
  efectos_secundarios = 'Elevación de enzimas hepáticas, vómito, diarrea, anorexia, alopecia, dermatosis.',
  interacciones = 'De muchos fármacos (CYP3A4): cisaprida, terfenadina, warfarina, ciclosporina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%ketoconazol%';

-- Lokivetmab: anti-IL-31 (prurito)
UPDATE public.medicamentos SET
  precauciones = 'Anticuerpo monoclonal anti-IL-31. Usado para prurito crónico. Riesgo de reacciones de hipersensibilidad. Monitorizar post-inyección.',
  embarazo_lactancia = 'Seguridad no establecida. Consultar criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad a anticuerpos monoclonales.',
  efectos_secundarios = 'Reacciones de hipersensibilidad (pico inmediato), vómito, diarrea.',
  interacciones = 'Otros inmunomoduladores.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%lokivetmab%';

-- Loratadina: antihistamínico no sedante
UPDATE public.medicamentos SET
  precauciones = 'Antihistamínico no sedante. Cuidado en enfermedad hepática. Dosis ajustada en insuficiencia hepática.',
  embarazo_lactancia = 'Categoría B. Seguridad no establecida en veterinaria.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Vértigo, vómito, diarrea, dolor de cabeza.',
  interacciones = 'Ketoconazol/itraconazol (niveles elevados), eritromicina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%loratadina%';

-- Oclacitinib: JAK inhibitor (atopía)
UPDATE public.medicamentos SET
  precauciones = 'Inhibidor de JAK. Cuidado en neoplasias (riesgo potencial). Monitorizar hemograma y enzimas hepáticas. No usar con otros inhibidores de JAK.',
  embarazo_lactancia = 'Seguridad no establecida. Consultar criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, neoplasia activa.',
  efectos_secundarios = 'Vómito, diarrea, polipuria/polidipsia, elevación enzimas hepáticas.',
  interacciones = 'Otros JAK inhibitors, CYP3A4 moduladores.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%oclacitinib%';

-- Prednisona: corticosteroide (usada mucho como antiinflamatorio)
UPDATE public.medicamentos SET
  precauciones = 'Corticoide de acción prolongada. Cuidado en diabetes, hipertensión, insuficiencia renal/hepática, osteopenia. No suspender de forma abrupta.',
  embarazo_lactancia = 'CONTRAINDICADO en gestación (aborto, teratogénico). Lactancia: excretado en leche.',
  contraindicaciones = 'Infección sistémica no controlada, diabetes no compensada, hipersensibilidad, gestación.',
  efectos_secundarios = 'Polidipsia, polifagia, poluria, aumento de peso, miopatía, piel delgada, inhibición del crecimiento, insuficiencia suprarrenal.',
  interacciones = 'AINEs (ulcera GI), AINEs (potenal la toxicidad GI), ketoconazol (niveles), aclaritromicina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%prednisona%';

-- Terbinafina: antifúngico (dermatomicosis)
UPDATE public.medicamentos SET
  precauciones = 'Ajustar en falla hepática. Riesgo de reacciones de hipersensibilidad severas. Hidratación adecuada. Pueden interactuar con IECA aumentando hipersensibilidad.',
  embarazo_lactancia = 'Categoría C. Seguridad no establecida.',
  contraindicaciones = 'Hipersensibilidad, insuficiencia hepática severa.',
  efectos_secundarios = 'Vómito, diarrea, rash, hipersensibilidad, elevación enzimas hepáticas.',
  interacciones = 'IECA (hipersensibilidad aumentada), azatioprina.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%terbinafina%';

-- Triamcinolona: corticosteroide potente
UPDATE public.medicamentos SET
  precauciones = 'Corticoide potente. Cuidado en diabetes, hipertensión, insuficiencia renal/hepática, osteopenia. No suspender abruptamente. Evitar en gestación.',
  embarazo_lactancia = 'CONTRAINDICADO en gestación (aborto, teratogénico). Lactancia: excretado en leche.',
  contraindicaciones = 'Infección sistémica no controlada, diabetes no compensada, hipersensibilidad, gestación.',
  efectos_secundarios = 'Polidipsia, polifagia, poluria, aumento de peso, miopatía, piel delgada, inhibición del crecimiento.',
  interacciones = 'AINEs (ulcera GI), claritromicina (niveles alterados), ketoconazol.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%triamcinolona%';

-- ── AINES (Mavacoxib, Naproxeno, Piroxicam, Tenoxicam, Tepoxalina, Vedaprofeno) ──
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de úlcera GI y nefrotoxicidad. No combinar con otros AINEs ni corticosteroides. Evitar en deshidratados.',
  embarazo_lactancia = 'CONTRAINDICADO en gestación y lactancia.',
  contraindicaciones = 'Úlcera GI, insuficiencia renal/hepática, deshidratación, trastornos de la coagulación, gestación.',
  efectos_secundarios = 'Vómitos, diarrea, pérdida de apetito, úlceras GI, insuficiencia renal.',
  interacciones = 'Otros AINEs, corticosteroides, anticoagulantes, diuréticos, IECA.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%mavacoxib%' OR nombre ILIKE '%naproxeno%' OR nombre ILIKE '%piroxicam%' OR nombre ILIKE '%tenoxicam%' OR nombre ILIKE '%tepoxalina%' OR nombre ILIKE '%vedaprofeno%';

-- ── ANALGÉSICOS / ANTIINFLAMATORIOS (amantadina, codeína, deracoxib, firocoxib, grapiprant, morfina, pregabalina, robenacoxib) ──
UPDATE public.medicamentos SET
  precauciones = 'Analgésico antiinflamatorio. Cuidado en enfermedad hepática/renal. Robenacoxib: solo por vía oral, no combinar con otros AINEs. Pregabalina: ajustar en falla renal. Morfina: depresión respiratoria. Deracoxib/Firocoxib: caxoxib selectivos pero riesgo GI.',
  embarazo_lactancia = 'CONTRAINDICADO en gestación/lactancia. Consultar criterio veterinario.',
  contraindicaciones = 'Úlcera GI, insuficiencia renal/hepática, gestación.',
  efectos_secundarios = 'Vómitos, diarrea, úlceras GI, insuficiencia renal, efectos neurológicos (pregabalina, morfina).',
  interacciones = 'Otros AINEs, corticosteroides, anticoagulantes, digoxina (morfina).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%amantadina%' OR nombre ILIKE '%codeína%' OR nombre ILIKE '%deracoxib%' OR nombre ILIKE '%firocoxib%' OR nombre ILIKE '%grapiprant%' OR nombre ILIKE '%morfina%' OR nombre ILIKE '%pregabalina%' OR nombre ILIKE '%robenacoxib%';

-- ── ANALGÉSICOS / LOCAL (mepivacaína) ───────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Anestésico local. Toxicidad sistémica si se absorbe en exceso. No usar en tejidos infectados. Aspirar antes de inyectar. Cuidado en bloqueos mayores.',
  embarazo_lactancia = 'Categoría B. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, aplicación IV accidental.',
  efectos_secundarios = 'Toxicidad sistémica: convulsiones, arritmias, hipotensión. Sedación local.',
  interacciones = 'Otros anestésicos locales (potencial aditiva), antiarrítmicos, depresores del SNC.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%mepivacaína%';

-- ── ANTICONVULSIVANTES (fenobarbital, levetiracetam) ───────────
UPDATE public.medicamentos SET
  precauciones = 'Fenobarbital: inductor enzimático CYP450, tolerncia, dependencia. Monitorizar niveles séricos. Levetiracetam: buena tolerancia, sin inducción enzimática significativa. Cuidado en insuficiencia renal.',
  embarazo_lactancia = 'Fenobarbital: teratogénico (evitar). Levetiracetam: seguridad no establecida. Consultar criterio veterinario.',
  contraindicaciones = 'Fenobarbital: hipersensibilidad, porfiria. Levetiracetam: hipersensibilidad.',
  efectos_secundarios = 'Fenobarbital: sedación, ataxia, polifagia, polidipsia, hepatoxicidad, dependencia. Levetiracetam: sedación, letargo, vómito.',
  interacciones = 'Fenobarbital: induces CYP450 (reduce otros fármacos). Levetiracetam: baja interacción.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%fenobarbital%' OR nombre ILIKE '%levetiracetam%';

-- ── ANTÍDOTOS / EMERGENCIAS (carbón activado, flumazenil, yohimbina) ─────────
UPDATE public.medicamentos SET
  precauciones = 'Carbón activado: administrar temprano (≤1-2h). Contraindicado en alteración del nivel de conciencia, riesgo de aspiración. Flumazenil: reversor de benzodiacepinas. Vida media corta: riesgo de re-sedación. Yohimbina: antagonista alpha-2. Riesgo de taquicardia e hipertensión.',
  embarazo_lactancia = 'Carbón activado: seguridad no establecida. Flumazenil: evitar en embarazo. Yohimbina: evitar en embarazo.',
  contraindicaciones = 'Carbón activado: alteración nivel conciencia, riesgo aspiración. Flumazenil: embarazo. Yohimbina: embarazo.',
  efectos_secundarios = 'Carbón activado: vómito, aspiración. Flumazenil: crisis convulsiva, arritmias. Yohimbina: taquicardia, hipertensión, ansiedad.',
  interacciones = 'Flumazenil: benzodiacepinas. Yohimbina: agonistas alpha-2, betabloqueantes.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%carbón activado%' OR nombre ILIKE '%flumazenil%' OR nombre ILIKE '%yohimbina%';

-- ── ANTIFUNGICOS TOPICOS (Clotrimazol, Miconazol) ya están al principio──

-- ── ANTIVIRALES (Aciclovir, Famciclovir) ───────────────────
UPDATE public.medicamentos SET
  precauciones = 'Aciclovir: activo contra herpes simple/virus. Ajustar en falla renal. Fenoxibencilpenicilina (no efectivo contra VHB/HCV). Famciclovir: bio-disponibilidad oral superior. No usar en gatos (sensibilidad).',
  embarazo_lactancia = 'Aciclovir: Categoria B. Segura en lactancia. Famciclovir: seguridad no establecida.',
  contraindicaciones = 'Falla renal severa (aciclovir), hipersensibilidad, gatos (famciclovir).',
  efectos_secundarios = 'Aciclovir: vómito, diarrea, dolor de cabeza, nefrotoxicidad. Famciclovir: vómito, diarrea, dolor de cabeza.',
  interacciones = 'Probenecid (aumenta níveis aciclovir), tacrolimus (interacción).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%aciclovir%' OR nombre ILIKE '%famciclovir%';

COMMIT;