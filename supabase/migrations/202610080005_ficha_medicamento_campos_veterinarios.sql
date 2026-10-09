-- ============================================================================
-- CAMPOS VETERINARIOS AMPLIADOS PARA FICHA DEL MEDICAMENTO
-- ============================================================================
-- Agrega metadatos para la ficha detallada: indicaciones, laboratorio,
-- clasificación legal, conservación y registros sanitarios locales.
-- Los números de registro SAG/SENASA se completan cuando se verifiquen
-- oficialmente (no se inventan).
-- ============================================================================

ALTER TABLE public.medicamentos
  ADD COLUMN IF NOT EXISTS indicaciones TEXT,
  ADD COLUMN IF NOT EXISTS laboratorio VARCHAR(255),
  ADD COLUMN IF NOT EXISTS conservacion TEXT,
  ADD COLUMN IF NOT EXISTS clasificacion VARCHAR(50) DEFAULT 'Receta veterinaria',
  ADD COLUMN IF NOT EXISTS registro_sag VARCHAR(100),
  ADD COLUMN IF NOT EXISTS registro_senasa VARCHAR(100);

ALTER TABLE public.medicamentos
  DROP CONSTRAINT IF EXISTS medicamentos_clasificacion_check;

ALTER TABLE public.medicamentos
  ADD CONSTRAINT medicamentos_clasificacion_check
  CHECK (clasificacion IN ('Receta veterinaria', 'Controlado', 'Uso hospitalario', 'Suplemento'));

CREATE INDEX IF NOT EXISTS idx_medicamentos_clasificacion
  ON public.medicamentos(clasificacion);

CREATE INDEX IF NOT EXISTS idx_medicamentos_laboratorio
  ON public.medicamentos(laboratorio);

-- ----------------------------------------------------------------------------
-- Clasificación legal/regulatoria
-- ----------------------------------------------------------------------------
UPDATE public.medicamentos
SET clasificacion = 'Controlado'
WHERE nombre IN (
  'Morfina', 'Codeína', 'Fentanilo', 'Buprenorfina', 'Tramadol',
  'Ketamina', 'Propofol', 'Tiletamina + Zolazepam', 'Xilazina 2%',
  'Midazolam', 'Diazepam', 'Alprazolam', 'Fenobarbital'
);

UPDATE public.medicamentos
SET clasificacion = 'Uso hospitalario'
WHERE nombre IN (
  'Anfotericina B', 'Doxorubicina', 'Vincristina', 'Carboplatino',
  'Ciclofosfamida', 'Lomustina', 'Masitinib', 'Toceranib',
  'Lidocaína', 'Naloxona', 'Flumazenil', 'Desoxicorticosterona'
);

-- Atropina antídoto (inyectable) es uso de emergencia; la gota oftálmica no.
UPDATE public.medicamentos
SET clasificacion = 'Uso hospitalario'
WHERE nombre = 'Atropina' AND presentacion = 'Inyectable';

UPDATE public.medicamentos
SET clasificacion = 'Suplemento'
WHERE familia_terapeutica = 'Vitaminas y Suplementos'
  AND nombre NOT IN ('Vitamina K1');

-- Vitamina K1 es antídoto de emergencia
UPDATE public.medicamentos
SET clasificacion = 'Uso hospitalario'
WHERE nombre = 'Vitamina K1';

-- ----------------------------------------------------------------------------
-- Laboratorios de referencia (marcas conocidas; el resto queda null)
-- ----------------------------------------------------------------------------
UPDATE public.medicamentos
SET laboratorio = v.laboratorio
FROM (VALUES
  ('Grapiprant', 'Elanco'),
  ('Robenacoxib', 'Elanco'),
  ('Deracoxib', 'Elanco'),
  ('Firocoxib', 'Boehringer Ingelheim'),
  ('Fluralaner', 'Merck'),
  ('Afoxolaner', 'Boehringer Ingelheim'),
  ('Sarolaner', 'Zoetis'),
  ('Lotilaner', 'Elanco'),
  ('Imidacloprid', 'Bayer'),
  ('Nitenpiram', 'Elanco'),
  ('Fipronil', 'Boehringer Ingelheim'),
  ('Selamectina', 'Zoetis'),
  ('Espinosad', 'Elanco'),
  ('Metimazol', 'Dechra'),
  ('Oclacitinib', 'Zoetis'),
  ('Lokivetmab', 'Zoetis'),
  ('Ciclosporina', 'Elanco'),
  ('Clomipramina', 'Elanco'),
  ('Fluoxetina', 'Elanco'),
  ('Selegilina', 'Zoetis'),
  ('Mitotano', 'Bayer'),
  ('Desoxicorticosterona', 'Dechra'),
  ('Miltefosina', 'Virbac'),
  ('Masitinib', 'Virbac'),
  ('Toceranib', 'Zoetis'),
  ('Maropitant', 'Zoetis'),
  ('Pimobendán', 'Boehringer Ingelheim'),
  ('Cefovecina', 'Zoetis'),
  ('Ceftiofur', 'Zoetis'),
  ('Carprofeno', 'Zoetis'),
  ('Meloxicam', 'Boehringer Ingelheim'),
  ('Flunixin', 'Merck'),
  ('Alfaxalona', 'Jurox'),
  ('Dexmedetomidina', 'Zoetis'),
  ('Medetomidina', 'Zoetis'),
  ('Trilostano', 'Dechra'),
  ('Benazepril', 'Elanco'),
  ('SAMe', 'Nutramax'),
  ('Ponazuril', 'Boehringer Ingelheim'),
  ('Amoxicilina + Clavulánico', 'Zoetis')
) AS v(nombre, laboratorio)
WHERE public.medicamentos.nombre = v.nombre;

-- ----------------------------------------------------------------------------
-- Indicaciones clínicas (ficha del medicamento)
-- ----------------------------------------------------------------------------
UPDATE public.medicamentos
SET indicaciones = v.indicaciones
FROM (VALUES
  ('Amoxicilina', 'Infecciones bacterianas sensibles: respiratorias, urinarias, cutáneas y gastrointestinales.'),
  ('Amoxicilina + Clavulánico', 'Infecciones bacterianas sensibles, incluidas cepas productoras de betalactamasas.'),
  ('Cefalexina', 'Infecciones cutáneas, urinarias y respiratorias por bacterias sensibles.'),
  ('Cefadroxila', 'Infecciones cutáneas, urinarias y respiratorias por bacterias sensibles.'),
  ('Cefovecina', 'Infecciones cutáneas superficiales y profundas (perros y gatos); acción prolongada de 14 días.'),
  ('Ceftiofur', 'Infecciones respiratorias y podales (uso mayor en bovinos/porcinos).'),
  ('Clindamicina', 'Infecciones cutáneas, dentales, óseas y de tejidos blandos; toxoplasmosis felina.'),
  ('Enrofloxacina', 'Infecciones bacterianas sensibles: respiratorias, urinarias, gastrointestinales y cutáneas.'),
  ('Marbofloxacina', 'Infecciones bacterianas sensibles: respiratorias, urinarias, cutáneas y de tejidos blandos.'),
  ('Orbifloxacina', 'Infecciones bacterianas sensibles en perros y gatos.'),
  ('Pradofloxacina', 'Infecciones cutáneas y respiratorias (perros y gatos).'),
  ('Doxiciclina', 'Infecciones respiratorias, enfermedades transmitidas por garrapatas (ehrlichiosis, anaplasmosis) y clamidiosis felina.'),
  ('Gentamicina', 'Infecciones gramnegativas graves; uso oftálmico, ótico y tópico frecuente.'),
  ('Amikacina', 'Infecciones gramnegativas graves; uso hospitalario con monitoreo renal.'),
  ('Azitromicina', 'Infecciones respiratorias, bartonelosis y clamidiosis felina.'),
  ('Cloranfenicol', 'Infecciones sensibles; uso cauteloso por posible toxicidad hematológica.'),
  ('Metronidazol', 'Giardiasis, colitis, infecciones anaerobias y hepatoencefalopatía.'),
  ('Tinidazol', 'Giardiasis y otras protozoosis intestinales.'),
  ('Ronidazol', 'Infección por Tritrichomonas foetus en gatos.'),
  ('Sulfametoxazol + Trimetoprima', 'Infecciones urinarias, respiratorias y gastrointestinales por bacterias sensibles.'),
  ('Sulfadimetoxina', 'Coccidiosis e infecciones bacterianas sensibles.'),
  ('Nitrofurantoína', 'Infecciones urinarias bajas no complicadas.'),
  ('Cefazolina', 'Profilaxis quirúrgica e infecciones por bacterias grampositivas sensibles.'),
  ('Cefpodoxima', 'Infecciones cutáneas, respiratorias y urinarias por bacterias sensibles.'),
  ('Ciprofloxacina', 'Infecciones sensibles; uso de reserva y con criterio veterinario.'),
  ('Ofloxacina', 'Infecciones bacterianas sensibles.'),
  ('Rifampicina', 'Infecciones micobacterianas y estafilocócicas, siempre en combinación.'),
  ('Tobramicina', 'Infecciones gramnegativas; uso oftálmico y ótico frecuente.'),
  ('Carprofeno', 'Dolor y osteoartritis en perros; analgesia postquirúrgica.'),
  ('Meloxicam', 'Dolor, osteoartritis y analgesia postquirúrgica en perros y gatos.'),
  ('Ketoprofeno', 'Dolor e inflamación en perros y gatos.'),
  ('Flunixin', 'Dolor visceral y cólico (equino); uso en perros con cautela.'),
  ('Robenacoxib', 'Dolor, osteoartritis y analgesia postquirúrgica.'),
  ('Deracoxib', 'Dolor, osteoartritis y analgesia postquirúrgica (perros).'),
  ('Firocoxib', 'Dolor y osteoartritis (perros).'),
  ('Grapiprant', 'Dolor por osteoartritis (perros); antiinflamatorio EP4 selectivo.'),
  ('Dipirona', 'Dolor y fiebre; uso veterinario variable según país.'),
  ('Tramadol', 'Dolor moderado a severo; analgesia perioperatoria y crónica.'),
  ('Buprenorfina', 'Dolor moderado a severo; analgesia perioperatoria.'),
  ('Morfina', 'Dolor severo; analgesia perioperatoria y posquirúrgica.'),
  ('Codeína', 'Dolor leve a moderado y antitusivo (perros).'),
  ('Fentanilo', 'Dolor severo; analgesia perioperatoria (parche o inyectable).'),
  ('Gabapentina', 'Dolor neuropático, ansiedad y convulsiones como adyuvante.'),
  ('Pregabalina', 'Dolor neuropático y convulsiones como adyuvante.'),
  ('Amitriptilina', 'Dolor crónico, ansiedad, cistitis idiopática felina y conducta.'),
  ('Paracetamol', 'Dolor y fiebre en PERROS; contraindicado y tóxico en gatos.'),
  ('Aspirina', 'Analgesia y antiinflamación (perros); precaución gastrointestinal.'),
  ('Acepromazina', 'Sedación, premedicación anestésica y viajes (cautela en boxers y animales agresivos).'),
  ('Alfaxalona', 'Inducción y mantenimiento de anestesia general.'),
  ('Dexmedetomidina', 'Sedación, analgesia y premedicación anestésica.'),
  ('Medetomidina', 'Sedación y premedicación anestésica.'),
  ('Xilazina 2%', 'Sedación, analgesia y relajante muscular (uso veterinario; revertir con yohimbina/atipamezol según caso).'),
  ('Ketamina', 'Inducción anestésica y analgesia disociativa.'),
  ('Propofol', 'Inducción y mantenimiento de anestesia general.'),
  ('Tiletamina + Zolazepam', 'Inducción anestésica e inmovilización.'),
  ('Midazolam', 'Sedación, premedicación anestésica y control de convulsiones.'),
  ('Diazepam', 'Sedación, convulsiones y relajación muscular.'),
  ('Bupivacaína', 'Bloqueos regionales y locales en clínica.'),
  ('Lidocaína', 'Anestesia local; vía IV para arritmias ventriculares (uso hospitalario).'),
  ('Famotidina', 'Gastritis, úlcera gástrica y reflujo (anti-H2).'),
  ('Ranitidina', 'Gastritis, úlcera y reflujo (anti-H2); verificar disponibilidad actual por retiros en algunos mercados.'),
  ('Omeprazol', 'Gastritis, úlcera gástrica y reflujo (inhibidor de bomba de protones).'),
  ('Pantoprazol', 'Gastritis y úlcera gástrica (inhibidor de bomba de protones).'),
  ('Rabeprazol', 'Gastritis y úlcera gástrica (inhibidor de bomba de protones).'),
  ('Cimetidina', 'Gastritis, úlcera y reflujo (anti-H2).'),
  ('Sucralfato', 'Úlcera gástrica y duodenal; gastroprotectante.'),
  ('Misoprostol', 'Prevención de úlceras por AINEs; contraindicado en gestación.'),
  ('Maropitant', 'Vómitos y náuseas; prevención de vómito por quimioterapia o motion sickness.'),
  ('Ondansetrón', 'Vómitos refractarios; antimético 5-HT3.'),
  ('Metoclopramida', 'Vómitos, reflujo gastroesofágico y como procinético.'),
  ('Domperidona', 'Vómitos y como procinético; galactorrea en pseudogestación.'),
  ('Cisaprida', 'Estreñimiento, reflujo y motilidad gastrointestinal baja.'),
  ('Loperamida', 'Diarrea no complicada (perros); precaución en gatos y collies (MDR1).'),
  ('Diphenhydramina', 'Alergia, prurito y reacciones histamínicas; sedación leve.'),
  ('Cetirizina', 'Alergia y prurito; antihistamínico de segunda generación.'),
  ('Loratadina', 'Alergia y prurito; antihistamínico de segunda generación.'),
  ('Hidroxizina', 'Alergia, prurito y ansiedad.'),
  ('Ciclosporina', 'Dermatitis atópica, queratitis sicca y enfermedades inmunomediadas.'),
  ('Lokivetmab', 'Dermatitis atópica y prurito (perros); anticuerpo anti-IL31.'),
  ('Oclacitinib', 'Dermatitis atópica y prurito (perros); inhibidor JAK.'),
  ('Prednisona', 'Inflamación, alergia y enfermedades inmunomediadas (prodrugo de prednisolona).'),
  ('Prednisolona', 'Inflamación, alergia y enfermedades inmunomediadas; corticoide activo en gatos.'),
  ('Dexametasona', 'Inflamación, alergia, shock y enfermedades inmunomediadas; potente.'),
  ('Metilprednisolona', 'Inflamación, alergia y enfermedades inmunomediadas.'),
  ('Triamcinolona', 'Inflamación, alergia y afecciones dermatológicas.'),
  ('Benazepril', 'Insuficiencia cardíaca, hipertensión y proteinuria renal.'),
  ('Enalapril', 'Insuficiencia cardíaca, hipertensión y proteinuria renal.'),
  ('Captopril', 'Insuficiencia cardíaca e hipertensión.'),
  ('Ramipril', 'Insuficiencia cardíaca, hipertensión y proteinuria renal.'),
  ('Pimobendán', 'Insuficiencia cardíaca por valvulopatía mitral y miocardiopatía dilatada; inodilatador.'),
  ('Digoxina', 'Insuficiencia cardíaca y arritmias auriculares; requiere monitoreo sérico.'),
  ('Diltiazem', 'Cardiomiopatía hipertrófica felina y arritmias; precaución con digoxina.'),
  ('Atenolol', 'Cardiomiopatía hipertrófica y arritmias; betabloqueante.'),
  ('Propranolol', 'Cardiomiopatía hipertrófica y arritmias; betabloqueante.'),
  ('Metoprolol', 'Cardiomiopatía hipertrófica y arritmias; betabloqueante.'),
  ('Carvedilol', 'Insuficiencia cardíaca y cardiomiopatía; betabloqueante/alfa bloqueante.'),
  ('Sotalol', 'Arritmias ventriculares y auriculares.'),
  ('Clopidogrel', 'Prevención de tromboembolismo arterial (especialmente gatos con MMVT).'),
  ('Amlodipino', 'Hipertensión arterial y proteinuria renal.'),
  ('Espironolactona', 'Insuficiencia cardíaca, ascitis e hiperaldosteronismo.'),
  ('Furosemida', 'Edema, insuficiencia cardíaca y renal; diurético de asa.'),
  ('Torsemida', 'Insuficiencia cardíaca (perros); diurético de asa de acción prolongada.'),
  ('Hidroclorotiazida', 'Hipertensión y edema; diurético tiazídico.'),
  ('Sildenafilo', 'Hipertensión pulmonar (perros); inhibidor PDE5.'),
  ('Tadalafilo', 'Hipertensión pulmonar (perros); inhibidor PDE5.'),
  ('Losartán', 'Hipertensión y proteinuria renal; ARA II.'),
  ('Telmisartán', 'Hipertensión y proteinuria renal; ARA II.'),
  ('Hidralazina', 'Hipertensión; vasodilatador de acción rápida.'),
  ('Fenobarbital', 'Epilepsia y convulsiones en perros y gatos; controlado.'),
  ('Levetiracetam', 'Epilepsia y convulsiones; buen margen de seguridad.'),
  ('Bromuro de potasio', 'Epilepsia refractaria (perros); requiere monitoreo sérico.'),
  ('Levotiroxina', 'Hipotiroidismo (perros).'),
  ('Metimazol', 'Hipertiroidismo (gatos).'),
  ('Trilostano', 'Hiperadrenocorticismo (Cushing) en perros.'),
  ('Mitotano', 'Hiperadrenocorticismo (Cushing) en perros; inducción y mantenimiento.'),
  ('Desoxicorticosterona', 'Hipoadrenocorticismo (Addison) en perros; inyectable de acción prolongada.'),
  ('Fludrocortisona', 'Hipoadrenocorticismo (Addison) en perros; mineralocorticoide oral.'),
  ('Cabergolina', 'Pseudogestación e hiperprolactinemia en perros.'),
  ('Ivermectina', 'Dirofilariosis, parásitos internos y externos; precaución en collies (MDR1).'),
  ('Milbemicina Oxima', 'Prevención de dirofilariosis y parásitos intestinales.'),
  ('Moxidectina', 'Dirofilariosis y parásitos intestinales/externos.'),
  ('Selamectina', 'Pulgas, ácaros, otodectes y prevención de dirofilariosis.'),
  ('Espinosad', 'Pulgas (perros); acción rápida y prolongada.'),
  ('Fluralaner', 'Pulgas y garrapatas (perros); acción de 12 semanas.'),
  ('Afoxolaner', 'Pulgas y garrapatas (perros); acción mensual.'),
  ('Sarolaner', 'Pulgas y garrapatas (perros); acción mensual.'),
  ('Lotilaner', 'Pulgas y garrapatas (perros); acción mensual.'),
  ('Imidacloprid', 'Pulgas (perros y gatos); acción mensual.'),
  ('Nitenpiram', 'Pulgas (perros y gatos); acción rápida en 24-48 h.'),
  ('Fipronil', 'Pulgas, garrapatas y ácaros (perros y gatos).'),
  ('Permetrina', 'Garrapatas y pulgas en PERROS; tóxica en gatos (piretroide).'),
  ('Amitraz', 'Sarna demodécica y sarcóptica, garrapatas (perros); tóxico en gatos.'),
  ('Pirantel Pamoato', 'Nemátodos intestinales (lombrices, anquilostomas).'),
  ('Febantel', 'Nemátodos intestinales (perros).'),
  ('Fenbendazol', 'Nemátodos intestinales y giardiasis; desparasitante de amplio espectro.'),
  ('Oxfendazol', 'Nemátodos intestinales.'),
  ('Oxibendazol', 'Nemátodos intestinales.'),
  ('Mebendazol', 'Nemátodos intestinales.'),
  ('Praziquantel', 'Cestodos (tenias) y esquistosomas.'),
  ('Epsiprantel', 'Cestodos (tenias).'),
  ('Diethylcarbamaza', 'Prevención de filariasis.'),
  ('Miltefosina', 'Leishmaniosis visceral (perros); curso de 28 días.'),
  ('Ponazuril', 'EPM (equinos) y coccidiosis.'),
  ('Toltrazuril', 'Coccidiosis.'),
  ('Alopurinol', 'Leishmaniosis (perros) y urolitiasis por uratos.'),
  ('Amantadina', 'Dolor crónico como adyuvante; uso antiviral limitado.'),
  ('Itraconazol', 'Dermatofitosis, blastomicosis y criptococosis.'),
  ('Fluconazol', 'Criptococosis, candidiasis y dermatofitosis; buena penetración SNC.'),
  ('Ketoconazol', 'Dermatofitosis, blastomicosis y como inhibitorio de cortisol (cautela hepática).'),
  ('Terbinafina', 'Dermatofitosis (tiñas).'),
  ('Griseofulvina', 'Dermatofitosis (gatos); uso cauteloso (efectos hematológicos).'),
  ('Voriconazol', 'Aspergilosis y micosis sistémicas.'),
  ('Anfotericina B', 'Micosis sistémicas graves; uso hospitalario con monitoreo renal.'),
  ('Miconazol', 'Dermatofitosis, otitis por hongos y candidiasis (tópico).'),
  ('Clotrimazol', 'Dermatofitosis y micosis superficiales (tópico).'),
  ('Timolol', 'Glaucoma; betabloqueante oftálmico.'),
  ('Dorzolamida', 'Glaucoma; inhibidor de anhidrasa carbónica oftálmico.'),
  ('Latanoprost', 'Glaucoma; prostaglandina oftálmica.'),
  ('Atropina', 'Uveítis, midriasis diagnóstica y cicloplejia (gotas); antídoto de organofosforados (inyectable).'),
  ('Tropicamida', 'Midriasis de acción corta para exploración ocular.'),
  ('Diclofenaco', 'Inflamación y dolor ocular (tópico).'),
  ('Salbutamol', 'Broncoespasmo y asma felina; broncodilatador.'),
  ('Terbutalina', 'Broncoespasmo; broncodilatador beta2.'),
  ('Teofilina', 'Broncoespasmo y asma; metilxantina.'),
  ('Fluoxetina', 'Ansiedad, agresión y trastornos compulsivos en perros y gatos.'),
  ('Clomipramina', 'Ansiedad, agresión y trastornos compulsivos.'),
  ('Selegilina', 'Disfunción cognitiva senil (perros) e hiperadrenocorticismo (Cushing).'),
  ('Trazodona', 'Ansiedad situacional y fobias (perros).'),
  ('Alprazolam', 'Ansiedad, fobias y pánico (perros y gatos).'),
  ('Fenoxibenzamina', 'Obstrucción uretral por hipertonía del esfínter y feocromocitoma.'),
  ('Prazosina', 'Obstrucción uretral, hipertensión e hiperplasia prostática.'),
  ('Tamsulosina', 'Obstrucción uretral e hiperplasia prostática benigna.'),
  ('Finasterida', 'Hiperplasia prostática benigna (perros).'),
  ('Fenilpropanolamina', 'Incontinencia urinaria por insuficiencia de esfínter urinario.'),
  ('Doxorubicina', 'Neoplasias: linfomas, carcinomas, hemangiosarcoma (uso hospitalario).'),
  ('Ciclofosfamida', 'Linfomas, tumores mastocitarios y enfermedades inmunomediadas (uso hospitalario).'),
  ('Vincristina', 'Linfomas y tumores mastocitarios (uso hospitalario).'),
  ('Carboplatino', 'Neoplasias: carcinomas, osteosarcoma, tumores de vejiga (uso hospitalario).'),
  ('Masitinib', 'Mastocitoma no resecable/metastásico (perros).'),
  ('Toceranib', 'Mastocitoma cutáneo (perros); inhibidor tirosina quinasa.'),
  ('Lomustina', 'Linfomas y tumores cerebrales (uso hospitalario).'),
  ('Vitamina K1', 'Antídoto de rodenticidas anticoagulantes y deficiencia de vitamina K.'),
  ('Vitamina B12', 'Deficiencia de cobalamina; apoyo en enfermedad gastrointestinal y pancreática.'),
  ('Taurina', 'Apoyo cardíaco (miocardiopatía dilatada) y retinopatía felina.'),
  ('Glucosamina', 'Apoyo en osteoartritis y salud articular.'),
  ('Condroitina', 'Apoyo en osteoartritis y salud articular.'),
  ('Silymarina', 'Hepatoprotección en hepatopatías y toxicidades.'),
  ('Coenzima Q10', 'Apoyo cardíaco y antioxidante.'),
  ('L-Carnitina', 'Apoyo en miocardiopatía dilatada (perros).'),
  ('Omega-3', 'Apoyo cardíaco, renal, dermatológico y osteoartritis.'),
  ('Vitamina E + Selenio', 'Antioxidante; miositis y deficiencias.'),
  ('Calcio Inyectable', 'Hipocalcemia y eclampsia puerperal.'),
  ('Naloxona', 'Sobredosis de opioides; antagonista opioide de emergencia.'),
  ('Flumazenil', 'Sobredosis de benzodiazepinas; antagonista de emergencia.'),
  ('Acetilcisteína', 'Antídoto de sobredosis de paracetamol; mucolítico.'),
  ('Carbón activado', 'Adsorber tóxicos ingeridos recientemente.'),
  ('Desmopresina', 'Diabetes insípida central y sangrado por enfermedad de von Willebrand.'),
  ('Oclacitinib', 'Dermatitis atópica y prurito (perros).'),
  ('Ronidazol', 'Tritrichomonas foetus en gatos.'),
  ('Mebendazol', 'Nemátodos intestinales.'),
  ('Ciclosporina', 'Dermatitis atópica, queratitis sicca y enfermedades inmunomediadas.'),
  ('Amitriptilina', 'Dolor crónico, ansiedad y cistitis idiopática felina.'),
  ('Cisaprida', 'Estreñimiento y reflujo por motilidad gastrointestinal baja.'),
  ('Loperamida', 'Diarrea no complicada (perros); precaución en collies (MDR1).'),
  ('Diphenhydramina', 'Alergia, prurito y reacciones histamínicas.'),
  ('Fenilpropanolamina', 'Incontinencia urinaria por insuficiencia de esfínter urinario.')
) AS v(nombre, indicaciones)
WHERE public.medicamentos.nombre = v.nombre;

-- Conservación general por vía (valor genérico; ajustar por prospecto real)
UPDATE public.medicamentos
SET conservacion = 'Conservar en lugar fresco y seco, protegido de la luz.'
WHERE presentacion ILIKE '%Inyectable%'
   OR presentacion ILIKE '%Gotas%';

UPDATE public.medicamentos
SET conservacion = 'Conservar en lugar fresco y seco, a temperatura ambiente.'
WHERE conservacion IS NULL;
