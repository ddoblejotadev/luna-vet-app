-- Migración: faltantes finales (antidepresivos, antibióticos, quimio,
-- antiparasitarios, vasopresores, cardio, psicotrópicos, fluidos,
-- oftálmicos, respiratorios, urológicos, vitaminas)
-- Fuentes: FDA DailyMed / VMD UK SPC / Plumb's Veterinary Drug Handbook

BEGIN;

-- ── ANTIDEPRESIVOS / SNRI (Duloxetina, Venlafaxina) ───────────
UPDATE public.medicamentos SET
  precauciones = 'SNRI (inhibidor recaptación serotonina/noradrenalina). Riesgo de síndrome serotoninérgico. No combinar con IMAO. Ajustar en falla hepática/renal. No suspender abruptamente.',
  embarazo_lactancia = 'Categoría C. Riesgo de síntomas de abstinencia neonatal. Evitar salvo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, IMAO (últimos 14 días), glaucoma de ángulo cerrado.',
  efectos_secundarios = 'Náuseas, vómito, sedación, anorexia, agitación, síndrome serotoninérgico (raro).',
  interacciones = 'IMAO (síndrome serotoninérgico), ISRS, tramadol, triptanes, linezolid.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%duloxetina%' OR nombre ILIKE '%venlafaxina%';

-- ── ANTIBIÓTICOS (Mastilac, Sulfametoxazol+Trimetoprima, Tylosina) ──
UPDATE public.medicamentos SET
  precauciones = 'Mastilac: amoxicilina + cloxacilina (mamitis). Sulfametoxazol+Trimetoprima: cristaluria, hipersensibilidad, KCS. Tylosina: macrólido, bajo riesgo hepático. Cuidado en falla renal.',
  embarazo_lactancia = 'Categoría C/D según fármaco. Sulfametoxazol: riesgo kernicterus. Consultar criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad a penicilinas/cefalosporinas/macrólidos/sulfonamidas.',
  efectos_secundarios = 'Vómito, diarrea, rash, cristaluria (sulfonamidas), KCS, hepatotoxicidad.',
  interacciones = 'Warfarina (potenciación), fenitoína, metotrexato (sulfonamidas).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%mastilac%' OR nombre ILIKE '%sulfametoxazol%' OR nombre ILIKE '%tylosina%';

-- ── ANTICOLINÉRGICO (Glicopirrolato) ───────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Anticolinérgico (premedicación, sialorrea). No cruza barrera hematoencefálica (menos efectos CNS). Cuidado en glaucoma, retención urinaria, cardiopatía.',
  embarazo_lactancia = 'Categoría B. Usar bajo criterio veterinario.',
  contraindicaciones = 'Glaucoma de ángulo cerrado, obstrucción GI/urinaria, taquicardia.',
  efectos_secundarios = 'Taquicardia, sequedad de mucosas, estreñimiento, retención urinaria.',
  interacciones = 'Otros anticolinérgicos, betabloqueantes (taquicardia), IMAO.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%glicopirrolato%';

-- ── QUIMIOTERAPIA (Masitinib, Toceranib) ──────────────────
UPDATE public.medicamentos SET
  precauciones = 'Quimioterapia oral (inibidores tirosina quinasa). Masitinib: tumores mastocíticos. Toceranib: carcinomas. Monitorear hemograma, hepático, renal, PA. Cuidado en falla hepática/renal.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico, mutagénico).',
  contraindicaciones = 'Gestación, lactancia, insuficiencia hepática/renal severa, hipersensibilidad.',
  efectos_secundarios = 'Vómito, diarrea, anorexia, letargo, neutropenia, hepatotoxicidad, hipertensión (toceranib).',
  interacciones = 'AINEs (riesgo GI), otros quimioterápicos, CYP3A4 moduladores.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%masitinib%' OR nombre ILIKE '%toceranib%';

-- ── ANTIPARASITARIOS RESTANTES ─────────────────────────────
-- Diethylcarbamaza (filaria)
UPDATE public.medicamentos SET
  precauciones = 'Antifilarial. No usar en gatos. Reacciones anafilactoides a microfilarias (shock). Administrar con corticosteroides en zonas endémicas.',
  embarazo_lactancia = 'Categoría C. Usar bajo criterio veterinario.',
  contraindicaciones = 'Gatos, infección filarial activa no controlada.',
  efectos_secundarios = 'Reacciones anafilactoides, vómito, diarrea, shock, edema facial.',
  interacciones = 'Corticoides (atenuar reacciones).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%diethylcarbamaza%';

-- Espinosad (pulgas, tóxico si ingiere)
UPDATE public.medicamentos SET
  precauciones = 'Insecticida. Tóxico si se ingiere. No usar en gatos <14 semanas. Evitar en animales debilitados.',
  embarazo_lactancia = 'Seguridad no establecida. Consultar criterio veterinario.',
  contraindicaciones = 'Gatos <14 semanas, hipersensibilidad.',
  efectos_secundarios = 'Vómito, diarrea, letargo, prurito.',
  interacciones = 'Otros insecticidas.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%espinosad%';

-- Febantel, Oxfendazol, Oxibendazol, Pirantel (benzimidazoles/pirantel)
UPDATE public.medicamentos SET
  precauciones = 'Benzimidazoles/pirantel: baja toxicidad. Cuidado en gestación (algunos teratogénicos). Uso prolongado puede causar mielosupresión.',
  embarazo_lactancia = 'Teratogénico (algunos). Evitar en gestación temprana.',
  contraindicaciones = 'Gestación temprana (algunos).',
  efectos_secundarios = 'Vómito, diarrea, anorexia, mielosupresión (uso prolongado).',
  interacciones = 'Dexametasona (aumenta absorción fenbendazol).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%febantel%' OR nombre ILIKE '%oxfendazol%' OR nombre ILIKE '%oxibendazol%' OR nombre ILIKE '%pirantel%';

-- Permetrina (TÓXICA EN GATOS)
UPDATE public.medicamentos SET
  precauciones = 'TÓXICA PARA GATOS (intoxicación piretroide: temblor, convulsiones, ataxia, muerte). NUNCA usar productos de perro con permetrina en gatos. Evitar en conejos.',
  embarazo_lactancia = 'Cuidado. Evitar en gestación.',
  contraindicaciones = 'Gatos, conejos, dermatitis severa.',
  efectos_secundarios = 'Parestesia, temblor, salivación, convulsiones (perros), muerte (gatos).',
  interacciones = 'Otros piretroides (toxicidad aditiva).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%permetrina%';

-- Toltrazuril (coccidias)
UPDATE public.medicamentos SET
  precauciones = 'Baja toxicidad. Efectivo contra coccidios. Evitar en gestación.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Vómito, diarrea (raro).',
  interacciones = 'Otros anticoccidiales.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%toltrazuril%';

-- ── VASOPRESORES (Epinefrina, Norepinefrina) ────────────────
UPDATE public.medicamentos SET
  precauciones = 'Catecolaminas. Uso en paro cardíaco, anafilaxia, shock. Riesgo de arritmias, hipertensión severa, isquemia miocárdica. Diluir para uso IV. Monitoreo ECG continuo.',
  embarazo_lactancia = 'Categoría C. Usar solo si el beneficio materno justifica el riesgo fetal.',
  contraindicaciones = 'Hipersensibilidad, taquicardia severa, hipertensión no controlada.',
  efectos_secundarios = 'Taquicardia, hipertensión, arritmias, ansiedad, temblor, isquemia.',
  interacciones = 'Betabloqueantes (hipertensión paradójica), IMAO (crisis hipertensiva), anestésicos halogenados (arritmias).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%epinefrina%' OR nombre ILIKE '%norepinefrina%';

-- ── CARDIOVASCULARES RESTANTES ─────────────────────────────
-- Hidralazina (vasodilatador)
UPDATE public.medicamentos SET
  precauciones = 'Vasodilatador arterial directo. Hipotensión, taquicardia refleja. Cuidado en enfermedad valvular. Lupus inducido (uso crónico).',
  embarazo_lactancia = 'Categoría C. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, enfermedad coronaria, taquicardia.',
  efectos_secundarios = 'Hipotensión, taquicardia, cefalea, lupus inducido.',
  interacciones = 'Otros antihipertensivos, betabloqueantes, diuréticos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%hidralazina%';

-- Hidroclorotiazida (diurético tiazida)
UPDATE public.medicamentos SET
  precauciones = 'Diurético tiazida. Deshidratación, hipopotasemia, hiponatremia. Monitorear electrolitos y función renal. Cuidado en falla hepática, asma, gota.',
  embarazo_lactancia = 'Categoría B. Riesgo de hipovolemia fetal. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, anuria, hiperpotasemia, gota.',
  efectos_secundarios = 'Diuresis, pérdida electrolitos, hipotensión, hiperglucemia, hiperuricemia.',
  interacciones = 'Digoxina (hipopotasemia), IECA (riesgo renal), litio (toxicidad), AINEs.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%hidroclorotiazida%';

-- Losartán, Telmisartán (ARA-II)
UPDATE public.medicamentos SET
  precauciones = 'Antagonista receptor angiotensina II. Hipotensión, hiperpotasemia, deterioro renal. CONTRAINDICADO en embarazo.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico, toxicidad fetal).',
  contraindicaciones = 'Hipersensibilidad, gestación, estenosis renal bilateral.',
  efectos_secundarios = 'Hipotensión, hiperpotasemia, deterioro renal, mareos.',
  interacciones = 'Diuréticos (hipotensión), AINEs (riesgo renal), suplementos K+, espironolactona.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%losartán%' OR nombre ILIKE '%telmisartán%';

-- Pimobendán (inotrópico)
UPDATE public.medicamentos SET
  precauciones = 'Inotrópico + vasodilatador. Monitorear presión arterial, arritmias. Cuidado en estenosis aórtica. Vómitos frecuentes.',
  embarazo_lactancia = 'Categoría C. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, estenosis aórtica, cardiomiopatía hipertrófica.',
  efectos_secundarios = 'Hipotensión, taquicardia, vómito, diarrea, arritmias.',
  interacciones = 'Otros inotrópicos, betabloqueantes, AINEs, diuréticos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%pimobendán%';

-- Sildenafilo, Tadalafilo (PDE5)
UPDATE public.medicamentos SET
  precauciones = 'Inhibidor PDE5 (hipertensión pulmonar). HIPOTENSIÓN SEVERA con nitratos. Cuidado en cardiopatía. No usar con donadores de NO.',
  embarazo_lactancia = 'Categoría B. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, uso simultáneo con nitratos/donadores NO.',
  efectos_secundarios = 'Hipotensión, rubor, cefalea, dispepsia, priapismo (raro).',
  interacciones = 'Nitratos (hipotensión severa), alfa-bloqueantes, cimetidina (niveles).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%sildenafilo%' OR nombre ILIKE '%tadalafilo%';

-- ── PSICOTRÓPICOS (Fluoxetina, Selegilina, Trazodona) ────────
UPDATE public.medicamentos SET
  precauciones = 'Fluoxetina: ISRS (ansiedad, TOC). Síndrome serotoninérgico con IMAO/otros serotoninérgicos. Selegilina: IMAO-B (síndrome cognitivo). Trazodona: SARI (ansiedad, sedación). Ajustar en falla hepática/renal.',
  embarazo_lactancia = 'Fluoxetina: Categoría C. Selegilina: evitar. Trazodona: C. Consultar criterio veterinario.',
  contraindicaciones = 'IMAO (últimos 14 días), hipersensibilidad.',
  efectos_secundarios = 'Sedación, anorexia, vómito, diarrea, síndrome serotoninérgico (raro).',
  interacciones = 'IMAO, ISRS/SNRI, tramadol, triptanes, linezolid (serotoninérgico).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%fluoxetina%' OR nombre ILIKE '%selegilina%' OR nombre ILIKE '%trazodona%';

-- ── FLUIDOTERAPIA (Cloruro de sodio, Lactato de Ringer) ──────
UPDATE public.medicamentos SET
  precauciones = 'Cristaloides isotónicos. Cloruro sódico: riesgo de hipercloremia/acidosis. Ringer lactato: riesgo de hiperpotasemia si falla renal. Monitorizar balance hídrico/electrolítico.',
  embarazo_lactancia = 'Seguros en gestación/lactancia (uso estándar).',
  contraindicaciones = 'Edema pulmonar, hipervolemia, hipernatremia (cloruro sódico), hiperpotasemia (Ringer).',
  efectos_secundarios = 'Edema, sobrecarga hídrica, desequilibrios electrolíticos.',
  interacciones = 'Otros fluidos, diuréticos, fármacos que alteran electrolitos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%cloruro de sodio%' OR nombre ILIKE '%lactato de ringer%';

-- ── HEMOSTÁTICO (Etamsilato) ────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Hemostático (reduce tiempo de sangrado). Cuidado en insuficiencia renal. No usar en embarazo sin indicación.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Náuseas, cefalea, hipotensión (IV rápida).',
  interacciones = 'Otros hemostáticos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%etamsilato%';

-- ── OFTÁLMICOS ──────────────────────────────────────────────
-- Diclofenaco oftálmico (AINE)
UPDATE public.medicamentos SET
  precauciones = 'AINE tópico oftálmico. Cuidado en cirugía corneal y queratitis. Evitar en embarazo (cierre conducto arterioso).',
  embarazo_lactancia = 'CONTRAINDICADO en gestación avanzada.',
  contraindicaciones = 'Hipersensibilidad, queratitis, cirugía corneal.',
  efectos_secundarios = 'Ardor, lagrimeo, conjuntivitis, úlcera corneal.',
  interacciones = 'Otros AINEs tópicos (suma).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%diclofenaco%' AND (nombre ILIKE '%oftalmo%' OR nombre ILIKE '%gotas%' OR nombre ILIKE '%colirio%');

-- Dorzolamida (inhibidor anhidrasa carbónica)
UPDATE public.medicamentos SET
  precauciones = 'Inhibidor anhidrasa carbónica (glaucoma). Cuidado en acidosis, insuficiencia renal/hepática. Cruz de barrera hematoencefálica.',
  embarazo_lactancia = 'Categoría C. Usar bajo criterio veterinario.',
  contraindicaciones = 'Insuficiencia renal/hepática, acidosis, hipersensibilidad a sulfonamidas.',
  efectos_secundarios = 'Ardor ocular, cefalea, sabor amargo, acidosis metabólica.',
  interacciones = 'Aspirina (potenciación), acetazolamida (suma).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%dorzolamida%';

-- Timolol (betabloqueante oftálmico)
UPDATE public.medicamentos SET
  precauciones = 'Betabloqueante tópico (glaucoma). Absorción sistémica. Cuidado en asma, cardiopatía, diabetes.',
  embarazo_lactancia = 'Categoría C. Usar bajo criterio veterinario.',
  contraindicaciones = 'Asma, cardiopatía, bradicardia, hipersensibilidad.',
  efectos_secundarios = 'Bradicardia, hipotensión, broncoespasmo, cefalea.',
  interacciones = 'Betabloqueantes sistémicos (suma), digoxina, verapamilo.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%timolol%';

-- Tropicamida (midriático)
UPDATE public.medicamentos SET
  precauciones = 'Midriático/anticolinérgico. Riesgo de glaucoma de ángulo cerrado. Cuidado en glaucoma, retención urinaria.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Glaucoma de ángulo cerrado, hipersensibilidad.',
  efectos_secundarios = 'Midiásis, visión borrosa, cicloplejia, hiperemia.',
  interacciones = 'Otros anticolinérgicos (suma).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%tropicamida%';

-- ── RESPIRATORIOS (Salbutamol, Terbutalina, Teofilina) ───────
-- Beta-2 agonistas
UPDATE public.medicamentos SET
  precauciones = 'Broncodilatador beta-2. Cuidado en cardiopatía, hipertensión, diabetes. No suspender abruptamente. Riesgo de hipopotasemia.',
  embarazo_lactancia = 'Categoría C. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, arritmias.',
  efectos_secundarios = 'Taquicardia, temblor, hipotensión, hipopotasemia.',
  interacciones = 'Betabloqueantes (antagonismo), diuréticos (hipopotasemia), IMAO.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%salbutamol%' OR nombre ILIKE '%terbutalina%';

-- Teofilina (metilxantina, ventana estrecha)
UPDATE public.medicamentos SET
  precauciones = 'Broncodilatador (metilxantina). Ventana terapéutica estrecha. MONITORIZAR NIVELES SÉRICOS. Cuidado en cardiopatía, insuficiencia hepática, convulsiones.',
  embarazo_lactancia = 'Categoría C. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, arritmias, úlcera péptica activa.',
  efectos_secundarios = 'Taquicardia, arritmias, vómito, convulsiones (sobredosis), insomnio.',
  interacciones = 'Cimetidina (niveles elevados), fenobarbital (niveles reducidos), cafeína (suma), IMAO.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%teofilina%';

-- ── ATIPAMEZOL (antagonista alpha-2) ────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Antagonista alpha-2 (reversor de medetomidina/dexmedetomidina). Riesgo de taquicardia, hipertensión, agitación. Administrar IV lento.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, enfermedad cardiovascular severa.',
  efectos_secundarios = 'Taquicardia, hipertensión, agitación, vómito.',
  interacciones = 'Agonistas alpha-2 (reversión), betabloqueantes, simpaticomiméticos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%atipamezol%';

-- ── UROLÓGICOS ──────────────────────────────────────────────
-- Alfabloqueantes (Fenoxibenzamina, Prazosina, Tamsulosina)
UPDATE public.medicamentos SET
  precauciones = 'Alfabloqueantes (incontinencia, hiperplasia prostática). Riesgo de hipotensión ortostática. Cuidado en cirugía de cataratas (síndrome iris flácido).',
  embarazo_lactancia = 'Categoría B/C. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad, hipotensión severa.',
  efectos_secundarios = 'Hipotensión ortostática, mareos, taquicardia refleja, congestión nasal.',
  interacciones = 'Otros antihipertensivos (hipotensión), betabloqueantes, PDE5 (hipotensión severa).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%fenoxibenzamina%' OR nombre ILIKE '%prazosina%' OR nombre ILIKE '%tamsulosina%';

-- Finasterida (inhibidor 5-alfa reductasa, teratogénico)
UPDATE public.medicamentos SET
  precauciones = 'Inhibidor 5-alfa reductasa (hiperplasia prostática). TERATOGÉNICO (masculino). No manejar en mujeres embarazadas (absorción cutánea).',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico, genitales masculinos).',
  contraindicaciones = 'Gestación, lactancia, mujeres embarazadas (manejo del fármaco).',
  efectos_secundarios = 'Disfunción eréctil, reducción libido, ginecomastia.',
  interacciones = 'Otros antiandrogénicos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%finasterida%';

-- ── VITAMINAS Y SUPLEMENTOS (10) ────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Suplementos nutricionales. Generalmente seguros en dosis recomendadas. Coenzima Q10/Omega-3: interacciones leves con anticoagulantes. Silymarina: hepatoprotector. Taurina: esencial en gatos. Vitamina K1: antídoto warfarina.',
  embarazo_lactancia = 'Seguros en dosis nutricionales. Vitamina K1: segura en embarazo.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Vómito, diarrea (raro), rash.',
  interacciones = 'Anticoagulantes (Omega-3, Vit K1), fármacos hepatotóxicos (Silymarina protectora).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%coenzima q10%' OR nombre ILIKE '%condroitina%' OR nombre ILIKE '%glucosamina%' OR nombre ILIKE '%l-carnitina%' OR nombre ILIKE '%omega-3%' OR nombre ILIKE '%silymarina%' OR nombre ILIKE '%taurina%' OR nombre ILIKE '%vitamina b complex%' OR nombre ILIKE '%vitamina b12%' OR nombre ILIKE '%vitamina k1%';

COMMIT;