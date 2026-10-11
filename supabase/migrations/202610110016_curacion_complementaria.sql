-- ==========================================================================
-- Migración: 202610110016_curacion_complementaria.sql
-- Curación complementaria: 43 fármacos que no matchearon en la ronda anterior.
-- Solo actualiza campos NULL.
-- ==========================================================================

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista NMDA + agonista dopaminérgico; analgesia adyuvante (dolor neuropático).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático parcial. t½ 6-12 h (perro). Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 3),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Amantadina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista parcial opioide mu; analgesia moderada, efecto techo.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 10-15 min, transmucosa 30-60 min. Metabolismo hepático (CYP3A4). t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 8),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 0.3),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.01),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.03)
WHERE nombre = 'Buprenorfina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antihistamínico H1 2ª gen (no sedante); prurito/dermatitis alérgica.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático parcial. t½ 8-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Cetirizina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu (débil); profármaco de morfina (CYP2D6). Antitusígeno.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP2D6 a morfina). t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Codeína' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE coxib; inhibe COX-2 selectivo.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica alta. Metabolismo hepático. t½ 2-3 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 4)
WHERE nombre = 'Deracoxib' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Benzodiacepina; potencia GABA-A (ansiolítico, relajante muscular, anticonvulsivante).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 1-3 min. Metabolismo hepático (CYP2C19). t½ 2-5 h (perro). Reversible con flumazenil.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 5),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Diazepam' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antihistamínico H1 1ª gen (sedante); antiprurítico/antiemético.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IM. Metabolismo hepático. t½ 4-8 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 4)
WHERE nombre = 'Diphenhydramina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antraciclina; intercala ADN e inhibe topoisomerasa II (quimioterapia).'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV. Unión proteica alta. Metabolismo hepático. t½ 20-48 h. CARDIOTOXICIDAD.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 504),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Doxorubicina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista alfa+beta adrenérgico (catecolamina); vasopresión, broncodilatación, inotropo.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio IV 1-2 min. Metabolismo por COMT/MAO. t½ 2-3 min.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 1),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.01),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Epinefrina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista opioide mu puro; analgesia transdérmica prolongada.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción transdérmica, inicio 12-24 h, duración 72 h. Metabolismo hepático. t½ 2-4 h (plasma).'),
  frecuencia_horas = COALESCE(frecuencia_horas, 72),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.002),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.005)
WHERE nombre = 'Fentanilo (parche)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor 5α-reductasa; ↓ dihidrotestosterona (hiperplasia prostática benigna).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP3A4). t½ 5-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.5)
WHERE nombre = 'Finasterida' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE coxib; inhibe COX-2 selectivo (aprobado perro/caballo).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Unión proteica >96%. Metabolismo hepático. t½ 8-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 5)
WHERE nombre = 'Firocoxib' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE potente; inhibe COX-1/2. Analgesia visceral.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción IV/IM. Unión proteica >99%. Metabolismo hepático. t½ 3-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1.1)
WHERE nombre = 'Flunixin Meglumina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anti-PGE2 (antagonista EP4); AINE no tradicional (no inhibe COX).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 8-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Grapiprant' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antihistamínico H1 1ª gen; ansiolítico/antiprurítico.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (a cetirizina). t½ 4-8 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Hidroxizina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Anestésico local amida; bloquea canales de Na+ en axones.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inicio 2-5 min, duración 1-2 h. Metabolismo hepático. t½ 1-2 h.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 20),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 4)
WHERE nombre = 'Lidocaína' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antihistamínico H1 2ª gen (no sedante).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP3A4/2D6 a desloratadina). t½ 8-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Loratadina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Glucocorticoide; antiinflamatorio/inmunosupresor (potencia 5× hidrocortisona).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV/IM. Metabolismo hepático. t½ 18-36 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Metilprednisolona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista alfa>beta adrenérgico; vasopresión (shock).'),
  farmacocinetica = COALESCE(farmacocinetica, 'CRI IV. Metabolismo rápido (COMT/MAO). t½ 2-3 min.'),
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 1),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Norepinefrina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor JAK (JAK1); ↓ citoquinas pruritogénicas (dermatitis atópica).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.4),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.6)
WHERE nombre = 'Oclacitinib' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Ácidos grasos poliinsaturados; antiinflamatorio (↓ ácido araquidónico).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (con grasa). Incorporación en membranas 4-6 semanas.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 40),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 100)
WHERE nombre = 'Omega-3 (EPA/DHA)' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor bomba protones (IBP); ↓ ácido gástrico (H+/K+-ATPasa).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IV. Metabolismo hepático (CYP2C19). t½ 1-2 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Pantoprazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Analgésico/antipirético; mecanismo central (COX-3/endocannabinoide). HEPATOTÓXICO en gatos.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral rápida. Metabolismo hepático (glucuronidación). t½ 1-3 h. CONTRAINDICADO en gatos.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 15)
WHERE nombre = 'Paracetamol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Glucocorticoide; profármaco (se convierte en prednisolona en hígado).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (a prednisolona). t½ 2-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Prednisona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Análogo GABA; modula canales Ca²⁺ α2δ (dolor neuropático/epilepsia).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. No metabolizado. t½ 6-7 h (perro). Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 4)
WHERE nombre = 'Pregabalina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Beta-bloqueante no selectivo (β1+β2); antiarrítmico, antihipertensivo.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP2D6/1A2). t½ 3-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.2),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Propranolol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor bomba protones (IBP); ↓ ácido gástrico.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 1-2 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Rabeprazol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'IECA; inhibe ECA (vasodilatador).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral; profármaco (ramiprilato). t½ 12-14 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.125),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.25)
WHERE nombre = 'Ramipril' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'AINE coxib; inhibe COX-2 selectivo (aprobado gato).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/SC. t½ 1-2 h. Alta selectividad inflamatoria.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Robenacoxib' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista β2 adrenérgico; broncodilatador.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Inhalación/oral. Inicio inhalatorio 5 min. Metabolismo hepático. t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.02),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.05)
WHERE nombre = 'Salbutamol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Donador metilo; hepatoprotector, ↑ glutatión.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (ayunas). t½ 4-6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 20),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 40)
WHERE nombre = 'SAMe' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Flavonoide; hepatoprotector/antioxidante (Cardo Mariano).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral (fosfatidilcolina). t½ 6 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 30)
WHERE nombre = 'Silymarina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Beta-bloqueante no selectivo; antiarrítmico clase III (prolonga QT).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. No metabolizado. t½ 4-8 h. Excreción renal.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 3)
WHERE nombre = 'Sotalol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Inhibidor PDE5; vasodilatador (hipertensión pulmonar).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP3A4). t½ 17 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 1)
WHERE nombre = 'Tadalafilo' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Antagonista alfa-1a; relajante uretral/prostático.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP3A4/2D6). t½ 9-15 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.01),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.05)
WHERE nombre = 'Tamsulosina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Aminoácido; soporte miocárdico (cardiomiopatía dilatada felina).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Sin metabolismo (excreción renal). t½ 1-2 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 250),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 500)
WHERE nombre = 'Taurina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'ARA-II; antagonista AT1 (antihipertensivo, nefroprotector gato).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático. t½ 7-8 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 2)
WHERE nombre = 'Telmisartán' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Agonista β2 adrenérgico; broncodilatador.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/SC. Metabolismo hepático. t½ 3-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.01),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.02)
WHERE nombre = 'Terbutalina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Glucocorticoide; antiinflamatorio/inmunosupresor.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IM depot. Metabolismo hepático. t½ 12-36 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.1),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.2)
WHERE nombre = 'Triamcinolona' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Ácido ursodesoxicólico; citoprotector hepático (↓ ácidos biliares tóxicos).'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Recirculación enterohepática. t½ 3-4 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 10),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 15)
WHERE nombre = 'Ursodiol' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Alcaloide de la vinca; inhibe mitosis (quimioterapia).'),
  farmacocinetica = COALESCE(farmacocinetica, 'IV. Metabolismo hepático (CYP3A4). t½ 1-2 h. Mielosupresor.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 168),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 0.5),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 0.7)
WHERE nombre = 'Vincristina' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Coenzimas grupo B; metabolismo celular, eritropoyesis.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral/IM. Excreción renal (exceso). t½ variable.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 24)
WHERE nombre = 'Vitamina B Complex' AND activo = true;

UPDATE public.medicamentos SET
  mecanismo_accion = COALESCE(mecanismo_accion, 'Triazol 2ª gen; inhibe lanosterol 14α-desmetilasa.'),
  farmacocinetica = COALESCE(farmacocinetica, 'Absorción oral. Metabolismo hepático (CYP2C19/3A4). t½ 6-12 h.'),
  frecuencia_horas = COALESCE(frecuencia_horas, 12),
  dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, 3),
  dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, 6)
WHERE nombre = 'Voriconazol' AND activo = true;
