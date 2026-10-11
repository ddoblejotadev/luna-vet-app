-- ==========================================================================
-- Migración: 202610110015_curacion_final_farmacologica.sql
-- Curación farmacológica masiva (mecanismo, farmacocinética, frecuencia,
-- concentración, dosis, duración) para 224 fármacos.
-- Solo actualiza campos que sean NULL (no sobrescribe datos existentes).
-- Fuentes: Plumb's Veterinary Drug Handbook, Merck Veterinary Manual,
-- FDA DailyMed, VMD (UK) SPC.
-- ==========================================================================

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista dopaminérgico (D2) y alfa-1 adrenérgico; sedación central y ansiólisis.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción IM irregular (inicio 45-90 min). Metabolismo hepático. t½ 4-6 h. Efecto 4-8 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 10)
WHERE nombre = 'Acepromazina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Neuroesteroide que potencia la neurotransmisión GABA-A; inducción hipnótica.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 30-60 s. Metabolismo hepático rápido. Recuperación 10-20 min.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 10),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 3)
WHERE nombre = 'Alfaxalona (IV)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu puro, potente, de acción ultracorta.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 1-2 min. Metabolismo hepático (CYP3A4). t½ 1-2 h. Duración 5-10 min.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 0.5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.005),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Alfentanilo' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Bloqueante neuromuscular no despolarizante (compite con acetilcolina en receptor nicotínico).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Eliminación por Hofmann (pH/temperatura) y esterasas, independiente de hígado/riñón. t½ 20-30 min.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 10),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Atracurio' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anestésico local tipo amida; bloquea canales de Na+ en la membrana axonal.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio 5-15 min, duración 4-8 h. Metabolismo hepático. t½ 2-3 h. Alta unión proteica.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Bupivacaína (regional)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista-antagonista opioide: agonista kappa, agonista parcial mu.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 5 min, IM 10-20 min. Metabolismo hepático. t½ 1.5-3 h. Duración 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 6),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 10),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.4)
WHERE nombre = 'Butorfanol (analgesia)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Bloqueante neuromuscular no despolarizante (isómero cis del atracurio).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Eliminación por Hofmann, independiente de órganos. t½ 20-25 min. Sin liberación de histamina.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 2),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.3)
WHERE nombre = 'Cisatracurio' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anestésico inhalatorio; potencia GABA-A, inhibe NMDA y receptores nicotínicos.'),
  farmacocinetica = COALESCE(farmacocinetica, 'MAC perro 7.2%, gato 10.3%. Eliminación pulmonar >99%. Inducción/recuperación ultrarrápidas.')
WHERE nombre = 'Desflurano' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista alfa-2 adrenérgico altamente selectivo; sedación, analgesia y relajación muscular.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IM 5-10 min. Metabolismo hepático. t½ 2-3 h. Reversible con atipamezol.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 0.5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.001),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.01)
WHERE nombre = 'Dexmedetomidina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu puro, 80-100× más potente que morfina.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 2-5 min. Metabolismo hepático (CYP3A4). t½ 2-4 h. Duración 30-60 min.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 0.05),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.002),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Fentanilo (inyectable)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antimuscarínico (M3) que reduce secreciones salivales y bronquiales; no cruza BHE.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 1-2 min. t½ 0.8-1.3 h. Excreción renal parcial.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 0.2),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.005),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Glicopirrolato' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu puro, 5-7× más potente que morfina.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 5 min. Metabolismo hepático (glucuronidación). t½ 1-2 h. Duración 3-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 6),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 1),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.05),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.2)
WHERE nombre = 'Hidromorfona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anestésico inhalatorio; potencia GABA-A e inhibe NMDA.'),
  farmacocinetica = COALESCE(farmacocinetica, 'MAC perro 1.3%, gato 1.6%. Eliminación pulmonar >99%. Recuperación rápida.')
WHERE nombre = 'Isoflurano' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista NMDA (disociativo); analgesia, amnesia, catalepsia.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 30-60 s. Metabolismo hepático (norketamina). t½ 2-3 h. Duración 15-30 min.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 100),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Ketamina (anestesia)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista NMDA a dosis subanestésica; analgesia antihiperalgesica.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Infusión CRI; metabolito norketamina activo. t½ 2-3 h.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 100),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Ketamina (baja)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anestésico local amida (isómero S de bupivacaína); bloquea canales Na+.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio 5-10 min, duración 4-6 h. Menor cardiotoxicidad que bupivacaína. Metabolismo hepático.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Levobupivacaína' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anestésico local amida; bloquea canales de Na+ en axones.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio 2-5 min, duración 1-2 h (sin epinefrina) o 2-4 h (con epinefrina). Metabolismo hepático.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 20),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 4)
WHERE nombre = 'Lidocaína (infiltración)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anestésico local amida; bloquea canales de Na+.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio 3-5 min, duración 1-2 h. Metabolismo hepático. Vasoconstricción intrínseca (sin epinefrina).'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 20),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 4)
WHERE nombre = 'Mepivacaína' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu + antagonista NMDA; analgesia potente.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 5 min. Metabolismo hepático (CYP). t½ 4-6 h. Duración 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 10),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Metadona (analgesia)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu + antagonista NMDA.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral variable. Metabolismo hepático. t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Metadona oral' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Benzodiacepina; potencia el receptor GABA-A (sedación, amnesia, anxiólisis).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 1-2 min. Metabolismo hepático. t½ 1-2 h. Reversible con flumazenil.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.05),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.3)
WHERE nombre = 'Midazolam' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu puro (referencia); analgesia central.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 20 min. Metabolismo hepático (morfina-6-glucurónido activo). t½ 2-3 h. Duración 3-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 6),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 10),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.05),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Morfina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista opioide mu puro (reversor); compite por el receptor.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 1-2 min. Metabolismo hepático. t½ 30-60 min (más corta que opioides).'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 0.4),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.005),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.04)
WHERE nombre = 'Naloxona (anestesia)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu; analgesia oral.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral buena. Metabolismo hepático (CYP2D6 a oximorfona). t½ 3-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Oxicodona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu puro, 10× más potente que morfina.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 5 min. Metabolismo hepático. t½ 2-3 h. Duración 3-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 6),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 1),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.02),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.1)
WHERE nombre = 'Oximorfona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Hipnótico; potencia GABA-A y bloquea canales de Na+.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 15-30 s. Metabolismo hepático rápido. Recuperación 5-10 min.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 10),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 6)
WHERE nombre = 'Propofol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu puro, ultracorto.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 1 min. Hidrolizado por esterasas sanguíneas (independiente de hígado/riñón). t½ 3-5 min.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 1),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.001),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Remifentanilo' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Bloqueante neuromuscular no despolarizante aminosteroidal.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 1-2 min. Eliminación hepática/biliar. t½ 20-30 min. Reversible con sugammadex/neostigmina.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 10),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.6)
WHERE nombre = 'Rocuronio' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anestésico local amida; bloquea canales Na+; menos cardiotóxica.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio 5-15 min, duración 4-8 h. Metabolismo hepático. t½ 2-3 h.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Ropivacaína (regional)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anestésico inhalatorio; potencia GABA-A e inhibe NMDA.'),
  farmacocinetica = COALESCE(farmacocinetica, 'MAC perro 2.4%, gato 2.6%. Eliminación pulmonar. Inducción/recuperación rápida, no irritante.')
WHERE nombre = 'Sevoflurano' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Bloqueante neuromuscular despolarizante (mimético de acetilcolina).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 30-60 s. Hidrólisis por butirilcolinesterasa. t½ 2-4 min. Contraindicado en riesgo de hipertermia maligna.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 20),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.3),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Succinilcolina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu + inhibidor de la recaptación de noradrenalina (doble mecanismo).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (glucuronidación). t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 3)
WHERE nombre = 'Tapentadol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anestésico local tipo éster; bloquea canales Na+.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio 5-10 min, duración 2-3 h. Metabolismo por pseudocolinesterasa. Mayor toxicidad sistémica.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Tetracaína' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Asociación: tiletamina (disociativo NMDA) + zolazepam (benzodiacepina GABA-A).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IM 5-15 min. Metabolismo hepático. t½ 2-4 h. Duración 20-40 min.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 50),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 8)
WHERE nombre = 'Tiletamina + Zolazepam (Telazol)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Barbitúrico ultracorto; potencia GABA-A (inducción IV).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 10-20 s. Metabolismo hepático. t½ 6-12 h (acumula en grasa).'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 25),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 12)
WHERE nombre = 'Tiopental' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista alfa-2 adrenérgico; sedación, analgesia, relajación muscular.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IM 10-15 min. Metabolismo hepático. t½ 1-2 h. Reversible con yohimbina/atipamezol.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 20),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Xilacina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista alfa-2 adrenérgico (reversor de xilacina/dexmedetomidina).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 2-5 min. Metabolismo hepático. t½ 1-2 h.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 2),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.05),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.2)
WHERE nombre = 'Yohimbina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antimuscarínico competitivo; bloquea receptores M (secreciones, bradicardia).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 1-2 min. Metabolismo hepático. t½ 1-2 h. Efecto 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 0.5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.02),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.04)
WHERE nombre = 'Atropina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista alfa-2 adrenérgico; sedación/analgesia.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IM 5-10 min. Metabolismo hepático. t½ 2-3 h. Reversible con atipamezol.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 1),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.005),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Medetomidina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor de la colinesterasa; aumenta acetilcolina (reversor BNM).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 5-10 min. Metabolismo por colinesterasa. t½ 1-2 h. Usar con anticolinérgico.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 0.5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.02),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.04)
WHERE nombre = 'Neostigmina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antibiótico intramamario (asociación cefalosporina/penicilina); inhibe pared celular.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Aplicación intramamaria; acción local. Vida media local 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24)
WHERE nombre = 'Mastilac' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE; inhibe COX-2 > COX-1 (preferencial); reduce prostaglandinas.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral rápida (Tmax 1-3 h). Unión proteica >99%. Metabolismo hepático. t½ 8-12 h (perro).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2.2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 4.4)
WHERE nombre = 'Carprofeno' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE coxib; inhibe COX-2 selectivo.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica alta. Metabolismo hepático. t½ ~12 h (perro).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Cimicoxib' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE; inhibe COX-1 y COX-2 (no selectivo).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral rápida. Unión proteica >99%. Metabolismo hepático. t½ 2-4 h. NEFRTOXICIDAD en gatos.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Ibuprofeno' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE; inhibe COX y LOX (dual); antiinflamatorio y analgésico.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción IV/IM. Unión proteica >99%. Metabolismo hepático. t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Ketoprofeno' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE; inhibe COX y LOX.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Ketoprofeno oral' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE coxib; inhibe COX-2 selectivo.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ muy larga (~40 días en perro); dosing quincenal/mensual.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 336),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Mavacoxib' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE; inhibe COX-2 > COX-1.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción SC. Unión proteica >97%. Metabolismo hepático. t½ 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.2)
WHERE nombre = 'Meloxicam inyectable' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE; inhibe COX-1 y COX-2.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica >99%. Metabolismo hepático. t½ 12-24 h (perro). TOXICIDAD en gatos.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Naproxeno' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE oxicam; inhibe COX-1 y COX-2; antitumoral (transición epitelial).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica >99%. Metabolismo hepático. t½ 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.3),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.3)
WHERE nombre = 'Piroxicam' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE oxicam; inhibe COX.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ larga (perro ~24 h).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Tenoxicam' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE dual; inhibe COX y LOX (vías ácido araquidónico).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Tepoxalina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE; inhibe COX.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción IV/SC. Metabolismo hepático. t½ 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Vedaprofeno' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor de la recaptación de serotonina y noradrenalina (IRSN); analgesia neuropática.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP1A2/2D6). t½ 12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Duloxetina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'IRSN (inhibidor recaptación serotonina/noradrenalina); dolor neuropático.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP2D6 a O-desmetilvenlafaxina). t½ 5-11 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 3)
WHERE nombre = 'Venlafaxina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Beta-lactámico (aminopenicilina); inhibe síntesis de pared celular (PBPs).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral buena. Unión proteica baja. Metabolismo hepático parcial. t½ 1-2 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 11),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 22)
WHERE nombre = 'Amoxicilina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Aminoglucósido; inhibe subunidad 30S ribosomal (bactericida).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción IM/SC. No metabolizado. t½ 2-3 h. Excreción renal (nefrotóxico/ototóxico).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 250),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 15)
WHERE nombre = 'Amikacina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Macrólido; inhibe subunidad 50S ribosomal (bacteriostático).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Penetra fagocitos. Metabolismo hepático. t½ 12-24 h. Excreción biliar.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Azitromicina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Cefalosporina 1ª gen; inhibe síntesis pared celular (PBPs).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. No metabolizado. t½ 1-2 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 22),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 30)
WHERE nombre = 'Cefadroxila' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Cefalosporina 1ª gen IV; inhibe pared celular.'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV/IM. No metabolizado. t½ 1-2 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 500),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 22),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 30)
WHERE nombre = 'Cefazolina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Cefalosporina 3ª gen de acción prolongada; inhibe pared celular.'),
  farmacocinetica = COALESCE(farmacocinetica, 'SC. t½ ~5-7 días (perro/gato); dosing quincenal. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 336),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 3.6),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 8)
WHERE nombre = 'Cefovecina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Cefalosporina 3ª gen oral; inhibe pared celular.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 2-3 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Cefpodoxima' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Cefalosporina 3ª gen; inhibe pared celular.'),
  farmacocinetica = COALESCE(farmacocinetica, 'IM/SC. t½ 8-24 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2.2)
WHERE nombre = 'Ceftiofur' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Fluoroquinolona; inhibe ADN girasa y topoisomerasa IV.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral variable. Metabolismo hepático parcial. t½ 4-6 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 20)
WHERE nombre = 'Ciprofloxacina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Lincosamida; inhibe subunidad 50S ribosomal.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IM. Unión proteica alta. Metabolismo hepático. t½ 2-3 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 11)
WHERE nombre = 'Clindamicina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibe subunidad 50S ribosomal (bacteriostático).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (glucuronidación). t½ 4-8 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 25),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 50)
WHERE nombre = 'Cloranfenicol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Fluoroquinolona; inhibe ADN girasa.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/SC. Metabolismo hepático (ciprofloxacina). t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 20)
WHERE nombre = 'Enrofloxacina 10%' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Aminoglucósido; inhibe subunidad 30S ribosomal.'),
  farmacocinetica = COALESCE(farmacocinetica, 'IM/IV/SC. No metabolizado. t½ 2-3 h. Excreción renal (nefrotóxico).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 40),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 6),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Gentamicina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Fluoroquinolona 3ª gen; inhibe ADN girasa.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/SC. Metabolismo hepático parcial. t½ 10-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Marbofloxacina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Nitroimidazol; genera radicales libres que dañan ADN (anaerobios/protozoos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV. Penetra BHE. Metabolismo hepático. t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 25)
WHERE nombre = 'Metronidazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Daña ADN/ARN y síntesis proteica bacteriana (urinarios).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Excreción renal rápida. t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 4),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Nitrofurantoína' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Fluoroquinolona; inhibe ADN girasa.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 4-6 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Ofloxacina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Fluoroquinolona; inhibe ADN girasa.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 5-6 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 7.5)
WHERE nombre = 'Orbifloxacina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Fluoroquinolona 3ª gen; inhibe ADN girasa.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 6-7 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 3),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 7.5)
WHERE nombre = 'Pradofloxacina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibe ARN polimerasa bacteriana (bactericida).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP). t½ 3-5 h. Inductor enzimático.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Rifampicina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Sulfamida; inhibe síntesis de ácido fólico (DHPS).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica alta. Metabolismo hepático. t½ 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 25),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 50)
WHERE nombre = 'Sulfadimetoxina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Asociación sinérgica: sulfamida (DHPS) + trimetoprima (DHFR); bloquean folato.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 6-12 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 15),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 30)
WHERE nombre = 'Sulfametoxazol + Trimetoprima' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Aminoglucósido; inhibe subunidad 30S ribosomal.'),
  farmacocinetica = COALESCE(farmacocinetica, 'IM/IV/SC. No metabolizado. t½ 2-3 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 4),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 6)
WHERE nombre = 'Tobramicina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Macrólido; inhibe subunidad 50S ribosomal.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción IM. Metabolismo hepático. t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Tylosina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Isoxazolina; antagonista GABA-glutamato (ectoparásitos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica >99%. Metabolismo hepático. t½ 12-15 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 720),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 6.5)
WHERE nombre = 'Afoxolaner' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Formamidina; agonista alfa-2 octopamina (artrópodos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción cutánea. Metabolismo hepático. t½ 24-72 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 168)
WHERE nombre = 'Amitraz' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inmoviliza microfilarias (altera membrana); filariasis.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 20)
WHERE nombre = 'Diethylcarbamaza' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Espinosina; agonista nicotínico acentilcolina (insectos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 2-3 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 720),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 30),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 50)
WHERE nombre = 'Espinosad' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Benzimidazol; inhibe captación de glucosa (helmintos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral; metabolito activo fenbendazol. t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 20)
WHERE nombre = 'Febantel' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Benzimidazol; inhibe tubulina/microtúbulos (helmintos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 10-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 50),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 100)
WHERE nombre = 'Fenbendazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Fenilpirazol; antagonista GABA (insectos/acarinos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción cutánea. Unión proteica alta. Metabolismo hepático. t½ 2-4 semanas.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 720)
WHERE nombre = 'Fipronil' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Isoxazolina; antagonista GABA-glutamato.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica >99%. Metabolismo hepático. t½ 12-15 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 2160),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 25),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 50)
WHERE nombre = 'Fluralaner' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Neonicotinoide; agonista nicotínico acentilcolina (insectos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción cutánea. Metabolismo hepático. t½ 1-2 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 720)
WHERE nombre = 'Imidacloprid' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Avermectina; agonista glutamato (cloruro) en invertebrados.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/SC. Unión proteica alta. Metabolismo hepático. t½ 2-3 días. NO en collies (MDR1).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 720),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.6)
WHERE nombre = 'Ivermectina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Isoxazolina; antagonista GABA-glutamato.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ ~30 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 720),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 20),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 43)
WHERE nombre = 'Lotilaner' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Benzimidazol; inhibe tubulina (helmintos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 3-9 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 20),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 25)
WHERE nombre = 'Mebendazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Avermectina; agonista glutamato (nemátodos, filarias).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 2-4 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 720),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Milbemicina Oxima' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Milbemicina; agonista glutamato/GABA (nemátodos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/SC. Unión proteica alta. Metabolismo hepático. t½ 2-4 semanas.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 2160),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.17),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Moxidectina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Piretroide; bloquea canales Na+ (artrópodos). TOXICIDAD en gatos.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción cutánea. Metabolismo hepático. t½ 2-3 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 336)
WHERE nombre = 'Permetrina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Aumenta permeabilidad Ca²⁺ en cestodos (parálisis, tegumento).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (1º paso). t½ 1-2 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Praziquantel' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Bloqueante neuromuscular despolarizante (nemátodos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral escasa (actúa intraluminal). t½ 1-2 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Pirantel Pamoato' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Avermectina; agonista glutamato/GABA (ecto/endoparásitos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción cutánea. Unión proteica alta. Metabolismo hepático. t½ 2-3 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 720),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 6),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 12)
WHERE nombre = 'Selamectina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Isoxazolina; antagonista GABA-glutamato.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 10-12 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 720),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 4)
WHERE nombre = 'Sarolaner' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Benzimidazol; inhibe tubulina (helmintos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Oxfendazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Benzimidazol; inhibe tubulina (helmintos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 15)
WHERE nombre = 'Oxibendazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Neonicotinoide; agonista nicotínico (pulgas, acción rápida).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral rápida. Metabolismo hepático. t½ 1-2 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Nitenpiram' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Triazinona; daña orgánulos de coccidios (coccidiostático/cida).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (toltonisomida). t½ 2-4 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 20)
WHERE nombre = 'Toltrazuril' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Nitroimidazol; radicales libres dañan ADN (Tritrichomonas).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 30),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 50)
WHERE nombre = 'Ronidazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Toltrazuril derivado; daña orgánulos de apicomplejos.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 2-4 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 20),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 50)
WHERE nombre = 'Ponazuril' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Fosfolípido; altera membrana y vía de señalización (Leishmania).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 7-10 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2.5)
WHERE nombre = 'Miltefosina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'MAb anti-IL-31 canino; antiprurítico (dermatitis atópica).'),
  farmacocinetica = COALESCE(farmacocinetica, 'SC. t½ 16-30 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 2160),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 3)
WHERE nombre = 'Lokivetmab' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Análogo GnRH; ↓ gonadotropinas (supresión reproductiva).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Implante SC. t½ 2-4 semanas.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 2160)
WHERE nombre = 'Deslorelina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Bloqueador de canales de Ca²⁺ (dihidropiridínico); vasodilatador.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica >90%. Metabolismo hepático. t½ 30-50 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.3)
WHERE nombre = 'Amlodipino' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Beta-bloqueante selectivo (β1); reduce FC y contractilidad.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. No metabolizado. t½ 6-7 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Atenolol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'IECA; inhibe ECA, ↓ angiotensina II (vasodilatador).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral; profármaco (benazeprilato). t½ 10-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.25),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Benazepril' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'IECA; inhibe ECA (vasodilatador).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 2-3 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Captopril' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Beta-bloqueante no selectivo + alfa-1; vasodilatador.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP2D6). t½ 7-10 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Carvedilol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antiplaquetario; antagonista P2Y12 (inhibe agregación plaquetaria).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral; profármaco (CYP2C19). t½ 6-8 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Clopidogrel' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Glucósido cardíaco; inhibe Na⁺/K⁺-ATPasa (inotropo positivo).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 30-40 h (perro). Excreción renal. Ventana terapéutica estrecha.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.003),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.01)
WHERE nombre = 'Digoxina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Bloqueador de canales de Ca²⁺ (benzotiazepínico); antiarrítmico/vasodilatador.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP3A4). t½ 3-5 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1.5)
WHERE nombre = 'Diltiazem' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'IECA; inhibe ECA (vasodilatador, ↓ remodelado).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral; profármaco (enalaprilato). t½ 12-14 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.25),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Enalapril' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista aldosterona (diurético ahorrador de K⁺); antiandrógeno.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral; metabolito canrenona. t½ 1-2 h (perro).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Espironolactona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista alfa-1; vasoconstrictor (incontinencia urinaria por UR).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Fenilpropanolamina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Vasodilatador arteriolar directo (NO).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (acetilación). t½ 3-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Hidralazina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Diurético tiazídico; inhibe NCC (↑ excreción Na⁺/Cl⁻).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 6-15 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 4)
WHERE nombre = 'Hidroclorotiazida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'ARA-II; antagonista AT1 (bloquea angiotensina II).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral; metabolito activo (E-3174). t½ 6-9 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1.5)
WHERE nombre = 'Losartán' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Beta-bloqueante selectivo (β1).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP2D6). t½ 3-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Metoprolol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inotropo positivo (sensibiliza Ca²⁺) + inhibidor PDE3 (vasodilatador).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 2-4 h (perro).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.15),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.3)
WHERE nombre = 'Pimobendán' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor PDE5; vasodilatador (hipertensión pulmonar).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP3A4). t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Sildenafilo' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Diurético de asa; inhibe NKCC2 (ascendente grueso).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.4)
WHERE nombre = 'Torsemida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Diurético de asa; inhibe NKCC2 (↑ excreción Na⁺/K⁺/Cl⁻).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV. t½ 2-4 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 6)
WHERE nombre = 'Furosemida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista dopaminérgico (D2); ↓ prolactina.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 65 h (larga).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.005),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Cabergolina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Análogo de vasopresina; agonista V2 (antidiurético).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/nasal. t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.001),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.005)
WHERE nombre = 'Desmopresina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Mineralocorticoide; sustituye aldosterona (enf. Addison).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inyectable de depósito. t½ 2-4 semanas.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 672),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 3)
WHERE nombre = 'Desoxicorticosterona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Glucocorticoide potente; antiinflamatorio/inmunosupresor.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV. t½ 36-54 h (perro). Potencia 25× hidrocortisona.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.05),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Dexametasona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Mineralocorticoide; sustituye aldosterona (Addison).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.01),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Fludrocortisona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Hormona tiroidea T4; sustituye hipotiroidismo.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 6-8 días (perro). Conversión a T3.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.01),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Levotiroxina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antitiroidal; inhibe peroxidasa tiroidea (↓ síntesis T3/T4).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 6-8 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Metimazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Adrenolítico; destruye corteza suprarrenal (hiperadrenocorticismo).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Acumula en grasa. t½ 18-160 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 25),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 50)
WHERE nombre = 'Mitotano' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Glucocorticoide; antiinflamatorio/inmunosupresor.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 2-4 h (perro). Potencia 4× hidrocortisona.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Prednisolona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibe 3β-HSD (↓ síntesis cortisol; HAC).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 4-6 h (perro).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Trilostano' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Biguanida; ↓ gluconeogénesis hepática, ↑ sensibilidad insulina.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. No metabolizado. t½ 4-6 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Metformina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Sulfonilurea; estimula secreción insulina (β pancreáticas).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Glipizida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Hormona; ↓ glucemia (captación glucosa, ↑ síntesis glucógeno).'),
  farmacocinetica = COALESCE(farmacocinetica, 'SC/IM. t½ variable según formulación (regular 5-8 h; NPH 12-18 h; glargina 24 h).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12)
WHERE nombre = 'Insulina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista 5-HT4; ↑ motilidad GI (procinético).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP3A4). t½ 6-10 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Cisaprida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista dopaminérgico (D2) periférico; antiemético/procinético.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 7-8 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Domperidona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista H2; ↓ secreción ácido gástrico.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 2-4 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Famotidina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista D2 + agonista 5-HT4; antiemético/procinético.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV. Cruza BHE. t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Metoclopramida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Análogo PGE1; gastroprotector, ↑ moco/bicarbonato.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 1-2 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Misoprostol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista 5-HT3; antiemético (vómitos quimioterapia/urémicos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV. Metabolismo hepático (CYP). t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Ondansetrón' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista H2; ↓ secreción ácido gástrico.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 2-3 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Ranitidina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Complejo aluminio; forma barrera protectora sobre úlceras.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral mínima (actúa local). t½ 5 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Sucralfato' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista NK1; antiemético central (vómitos por cualquier causa).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/SC. Unión proteica alta. Metabolismo hepático. t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Maropitant' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu periférico; ↓ motilidad GI (antidiarreico).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 7-14 h. NO en collies (MDR1).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.05),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.2)
WHERE nombre = 'Loperamida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Polieno; se une ergosterol (poros membrana fúngica).'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV. Unión proteica >90%. t½ 15-24 h. NEFRTOXICIDAD.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 48),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Anfotericina B' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Triazol; inhibe lanosterol 14α-desmetilasa (ergosterol).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Penetra BHE. t½ 24 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Fluconazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibe mitosis fúngica (microtúbulos); dermatofitos.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (con grasa). Deposita en queratina. t½ 24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 50)
WHERE nombre = 'Griseofulvina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Triazol; inhibe lanosterol 14α-desmetilasa.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (cápsulas con ácido). Unión proteica >99%. t½ 24-30 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Itraconazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Imidazol; inhibe lanosterol 14α-desmetilasa.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (con ácido). Metabolismo hepático (CYP3A4). t½ 8-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Ketoconazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Alilamina; inhibe escualeno epoxidasa (fungicida).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica >99%. Metabolismo hepático. t½ 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 40)
WHERE nombre = 'Terbinafina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Triazol de amplio espectro; inhibe ergosterol.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (con alimento). t½ 24-30 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Posaconazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Análogo guanosina; inhibe ADN polimerasa viral (herpes).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 2-4 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 20)
WHERE nombre = 'Aciclovir' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Profármaco de penciclovir; inhibe ADN polimerasa viral.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral; metabolito activo. t½ 2-3 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 40),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 90)
WHERE nombre = 'Famciclovir' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Profármaco de aciclovir; inhibe ADN polimerasa viral.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral; metabolito aciclovir. t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 20),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 40)
WHERE nombre = 'Valaciclovir' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Citoquina; activa respuesta antiviral inmunidad innata.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Oral/sublingual. t½ horas.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24)
WHERE nombre = 'Interferón omega' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antiepiléptico; estabiliza membrana neuronal (Cl⁻).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 12-45 días (perro). Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 20),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 40)
WHERE nombre = 'Bromuro de potasio' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Barbitúrico; potencia GABA-A (antiepiléptico).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP). t½ 40-90 h (perro). Inductor enzimático.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Fenobarbital' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Análogo GABA; modula canales Ca²⁺ α2δ (dolor neuropático/epilepsia).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (transporte saturable). No metabolizado. t½ 3-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 15)
WHERE nombre = 'Gabapentina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Modula vesícula SV2A (liberación neurotransmisores).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. No metabolizado. t½ 3-4 h (perro).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 30)
WHERE nombre = 'Levetiracetam' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Bloquea canales Na⁺ y Ca²⁺; inhibe anhidrasa carbónica.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 15-20 h (perro).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 15)
WHERE nombre = 'Zonisamida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista parcial GABA-A (benzodiacepínico); antiepiléptico.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 2-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 30)
WHERE nombre = 'Imepitoin' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Benzodiacepina; potencia GABA-A (ansiolítico).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.01),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.1)
WHERE nombre = 'Alprazolam' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Tricíclico; inhibe recaptación 5-HT/noradrenalina.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP2D6). t½ 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Amitriptilina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Tricíclico; inhibe recaptación serotonina (ansiedad/compulsión).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 3)
WHERE nombre = 'Clomipramina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'ISRS; inhibe recaptación serotonina.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP2D6). t½ 1-3 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Fluoxetina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'ISRS; inhibe recaptación serotonina.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP2D6). t½ 12-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Paroxetina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor MAO-B; ↑ dopamina (cognición/disfunción).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Selegilina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antidepresivo; antagonista 5-HT2 + inhibe recaptación 5-HT.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 6-8 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Trazodona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista alfa-2 central; ↓ noradrenalina (ansiedad/TA).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 6-20 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.01),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.1)
WHERE nombre = 'Clonidina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Precursor glutatión; detoxifica NAPQI (paracetamol).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV. t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 6),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 140),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 140)
WHERE nombre = 'Acetilcisteína' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista alfa-2; revierte sedación (dexmedetomidina/xilacina).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IM 3-5 min. Metabolismo hepático. t½ 2-3 h.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.05),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Atipamezol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Adsorbe toxinas en luz GI (evita absorción).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Oral. No absorbido. Actúa intraluminal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 6),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 3)
WHERE nombre = 'Carbón activado' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista benzodiacepínico (reversor GABA-A).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 1-2 min. Metabolismo hepático. t½ 40-80 min.'),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.005),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Flumazenil' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Cofactor síntesis factores II/VII/IX/X (antídoto rodenticidas).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (con grasa). t½ 1-2 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Vitamina K1' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor anhidrasa carbónica; ↓ humor acuoso (glaucoma).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico ocular. t½ local 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12)
WHERE nombre = 'Dorzolamida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Análogo PGF2α; ↑ drenaje humor acuoso (glaucoma).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico ocular. t½ local 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24)
WHERE nombre = 'Latanoprost' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antimuscarínico; midriasis/cicloplejia (diagnóstico).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico ocular. t½ local 2-6 h.')
WHERE nombre = 'Tropicamida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Beta-bloqueante; ↓ humor acuoso (glaucoma).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico ocular. t½ local 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12)
WHERE nombre = 'Timolol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE tópico; inhibe COX (inflamación ocular).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico ocular. t½ local 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12)
WHERE nombre = 'Diclofenaco' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Imidazol; inhibe ergosterol (hongos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico. Absorción mínima.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24)
WHERE nombre = 'Clotrimazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Imidazol; inhibe ergosterol (hongos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico. Absorción mínima.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24)
WHERE nombre = 'Miconazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Aminoglucósido; inhibe 30S ribosomal.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico/ótico. Absorción mínima.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12)
WHERE nombre = 'Neomicina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Catión; altera membrana Gram-negativos.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico/ótico. Absorción mínima.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12)
WHERE nombre = 'Polimixina B' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibe EF-G (síntesis proteica estafilococos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico. Absorción mínima.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12)
WHERE nombre = 'Fusidato' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Sulfamida; inhibe síntesis folato.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Tópico. Absorción mínima.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24)
WHERE nombre = 'Sulfadiazina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibe xantina oxidasa; ↓ ácido úrico (urolitiasis).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 1-3 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 15)
WHERE nombre = 'Alopurinol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista H2; ↓ ácido gástrico; inhibe CYP.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 2-3 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 3),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Cimetidina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Cofactor cadena respiratoria; antioxidante.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (con grasa). t½ 30 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Coenzima Q10' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Glicosaminoglicano; soporte cartílago/articular.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral parcial. t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 15)
WHERE nombre = 'Condroitina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Aminoazúcar; precursor proteoglicanos articulares.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 20)
WHERE nombre = 'Glucosamina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Cofactor β-oxidación ácidos grasos (miocardiopatía).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 2-15 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 50),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 100)
WHERE nombre = 'L-Carnitina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Hemostático; ↑ resistencia capilar, ↓ sangrado.'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV/IM/SC. t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 125),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Etamsilato' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antifibrinolítico; inhibe plasminógeno (hemostasia).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV. t½ 2-3 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 20)
WHERE nombre = 'Tranexámico' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista alfa no selectivo (irreversible); obstrucción uretral.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión irreversible. t½ 24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.25),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Fenoxibenzamina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista alfa-1; vasodilatador/relajante uretral.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 2-3 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Prazosina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista dopaminérgico (D2); ↓ prolactina.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 3-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.01),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.05)
WHERE nombre = 'Bromocriptina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Neuropéptido; contracción uterina/eyección láctea.'),
  farmacocinetica = COALESCE(farmacocinetica, 'IM/IV. t½ 3-10 min.'),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 20)
WHERE nombre = 'Oxitocina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor PDE; broncodilatador (↑ cAMP).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV. Metabolismo hepático. t½ 8-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 15)
WHERE nombre = 'Aminofilina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor PDE; broncodilatador.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 8-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 15)
WHERE nombre = 'Teofilina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antraciclina; intercala ADN e inhibe topoisomerasa II (quimioterapia).'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV. Unión proteica alta. Metabolismo hepático. t½ 20-48 h. CARDIOTOXICIDAD.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 2160),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Doxorrubicina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Alquilante; cross-link ADN (quimioterapia).'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV. Excreción renal. t½ 2-6 h. Mielosupresor.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 504),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 200),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 300)
WHERE nombre = 'Carboplatino' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Nitrogenada; cross-link ADN (quimioterapia/inmunosupresor).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV; profármaco (CYP). t½ 4-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 50),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 200)
WHERE nombre = 'Ciclofosfamida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inmunosupresor; inhibe calcineurina (↓ IL-2).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP3A4). t½ 8-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Ciclosporina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Nitrosourea; cross-link ADN (quimioterapia).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 1-2 días. Mielosupresor.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 2160),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 50),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 90)
WHERE nombre = 'Lomustina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor tirosina-cinasa (c-kit, PDGFR); mastocitoma.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica alta. t½ 8-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 7.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 12.5)
WHERE nombre = 'Masitinib' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor tirosina-cinasa (c-kit, VEGFR); tumores mastocitarios.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 8-24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 48),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 3)
WHERE nombre = 'Toceranib' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Aminoácido; combustible enterocitos (mucosa GI).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 1-2 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 250),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 500)
WHERE nombre = 'L-Glutamina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Cofactor cobalamina; maduración eritrocitos/neuronas.'),
  farmacocinetica = COALESCE(farmacocinetica, 'IM/SC/oral. t½ 6-12 días. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 168),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 250),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1000)
WHERE nombre = 'Vitamina B12' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antioxidante liposoluble; protege membranas.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (con grasa). t½ 2-3 días.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 10)
WHERE nombre = 'Vitamina E' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Donador metilo; hepatoprotector, ↑ glutatión.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 20),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 40)
WHERE nombre = 'S-adenosilmetionina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Flavonoide; hepatoprotector/antioxidante (Cardo Mariano).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (fosfolípido). t½ 6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 30)
WHERE nombre = 'Silimarina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Provitamina B5; hidratante/cicatrizante.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción cutánea. t½ 24 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24)
WHERE nombre = 'Dexpantenol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Diurético osmótico; ↑ presión osmótica (edema cerebral).'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV. No metabolizado. t½ 1-2 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 6),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.25),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Manitol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anticoagulante; potencia antitrombina III (inhibe IIa/Xa).'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV/SC. t½ 1-2 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 100),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 300)
WHERE nombre = 'Heparina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anticoagulante oral; inhibe factores dependientes vit K (II/VII/IX/X).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP2C9). t½ 20-60 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.2)
WHERE nombre = 'Warfarina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE; inhibe COX-1/2 (irreversible plaquetario).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 3-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 25)
WHERE nombre = 'Aspirina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Solución cristaloide; expansión volemica, electrolitos.'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV/SC. Distribución extracelular. Sin metabolismo.')
WHERE nombre = 'Lactato de Ringer' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Solución cristaloide isotónica; expansión volemica.'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV/SC. Distribución extracelular. Sin metabolismo.')
WHERE nombre = 'Cloruro de sodio 0.9%' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Solución cristaloide; aporte calórico/agua libre.'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV. Distribución total corporal. Metabolismo rápido.')
WHERE nombre = 'Dextrosa 5%' AND activo = true;
