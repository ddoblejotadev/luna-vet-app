-- Migración: fármacos de ALTO RIESGO (aminoglucósidos, anfotericina, fluoroquinolonas,
-- quimioterapia, cloranfenicol, rifampicina, nitrofurantoína, bromuro de potasio,
-- atropina, acepromazina, azitromicina, clindamicina, voriconazol, cefalosporinas)
-- Fuentes: FDA DailyMed / VMD UK SPC / Plumb's Veterinary Drug Handbook

BEGIN;

-- ── AMINOGLUCÓSIDOS (nefro/ototoxicidad) ──────────────────────────────────
-- Amikacina, Gentamicina, Tobramicina
UPDATE public.medicamentos SET
  precauciones = 'Ajustar dosis estrictamente por función renal. Riesgo de NEFROTOXICIDAD y OTOXICIDAD (puede ser irreversible). Monitorear niveles séricos y función renal. Evitar en deshidratados. No combinar con otros nefrotóxicos.',
  embarazo_lactancia = 'Categoría D. Riesgo de ototoxicidad y nefrotoxicidad fetal. Evitar salvo que el beneficio supere claramente el riesgo.',
  contraindicaciones = 'Insuficiencia renal severa, deshidratación, hipersensibilidad a aminoglucósidos.',
  efectos_secundarios = 'Nefrotoxicidad, ototoxicidad (sordera, vértigo), dolor en sitio de inyección, debilidad neuromuscular.',
  interacciones = 'Nefrotóxicos (vancomicina, anfotericina B), diuréticos de asa, bloqueadores neuromusculares.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%amikacina%' OR nombre ILIKE '%gentamicina%' OR nombre ILIKE '%tobramicina%';

-- ── ANFOTERICINA B (nefrotoxicidad severa) ────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'NEFROTOXICIDAD SEVERA. Monitorear función renal y electrolitos (potasio, magnesio). Reacciones a la infusión (fiebre, escalofríos, hipotensión). Hidratación previa obligatoria. Ajustar por función renal.',
  embarazo_lactancia = 'Categoría B. Usar solo si el beneficio justifica claramente el riesgo.',
  contraindicaciones = 'Insuficiencia renal severa, hipersensibilidad, lactancia (relativa).',
  efectos_secundarios = 'Nefrotoxicidad, hipopotasemia, hipomagnesemia, fiebre, escalofríos, anemia, hipotensión.',
  interacciones = 'Nefrotóxicos (aminoglucósidos, vancomicina), diuréticos, corticoides (hipopotasemia), digitálicos (arritmias por hipopotasemia).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%anfotericina%';

-- ── FLUOROQUINOLONAS (daño cartilaginoso en jóvenes) ───────────────────────
-- Ciprofloxacina, Marbofloxacina, Ofloxacina, Orbifloxacina, Pradofloxacina
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de daño cartilaginoso (artropatía) en animales jóvenes en crecimiento. Ajustar en falla renal. Cuidado en convulsionantes (baja umbral). Evitar antiácidos y quelantes (reducen absorción).',
  embarazo_lactancia = 'Riesgo de alteración del cartílago fetal. Usar solo si el beneficio supera el riesgo.',
  contraindicaciones = 'Animales en crecimiento (perros jóvenes según raza), hipersensibilidad a quinolonas.',
  efectos_secundarios = 'Vómito, diarrea, depresión, cristales urinarios (ciprofloxacina), convulsiones (raro), tendinopatía.',
  interacciones = 'Antiácidos, sucralfato, hierro/zinc (reducción absorción), teofilina (niveles elevados), AINEs (riesgo de convulsiones).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%ciprofloxacina%' OR nombre ILIKE '%marbofloxacina%' OR nombre ILIKE '%ofloxacina%' OR nombre ILIKE '%orbifloxacina%' OR nombre ILIKE '%pradofloxacina%';

-- ── QUIMIOTERAPIA (manejo con precaución, mielosupresión) ─────────────────
-- Carboplatino, Ciclofosfamida, Doxorubicina, Vincristina, Lomustina
UPDATE public.medicamentos SET
  precauciones = 'MANEJO CON PRECAUCIÓN (citotóxico: usar guantes). Monitoreo hematológico estricto (mielosupresión). Ajustar por función renal/hepática. Doxorubicina: cardiotoxicidad acumulativa. Ciclofosfamida: hidratación para prevenir cistitis hemorrágica.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico/mutagénico). Riesgo para personal gestante que manipule el fármaco.',
  contraindicaciones = 'Mielosupresión severa, infección activa, hipersensibilidad. Doxorubicina: cardiopatía preexistente.',
  efectos_secundarios = 'Mielosupresión, náuseas/vómitos, alopecia, cardiotoxicidad (doxorrubicina), cistitis hemorrágica (ciclofosfamida), neuropatía (vincristina), hepatotoxicidad (lomustina).',
  interacciones = 'Otros mielosupresores, alopurinol (aumenta ciclofosfamida), nefrotóxicos (carboplatino).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%carboplatino%' OR nombre ILIKE '%ciclofosfamida%' OR nombre ILIKE '%doxorubicina%' OR nombre ILIKE '%vincristina%' OR nombre ILIKE '%lomustina%';

-- ── CLORFENICOL (riesgo hematológico) ─────────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de supresión medular (anemia aplásica). Ajustar en falla hepática. Evitar en neonatos (síndrome gris). No usar en animales productores de alimentos según normativa local.',
  embarazo_lactancia = 'Categoría C. Evitar (riesgo de síndrome gris en neonatos).',
  contraindicaciones = 'Hipersensibilidad, trastornos hematológicos, neonatos.',
  efectos_secundarios = 'Vómito, diarrea, depresión, anorexia, supresión medular, síndrome gris (neonatos).',
  interacciones = 'Fenobarbital (niveles reducidos), fenitoína, warfarina (potenciación), eritromicina (antagonismo).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%cloranfenicol%';

-- ── RIFAMPICINA (hepatotóxica, indutor enzimático) ────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'HEPATOTÓXICA. Monitorear enzimas hepáticas. Coloración rojiza de fluidos corporales. Inductor enzimático (CYP450) potente.',
  embarazo_lactancia = 'Categoría C. Riesgo teratogénico reportado. Consultar criterio veterinario.',
  contraindicaciones = 'Insuficiencia hepática severa, hipersensibilidad.',
  efectos_secundarios = 'Hepatotoxicidad, náuseas, vómito, coloración rojiza de orina/lágrimas, trombocitopenia.',
  interacciones = 'Reduce niveles de muchos fármacos (inductor CYP450): ketoconazol, ciclofosfamida, opioides, anticoagulantes.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%rifampicina%';

-- ── NITROFURANTOÍNA (anemia hemolítica en G6PD) ───────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Ineficaz en falla renal severa. Riesgo de ANEMIA HEMOLÍTICA en deficiencia de G6PD. Neuropatía periférica con uso crónico. Administrar con alimentos.',
  embarazo_lactancia = 'Evitar a término (riesgo de anemia hemolítica neonatal). Lactancia: precaución en G6PD.',
  contraindicaciones = 'Insuficiencia renal severa, deficiencia de G6PD, neonatos <1 mes, hemorragia activa.',
  efectos_secundarios = 'Náuseas, vómito, diarrea, neuropatía periférica, anemia hemolítica, reacciones pulmonares.',
  interacciones = 'Antácidos (absorción reducida), probenecid (compite por excreción).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%nitrofurantoína%';

-- ── BROMURO DE POTASIO (ventana terapéutica estrecha) ─────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Ventana terapéutica estrecha. Monitorear niveles séricos (toxicidad >2.5-3 mEq/L). Ajustar en falla renal. No cambiar de marca sin criterio veterinario.',
  embarazo_lactancia = 'Seguridad no establecida. Consultar criterio veterinario.',
  contraindicaciones = 'Insuficiencia renal severa, hiperpotasemia, hipoadrenalismo no controlado.',
  efectos_secundarios = 'Sedación, ataxia, vómito, polifagia, debilidad, arritmias (sobredosis).',
  interacciones = 'Diuréticos ahorradores de potasio, IECA (aumentan potasio), AINEs (reducen excreción).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%bromuro de potasio%';

-- ── ATROPINA (anticolinérgico) ─────────────────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Anticolinérgico. Taquicardia, sequedad de mucosas, midriasis. Cuidado en glaucoma, hipertrofia prostática y cardiopatía. No usar en temperaturas altas (inhibe sudoración).',
  embarazo_lactancia = 'Categoría C. Seguridad no establecida.',
  contraindicaciones = 'Glaucoma de ángulo cerrado, íleo paralítico, hipersensibilidad.',
  efectos_secundarios = 'Taquicardia, midriasis, sequedad de mucosas, retención urinaria, íleo, sedación o excitación (perros).',
  interacciones = 'Otros anticolinérgicos (potenciación), antihistamínicos, antidepresivos tricíclicos, fenotiazinas.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%atropina%';

-- ── ACEPROMAZINA (hipotensión, no en epilepsia) ───────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Hipotensión y sedación prolongada. NO usar en epilepsia (baja umbral convulsivo), cardiopatía, hipovolemia o animales debilitados. Cuidado en Boxers (hipotensión). Evitar en temperaturas extremas.',
  embarazo_lactancia = 'Seguridad no establecida. Evitar.',
  contraindicaciones = 'Epilepsia, insuficiencia cardíaca, hipovolemia, shock, hipersensibilidad.',
  efectos_secundarios = 'Sedación, hipotensión, hipotermia, prolapso de tercer párpado, prolapso de pene (equinos), hipoglucemia.',
  interacciones = 'Potencia opioides, anestésicos y barbitúricos. No combinar con epinefrina (hipotensión inversa).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%acepromazina%';

-- ── AZITROMICINA (macrólido, QT) ──────────────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Ajustar en falla hepática severa. Puede prolongar el intervalo QT. Cuidado en arritmias cardíacas.',
  embarazo_lactancia = 'Categoría B. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad a macrólidos, colestasis previa.',
  efectos_secundarios = 'Vómito, diarrea, molestia abdominal, elevación de enzimas hepáticas, arritmias (QT).',
  interacciones = 'Antiácidos (absorción reducida), teofilina (niveles elevados), warfarina, digoxina (niveles elevados), sustratos CYP3A4.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%azitromicina%';

-- ── CLINDAMICINA (colitis pseudomembranosa) ───────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Puede causar colitis pseudomembranosa (diarrea severa). Ajustar en falla hepática/renal. No usar en herbívoros (altera flora).',
  embarazo_lactancia = 'Categoría B. Excretada en leche materna.',
  contraindicaciones = 'Hipersensibilidad, colitis ulcerosa o pseudomembranosa previa.',
  efectos_secundarios = 'Vómito, diarrea, colitis, elevación de enzimas hepáticas, dolor en inyección.',
  interacciones = 'Eritromicina (antagonismo), bloqueadores neuromusculares (potenciación), antidiarreicos (riesgo de colitis).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%clindamicina%';

-- ── VORICONAZOL (hepatotóxico, teratogénico) ──────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'HEPATOTÓXICO. Monitorear enzimas hepáticas. Teratogénico. Cuidado en gatos (metabolismo deficiente -> toxicidad). Evitar en embarazo.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico). Riesgo de malformaciones.',
  contraindicaciones = 'Hipersensibilidad, gestación, lactancia, hepatopatía severa.',
  efectos_secundarios = 'Elevación de enzimas hepáticas, vómito, diarrea, alteraciones visuales, fotosensibilidad, dermatosis.',
  interacciones = 'Inductor/inhibidor CYP450: reduce niveles de ciclosporina, incrementa warfarina y fenitoína.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%voriconazol%';

-- ── CEFALOSPORINAS (reactividad cruzada con penicilinas) ──────────────────
-- Cefadroxila, Cefazolina, Cefovecina, Cefpodoxima, Ceftiofur
UPDATE public.medicamentos SET
  precauciones = 'Cuidado en alergia a penicilinas (reactividad cruzada ~5-10%). Ajustar en falla renal. Cefovecina: no repetir antes de 14 días (vida media larga).',
  embarazo_lactancia = 'Categoría B. Generalmente considerada segura; usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad a cefalosporinas o betalactámicos.',
  efectos_secundarios = 'Vómito, diarrea, reacciones alérgicas, dolor en sitio de inyección. Cefovecina: reacciones locales prolongadas.',
  interacciones = 'Probenecid (eleva niveles), aminoglucósidos (nefrotoxicidad potenciada).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%cefadroxila%' OR nombre ILIKE '%cefazolina%' OR nombre ILIKE '%cefovecina%' OR nombre ILIKE '%cefpodoxima%' OR nombre ILIKE '%ceftiofur%';

COMMIT;
