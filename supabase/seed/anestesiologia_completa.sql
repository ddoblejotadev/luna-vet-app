-- Catálogo de Anestesiología Veterinaria — uso clínico y fuentes
-- Fuentes principales: Plumb's Veterinary Drug Handbook (9a ed.), MSD Veterinary Manual, BSAVA Small Animal Formulary, Lumb & Jones' Veterinary Anesthesia and Analgesia
-- Octubre 2026

-- ============ INHALATORIOS (mantenimiento) ============
INSERT INTO public.medicamentos (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por)
VALUES
  ('Isoflurano', 'Isoflurano', 'Anestésicos / Inhalatorios', 'Líquido volátil', '100% (1.5 MAC)', 'Inducción: 3-5% (caja); mantenimiento: 1.5-3% (perros), 2-3% (gatos). MAC 1.3-1.5%', 'Inhalatoria', ARRAY['Perro','Gato','Equino',' Bovino'], 'alto', true,
    'Mantenimiento de anestesia general; inducción por cámara en perros/gatos',
    'Depresión respiratoria, hipotensión, vasodilatación; irritante vías aéreas (no usar inducción por maskara en gatos)',
    'Malign hyperthermia (equinos susceptibles); evitar en pacientes con hipotensión severa',
    'No es metabolizado; se elimina por pulmón. Requiere vaporizador calibrado. MAC se reduce con opioides y alpha-2 agonistas.',
    'Plumb''s Veterinary Drug Handbook; MSD Veterinary Manual',
    'https://www.msdvetmanual.com', NULL),
  ('Sevoflurano', 'Sevoflurano', 'Anestésicos / Inhalatorios', 'Líquido volátil', '100% (2.2 MAC)', 'Inducción: 4-8% por máscara; mantenimiento: 2-4% (perros), 2.5-4% (gatos). MAC 2.2-2.6%', 'Inhalatoria', ARRAY['Perro','Gato','Equino'], 'alto', true,
    'Inducción y mantenimiento de anestesia; menos irritante que isoflurano',
    'Depresión respiratoria; hipotensión; puede producir compuesto A con absorbentes secos (baja relevancia clínica)',
    'Malign hyperthermia; evitar en hipotensión severa',
    'Menos pungente que isoflurano: inducción por máscara más suave, preferido en gatos.',
    'Plumb''s Veterinary Drug Handbook',
    'https://www.msdvetmanual.com', NULL),
  ('Desflurano', 'Desflurano', 'Anestésicos / Inhalatorios', 'Líquido volátil', '100%', 'Mantenimiento: 5-8% (perros); MAC 7-9%', 'Inhalatoria', ARRAY['Perro','Gato'], 'alto', true,
    'Mantenimiento anestesia de corta duración (recuperación muy rápida)',
    'Irritante vías aéreas; depresión respiratoria; hipotensión; NO para inducción por máscara',
    'No usar en inducción; requiere vaporizador especial (calentado)',
    'Recuperación más rápida que isoflurano/sevoflurano; costo y equipo especial limitan su uso.',
    'Lumb & Jones'' Veterinary Anesthesia',
    'https://www.msdvetmanual.com', NULL)
ON CONFLICT DO NOTHING;

-- ============ INYECTABLES (inducción) ============
INSERT INTO public.medicamentos (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por)
VALUES
  ('Propofol', 'Propofol', 'Anestésicos / Inducción IV', 'Emulsión IV', '10 mg/ml', 'Perros: 4-6 mg/kg IV a efecto; gatos: 2-4 mg/kg IV a efecto (lento)', 'Intravenosa', ARRAY['Perro','Gato'], 'alto', true,
    'Inducción de anestesia general; TIVA corta procedimientos',
    'Apnea, hipotensión; excitación transitoria; dolor en sitio IV; bradicardia',
    'Shock, hipovolemia, enfermedad hepática severa, gatos con lipidemia, embarazo (no en gatos gestantes por toxicidad del vehicle)',
    'Emulsión lipídica: no usar en gatos con hiperlipidemia; dosis total en gatos limitada por metabolismo lento.',
    'Plumb''s; MSD Veterinary Manual',
    'https://www.msdvetmanual.com', NULL),
  ('Alfaxalona (IV)', 'Alfaxalona', 'Anestésicos / Inducción IV', 'Solución IV', '10 mg/ml', 'Perros: 1-2 mg/kg IV; gatos: 1-5 mg/kg IV a efecto; TIVA 0.1-0.2 mg/kg/min', 'Intravenosa', ARRAY['Perro','Gato'], 'alto', true,
    'Inducción y mantenimiento de anestesia general (CNS neuroesteroide)',
    'Excitación, apnea, hipotensión; vasodilatación; temblor muscular',
    'No hay contraindicación absoluta; precaución en hipovolemia',
    'Excelente para gatos (menos irritante); puede usarse IM en casos difíciles.',
    'Plumb''s; BSAVA Formulary',
    'https://www.bsava.com', NULL),
  ('Ketamina (anestesia)', 'Ketamina', 'Anestésicos / Inducción IV', 'Solución inyectable', '50-100 mg/ml', 'Perros: 5-10 mg/kg IV (con sedante); gatos: 5-10 mg/kg IV; dosis de campo 20-30 mg/kg IM', 'Intravenosa/Intramuscular', ARRAY['Perro','Gato'], 'alto', true,
    'Inducción anestésica; analgesia inyectable; inmovilización en campo (con xilacina/medetomidina)',
    'Aumento de tono muscular, salivación, vocalización, recovery disforico; arritmias en gatos con cardiomiopatía HCM',
    'NO usar solo en gatos con HCM/FEV elevada ni con aumento de presión intracraneal; evitar en glaucoma',
    'Siempre combinar con sedante (benzodiacepina/alpha-2) para suavizar inducción y recuperación.',
    'MSD Veterinary Manual',
    'https://www.msdvetmanual.com', NULL),
  ('Tiletamina + Zolazepam (Telazol)', 'Tiletamina/Zolazepam', 'Anestésicos / Inducción IM', 'Polvo liofilizado', '50 mg cada uno', 'Perros: 2-6 mg/kg IM; gatos: 2-4 mg/kg IM; vida silvestre 1-5 mg/kg', 'Intramuscular/Subcutánea', ARRAY['Perro','Gato'], 'alto', true,
    'Inducción e inmovilización química; manejo de fauna y animales agresivos',
    'Recuperación prolongada; excitación; depresión respiratoria; hipotensión',
    'No usar en perros/gatos con enfermedad cardiovascular severa',
    'Reconstituir con 5 ml diluyente; útil cuando no se puede poner vía IV.',
    'Plumb''s Veterinary Drug Handbook',
    'https://www.msdvetmanual.com', NULL)
ON CONFLICT DO NOTHING;

-- ============ PREMEDICACIÓN / SEDACIÓN ============
INSERT INTO public.medicamentos (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por)
VALUES
  ('Xilacina', 'Xilacina', 'Sedantes / Alpha-2 agonistas', 'Solución inyectable', '20 mg/ml', 'Perros: 0.5-1 mg/kg IV/IM; gatos: 0.5-1 mg/kg IM; equinos 0.5-1.1 mg/kg IV', 'Intravenosa/Intramuscular', ARRAY['Perro','Gato','Equino'], 'alto', true,
    'Sedación, analgesia, relajación muscular; premedicación; emético en gatos',
    'Bradicardia, hipotensión, vómitos (gatos), hiperglucemia, diuresis, sedación prolongada en gatos',
    'Enfermedad cardiovascular, hepática o renal severa; no usar en gatos con HCM severo',
    'Reversible con yohimbina (0.1 mg/kg IV) o atipamezol. Emético útil en gatos (vómito ~50%).',
    'Plumb''s; MSD Veterinary Manual',
    'https://www.msdvetmanual.com', NULL),
  ('Atipamezol', 'Atipamezol', 'Sedantes / Antagonista alpha-2', 'Solución inyectable', '5 mg/ml', 'Perros: 0.1-0.2 mg/kg IV/IM; gatos: 0.1-0.2 mg/kg IV (equinos: usar precaución)', 'Intravenosa/Intramuscular', ARRAY['Perro','Gato'], 'normal', true,
    'Reversión de sedación/analgesia por dexmedetomidina y medetomidina',
    'Sedación de rebote, taquicardia, hipotensión transitoria, vómitos',
    'No revertir sin criterio clínico; no usar en pacientes con sedación inadecuada o en tratamiento con alpha-2 por otra indicación',
    'Reconstituir solo con la dosis de medetomidina equivalente (1:1). Reversión demasiado rápida puede causar excitación.',
    'Plumb''s Veterinary Drug Handbook',
    'https://www.msdvetmanual.com', NULL),
  ('Atropina', 'Atropina', 'Anticolinérgicos', 'Solución inyectable', '0.5 mg/ml', 'Perros/gatos: 0.02-0.04 mg/kg IV/IM/SC; premedicación anestésica 0.04 mg/kg', 'Intravenosa/Intramuscular/Subcutánea', ARRAY['Perro','Gato'], 'normal', true,
    'Reducir secreciones salivares y bronquiales; prevenir bradicardia vagal durante anestesia',
    'Taquicardia, boca seca, midriasis, retención urinaria, hipertermia',
    'Glaucoma, hipertrofia prostática, taquiarritmias, hipersensibilidad a atropina',
    'NO dar antes de dexmedetomidina/medetomidina (aumenta arritmias); usar ante bradicardia sintomática.',
    'Plumb''s; MSD Veterinary Manual',
    'https://www.msdvetmanual.com', NULL),
  ('Glicopirrolato', 'Glicopirrolato', 'Anticolinérgicos', 'Solución inyectable', '0.2 mg/ml', 'Perros/gatos: 0.005-0.01 mg/kg IV/IM/SC (menos taquicardia que atropina)', 'Intravenosa/Intramuscular/Subcutánea', ARRAY['Perro','Gato'], 'normal', true,
    'Antisialagogo en premedicación; bradicardia vagal (menos taquicardia que atropina)',
    'Boca seca, retención urinaria; cruza menos la barrera hematoencefálica (menos efectos CNS)',
    'Glaucoma, hipertrofia prostática',
    'Alternativa a atropina cuando se quiere evitar taquicardia; no cruza BBB.',
    'Plumb''s Veterinary Drug Handbook',
    'https://www.msdvetmanual.com', NULL)
ON CONFLICT DO NOTHING;

-- ============ ANALGESIA ANESTÉSICA (opioides potentes) ============
INSERT INTO public.medicamentos (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por)
VALUES
  ('Metadona (analgesia)', 'Metadona', 'Analgésicos / Opioides', 'Solución inyectable', '10 mg/ml', 'Perros: 0.1-0.5 mg/kg IV/SC/IM; gatos: 0.1-0.25 mg/kg SC/IM cada 4-8h', 'Intravenosa/Intramuscular/Subcutánea', ARRAY['Perro','Gato'], 'alto', true,
    'Analgesia perioperatoria severa; sustitución de morfina; adyuvante en premedicación',
    'Sedación, depresión respiratoria, vómitos, bradicardia; acumulación en uso repetido',
    'Depresión respiratoria, hipotiroidismo, adrenocortical insuficiencia, uso con IMAO',
    'Más duradera que morfina; puede acumularse en gatos. Requiere registro de uso en muchas jurisdicciones.',
    'Plumb''s Veterinary Drug Handbook',
    'https://www.msdvetmanual.com', NULL),
  ('Oximorfona', 'Oximorfona', 'Analgésicos / Opioides', 'Solución inyectable', '10 mg/ml', 'Perros: 0.05-0.1 mg/kg IV/IM/SC; gatos: 0.05-0.1 mg/kg SC/IM', 'Intravenosa/Intramuscular/Subcutánea', ARRAY['Perro','Gato'], 'alto', true,
    'Analgesia severa perioperatoria; alternativa a morfina con menos histamina',
    'Sedación, depresión respiratoria, bradicardia; vómitos en perros',
    'Depresión respiratoria, insuficiencia hepática/renal severa',
    'Menor liberación de histamina que morfina; opción cuando morfina causa hipotensión.',
    'Plumb''s Veterinary Drug Handbook',
    'https://www.msdvetmanual.com', NULL),
  ('Butorfanol (analgesia)', 'Butorfanol', 'Analgésicos / Opioides', 'Solución inyectable', '10 mg/ml', 'Perros: 0.2-0.4 mg/kg IV/IM/SC cada 1-2h; gatos: 0.2-0.4 mg/kg SC cada 4h; equinos 0.01-0.05 mg/kg IV', 'Intravenosa/Intramuscular/Subcutánea', ARRAY['Perro','Gato','Equino'], 'alto', true,
    'Analgesia moderada; sedación (con alpha-2 agonistas); antitúxico',
    'Sedación, depresión respiratoria mínima, pupilas dilatadas',
    'No combinar con agonistas opioides puros (efecto antagonista parcial)',
    'Agonista-antagonista: techo analgésico; útil para evitar depresión respiratoria severa.',
    'MSD Veterinary Manual',
    'https://www.msdvetmanual.com', NULL)
ON CONFLICT DO NOTHING;

-- ============ BLOQUEANTES NEUROMUSCULARES (uso hospitalario) ============
INSERT INTO public.medicamentos (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por)
VALUES
  ('Atracurio', 'Atracurio', 'Anestésicos / Bloqueante neuromuscular', 'Solución inyectable', '10 mg/ml', 'Perros/gatos: 0.1-0.3 mg/kg IV (bolo); infusión 0.2-0.5 mg/kg/h', 'Intravenosa', ARRAY['Perro','Gato'], 'alto', true,
    'Relajación muscular en cirugía abdominal/torácica; intubación; cirugía ocular',
    'Bloqueo neuromuscular (requiere ventilación asistida); hipotensión por histamina; taquicardia',
    'Insuficiencia hepática/renal severa relativa (vía Hofmann independiente); NO usar sin ventilación mecánica',
    'Eliminación por degradación de Hofmann (independiente de órganos): útil en pacientes hepático/renal comprometido. Revertir con neostigmina.',
    'Plumb''s; Lumb & Jones'' Veterinary Anesthesia',
    'https://www.msdvetmanual.com', NULL),
  ('Rocuronio', 'Rocuronio', 'Anestésicos / Bloqueante neuromuscular', 'Solución inyectable', '10 mg/ml', 'Perros: 0.3-0.6 mg/kg IV; gatos: 0.3-0.6 mg/kg IV; inicio 1-2 min', 'Intravenosa', ARRAY['Perro','Gato'], 'alto', true,
    'Relajación muscular para intubación y cirugía; duración media',
    'Bloqueo neuromuscular; hipotensión leve; taquicardia',
    'Insuficiencia hepática/renal severa; NO usar sin ventilación mecánica',
    'Reversible con sugammadex (2-4 mg/kg IV) o neostigmina; duración 20-40 min.',
    'Plumb''s Veterinary Drug Handbook',
    'https://www.msdvetmanual.com', NULL),
  ('Neostigmina', 'Neostigmina', 'Anestésicos / Reversor NM', 'Solución inyectable', '0.5 mg/ml', 'Perros/gatos: 0.02-0.04 mg/kg IV (con atropina 0.02 mg/kg)', 'Intravenosa', ARRAY['Perro','Gato'], 'alto', true,
    'Reversión de bloqueo neuromuscular residual (con atropina/glicopirrolato)',
    'Bradicardia, salivación, vómitos, diarrea (efectos colinérgicos)',
    'Obstrucción intestinal/vesical, bradiarritmias; SIEMPRE con anticolinérgico',
    'Dar cuando hay 2-3 tics de respuesta TOF. Efecto máximo 5-10 min.',
    'Plumb''s Veterinary Drug Handbook',
    'https://www.msdvetmanual.com', NULL)
ON CONFLICT DO NOTHING;

-- ============ ANESTESIA LOCAL / REGIONAL ============
INSERT INTO public.medicamentos (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por)
VALUES
  ('Lidocaína (infiltración)', 'Lidocaína', 'Anestésicos / Local', 'Solución inyectable', '2% (20 mg/ml)', 'Infiltración: 2-4 mg/kg (sin epinefrina), 6-8 mg/kg con epinefrina; bloqueo epidural 4-6 mg/kg', 'Local/Infiltración/Epidural', ARRAY['Perro','Gato'], 'normal', true,
    'Anestesia local por infiltración; bloqueos regionales; epidural; antiarrítmico IV (dosis 1-2 mg/kg)',
    'Parestesia, edema local; toxicidad CNS (convulsiones) si se supera dosis; hipotensión IV rápida',
    'Bloqueos en zonas infectadas; alergia a amidas; no usar en gatos con dosis altas (toxicidad)',
    'Con epinefrina 1:200.000 prolonga duración y reduce sangrado; máximo 6-8 mg/kg.',
    'Plumb''s; MSD Veterinary Manual',
    'https://www.msdvetmanual.com', NULL),
  ('Bupivacaína (regional)', 'Bupivacaína', 'Anestésicos / Local', 'Solución inyectable', '0.5% (5 mg/ml)', 'Infiltración: 1-2 mg/kg; bloqueo regional 1-2 mg/kg; epidural 1-1.5 mg/kg; máximo 2 mg/kg', 'Local/Infiltración/Epidural', ARRAY['Perro','Gato'], 'alto', true,
    'Anestesia regional prolongada (2-4h); epidural; bloqueos dentales',
    'Cardiotoxicidad (arritmias, colapso) en sobredosis IV; depresión miocárdica',
    'NO usar por vía IV; evitar en pacientes cardíacos; no en gatos con dosis altas',
    'Más cardiotóxica que lidocaína; nunca inyectar en vena (aspirar). Sustituto menos tóxico: ropivacaína.',
    'Plumb''s; Lumb & Jones'' Veterinary Anesthesia',
    'https://www.msdvetmanual.com', NULL),
  ('Ropivacaína (regional)', 'Ropivacaína', 'Anestésicos / Local', 'Solución inyectable', '0.2-0.75%', 'Bloqueo regional 1-2 mg/kg; infiltración 1-2 mg/kg; epidural 1.5-2.5 mg/kg', 'Local/Infiltración/Epidural', ARRAY['Perro','Gato'], 'normal', true,
    'Anestesia regional prolongada; menos cardiotóxica que bupivacaína',
    'Parestesia; hipotensión leve; menos cardiotoxicidad que bupivacaína',
    'Alergia a amidas; evitar infiltración en zonas infectadas',
    'Mejor perfil de seguridad cardíaca; duración similar a bupivacaína; más vasoconstrictor intrínseco.',
    'Plumb''s Veterinary Drug Handbook',
    'https://www.msdvetmanual.com', NULL)
ON CONFLICT DO NOTHING;

-- ============ EMERGENCIA / REVERSIÓN ============
INSERT INTO public.medicamentos (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por)
VALUES
  ('Naloxona (anestesia)', 'Naloxona', 'Antídotos / Reversor opioides', 'Solución inyectable', '0.4 mg/ml', 'Perros/gatos: 0.01-0.04 mg/kg IV/IM/SC; repetir 1-2 min si es necesario (vida media corta)', 'Intravenosa/Intramuscular/Subcutánea', ARRAY['Perro','Gato'], 'alto', true,
    'Reversión de depresión respiratoria por opioides; sobredosis',
    'Reversión brusca puede causar excitación, vómitos, taquicardia, hipotensión',
    'No usar en dependientes crónicos (abstinencia); no usar como antídoto de sedantes',
    'Reversión parcial preferida (0.005-0.01 mg/kg) para mantener analgesia; repetir cada 20-60 min.',
    'Plumb''s; MSD Veterinary Manual',
    'https://www.msdvetmanual.com', NULL),
  ('Yohimbina', 'Yohimbina', 'Antídotos / Reversor alpha-2', 'Solución inyectable', '5 mg/ml', 'Perros: 0.1 mg/kg IV; gatos: 0.1 mg/kg IV; equinos 0.075 mg/kg IV', 'Intravenosa', ARRAY['Perro','Gato','Equino'], 'alto', true,
    'Reversión de xilacina y medetomidina (antagonista alpha-2 selectivo)',
    'Taquicardia, excitación, temblores, vómitos, hipotensión transitoria',
    'No usar sin sedación alpha-2 previa; precaución en cardiopatías',
    'Alternativa a atipamezol (más disponible); revertir solo si la sedación es excesiva.',
    'Plumb''s Veterinary Drug Handbook',
    'https://www.msdvetmanual.com', NULL)
ON CONFLICT DO NOTHING;

-- ============ FLUIDOTERAPIA / SOPORTE ANESTÉSICO ============
INSERT INTO public.medicamentos (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por)
VALUES
  ('Lactato de Ringer', 'Lactato de Ringer', 'Fluidoterapia / Cristaloides', 'Solución IV', '1000 ml', 'Shock perros: 90 ml/kg/h; gatos: 45-60 ml/kg/h; mantenimiento 2-4 ml/kg/h', 'Intravenosa', ARRAY['Perro','Gato'], 'normal', true,
    'Reposición de volumen y electrolitos durante anestesia; shock hipovolémico',
    'Sobrecarga de volumen; edema; alteración electrolítica si exceso',
    'Hiperkalemia severa (contiene K+); insuficiencia renal oligúrica',
    'Cristaloide isotónico de primera línea; alternativa: solución salina 0.9%.',
    'MSD Veterinary Manual; Plumb''s',
    'https://www.msdvetmanual.com', NULL),
  ('Cloruro de sodio 0.9%', 'Cloruro de sodio', 'Fluidoterapia / Cristaloides', 'Solución IV', '0.9%', 'Mantenimiento: 2-4 ml/kg/h; shock: 60-90 ml/kg/h (perros)', 'Intravenosa/Subcutánea', ARRAY['Perro','Gato'], 'normal', true,
    'Hidratación IV; diluyente de fármacos; lavado de heridas',
    'Sobrecarga de volumen; hipernatremia; acidosis hiperclorémica con grandes volúmenes',
    'Hipernatremia, insuficiencia cardiaca congestiva',
    'Compatible con casi todos los fármacos IV; preferido para diluir.',
    'MSD Veterinary Manual',
    'https://www.msdvetmanual.com', NULL)
ON CONFLICT DO NOTHING;

-- Actualizar fuentes en sedantes existentes que las tenían genéricas
UPDATE public.medicamentos SET
  fuente = 'Plumb''s Veterinary Drug Handbook; MSD Veterinary Manual',
  url_referencia = 'https://www.msdvetmanual.com'
WHERE familia_terapeutica ILIKE '%Sedantes%' AND fuente IS NULL;

-- Completar via_administracion faltante en anestésicos existentes
UPDATE public.medicamentos SET via_administracion = 'Intravenosa/Intramuscular' WHERE nombre = 'Acepromazina' AND via_administracion IS NULL;
UPDATE public.medicamentos SET via_administracion = 'Intravenosa' WHERE nombre = 'Alfaxalona' AND via_administracion = 'Intravenosa';
UPDATE public.medicamentos SET via_administracion = 'Intravenosa/Intramuscular' WHERE nombre = 'Diazepam' AND via_administracion = 'Intravenosa/Intramuscular';
UPDATE public.medicamentos SET via_administracion = 'Intramuscular/Intravenosa' WHERE nombre = 'Ketamina 10%' AND via_administracion = 'Intramuscular';
UPDATE public.medicamentos SET via_administracion = 'Intramuscular/Intravenosa' WHERE nombre IN ('Medetomidina','Dexmedetomidina') AND via_administracion = 'Intramuscular';
UPDATE public.medicamentos SET via_administracion = 'Intramuscular/Intravenosa' WHERE nombre = 'Tiletamina + Zolazepam' AND via_administracion = 'Intramuscular';
UPDATE public.medicamentos SET via_administracion = 'Intravenosa/Intramuscular' WHERE nombre = 'Midazolam' AND via_administracion = 'Intravenosa/Intramuscular';
UPDATE public.medicamentos SET via_administracion = 'Oral' WHERE nombre IN ('Gabapentina','Trazodona') AND via_administracion = 'Oral';