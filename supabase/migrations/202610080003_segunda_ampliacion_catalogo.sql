-- ============================================================================
-- SEGUNDA AMPLIACIÓN DEL CATÁLOGO DE MEDICAMENTOS VETERINARIOS
-- Perros y gatos — nuevas familias y fármacos de uso clínico habitual
-- ============================================================================
-- Criterio de fuentes: prospecto oficial (DailyMed / NOAH / VMD / EMA) o
-- consenso de referencia clínica (Merck Veterinary Manual / Plumb's / WSAVA).
-- Verificar registro SAG (Chile) o SENASA (Argentina) antes del uso local.
--
-- Corrección: se elimina el duplicado "Pimobendan" (sin tilde) del seed y se
-- conserva "Pimobendán" con el rango estándar 0.25-0.5 mg/kg.
-- ============================================================================

-- Corrección de duplicado (mismo fármaco, distinta ortografía/presentación)
DELETE FROM public.medicamentos WHERE nombre = 'Pimobendan';

-- ----------------------------------------------------------------------------
-- ANALGÉSICOS / ANTIINFLAMATORIOS (NSAIDs modernos y adyuvantes)
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Robenacoxib', 'Robenacoxib', 'Analgésicos / Antiinflamatorios', 'Comprimidos', '10 mg',
   '1-2 mg/kg PO cada 24h (perros; Onsior)', 1, 2,
   'Oral', 24, 'DailyMed'),
  ('Deracoxib', 'Deracoxib', 'Analgésicos / Antiinflamatorios', 'Comprimidos masticables', '25 mg',
   '1-2 mg/kg PO cada 24h (perros; Deramaxx)', 1, 2,
   'Oral', 24, 'DailyMed'),
  ('Firocoxib', 'Firocoxib', 'Analgésicos / Antiinflamatorios', 'Comprimidos masticables', '57 mg',
   '5 mg/kg PO cada 24h (perros; Previcox)', 5, 5,
   'Oral', 24, 'DailyMed'),
  ('Grapiprant', 'Grapiprant', 'Analgésicos / Antiinflamatorios', 'Comprimidos', '20 mg',
   '2 mg/kg PO cada 24h (perros; Galliprant)', 2, 2,
   'Oral', 24, 'DailyMed'),
  ('Gabapentina', 'Gabapentina', 'Analgésicos / Antiinflamatorios', 'Cápsulas', '100 mg',
   '10-20 mg/kg PO cada 8-12h (perros y gatos; dolor neuropático)', 10, 20,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Pregabalina', 'Pregabalina', 'Analgésicos / Antiinflamatorios', 'Cápsulas', '75 mg',
   '4-6 mg/kg PO cada 8-12h (perros y gatos; dolor neuropático)', 4, 6,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Amitriptilina', 'Amitriptilina', 'Analgésicos / Antiinflamatorios', 'Comprimidos', '25 mg',
   '1-2 mg/kg PO cada 24h (perros y gatos; dolor crónico/conducta)', 1, 2,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Paracetamol', 'Paracetamol', 'Analgésicos / Antiinflamatorios', 'Comprimidos', '500 mg',
   '10-15 mg/kg PO cada 8-12h (SOLO PERROS; tóxico en gatos)', 10, 15,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Aspirina', 'Aspirina', 'Analgésicos / Antiinflamatorios', 'Comprimidos', '100 mg',
   '10-25 mg/kg PO cada 12h (perros; con alimento, precaución GI)', 10, 25,
   'Oral', 12, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTIBIÓTICOS / ANTIMICROBIANOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Cefazolina', 'Cefazolina', 'Antibióticos / Antimicrobianos', 'Inyectable', '500 mg/ml',
   '20-40 mg/kg IV/IM/SC cada 8h (perros y gatos; profilaxis quirúrgica)', 20, 40,
   'Intravenosa/Intramuscular/Subcutánea', 8, 'Merck Veterinary Manual'),
  ('Cefpodoxima', 'Cefpodoxima', 'Antibióticos / Antimicrobianos', 'Comprimidos', '100 mg',
   '5-10 mg/kg PO cada 24h (perros y gatos)', 5, 10,
   'Oral', 24, 'DailyMed'),
  ('Ciprofloxacina', 'Ciprofloxacina', 'Antibióticos / Antimicrobianos', 'Comprimidos', '250 mg',
   '10-20 mg/kg PO cada 12h (perros; gatos 10-15 mg/kg)', 10, 20,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Ofloxacina', 'Ofloxacina', 'Antibióticos / Antimicrobianos', 'Comprimidos', '200 mg',
   '5-10 mg/kg PO cada 24h (perros y gatos)', 5, 10,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Rifampicina', 'Rifampicina', 'Antibióticos / Antimicrobianos', 'Cápsulas', '150 mg',
   '10-20 mg/kg PO cada 24h (perros y gatos; combinada, micobacterias)', 10, 20,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Tobramicina', 'Tobramicina', 'Antibióticos / Antimicrobianos', 'Inyectable', '40 mg/ml',
   '5-10 mg/kg IV/IM/SC cada 24h (perros); oftálmica tópica', 5, 10,
   'Intravenosa/Intramuscular/Subcutánea', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTIPARASITARIOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Febantel', 'Febantel', 'Antiparasitarios', 'Comprimidos', '150 mg',
   '10-20 mg/kg PO cada 24h (perros; antihelmíntico)', 10, 20,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Oxfendazol', 'Oxfendazol', 'Antiparasitarios', 'Suspensión oral', '100 mg/ml',
   '10-50 mg/kg PO cada 24h (perros y gatos; antihelmíntico)', 10, 50,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Oxibendazol', 'Oxibendazol', 'Antiparasitarios', 'Comprimidos', '225 mg',
   '10-15 mg/kg PO cada 24h (perros; antihelmíntico)', 10, 15,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Mebendazol', 'Mebendazol', 'Antiparasitarios', 'Comprimidos', '100 mg',
   '10-20 mg/kg PO cada 24h (perros y gatos; antihelmíntico)', 10, 20,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Imidacloprid', 'Imidacloprid', 'Antiparasitarios', 'Spot-on', '100 mg/ml',
   '10 mg/kg tópico cada 30 días (perros y gatos; Advantage, antipulgas)', 10, 10,
   'Tópica', 720, 'DailyMed'),
  ('Nitenpiram', 'Nitenpiram', 'Antiparasitarios', 'Comprimidos', '11 mg',
   '1 mg/kg PO (perros y gatos; Capstar, antipulgas rápido)', 1, 1,
   'Oral', 24, 'DailyMed'),
  ('Fluralaner', 'Fluralaner', 'Antiparasitarios', 'Comprimidos masticables', '500 mg',
   '25-56 mg/kg PO cada 12 semanas (perros; Bravecto)', 25, 56,
   'Oral', 2016, 'DailyMed'),
  ('Afoxolaner', 'Afoxolaner', 'Antiparasitarios', 'Comprimidos masticables', '100 mg',
   '2.5 mg/kg PO cada 30 días (perros; NexGard)', 2.5, 2.5,
   'Oral', 720, 'DailyMed'),
  ('Sarolaner', 'Sarolaner', 'Antiparasitarios', 'Comprimidos masticables', '80 mg',
   '2-4 mg/kg PO cada 30 días (perros; Simparica)', 2, 4,
   'Oral', 720, 'DailyMed'),
  ('Lotilaner', 'Lotilaner', 'Antiparasitarios', 'Comprimidos masticables', '100 mg',
   '20-43 mg/kg PO cada 30 días (perros; Credelio)', 20, 43,
   'Oral', 720, 'DailyMed'),
  ('Amitraz', 'Amitraz', 'Antiparasitarios', 'Baño/Spot-on', '125 mg/ml',
   'Baños 0.025% semanales (perros; sarna demodécica/sarcóptica)', 0.025, 0.025,
   'Tópica', 168, 'Merck Veterinary Manual'),
  ('Permetrina', 'Permetrina', 'Antiparasitarios', 'Spray/Collar', '500 mg/ml',
   '0.5-2% tópico (SOLO PERROS; tóxica en gatos, piretroide)', 0.5, 2,
   'Tópica', 168, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTIPROTOZOARIOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Miltefosina', 'Miltefosina', 'Antiparasitarios', 'Solución oral', '20 mg/ml',
   '2 mg/kg PO cada 24h x 28 días (perros; leishmaniosis, Milteforan)', 2, 2,
   'Oral', 24, 'Ficha técnica AEMPS/Virbac'),
  ('Ronidazol', 'Ronidazol', 'Antiparasitarios', 'Comprimidos', '200 mg',
   '30 mg/kg PO cada 24h (gatos; Tritrichomonas foetus)', 30, 30,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Toltrazuril', 'Toltrazuril', 'Antiparasitarios', 'Suspensión oral', '50 mg/ml',
   '10-20 mg/kg PO (perros y gatos; coccidias)', 10, 20,
   'Oral', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- GASTROINTESTINALES
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Cimetidina', 'Cimetidina', 'Gastrointestinales', 'Comprimidos', '200 mg',
   '5-10 mg/kg PO/IV cada 8-12h (perros y gatos; antihistamínico H2)', 5, 10,
   'Oral/Intravenosa', 8, 'Merck Veterinary Manual'),
  ('Pantoprazol', 'Pantoprazol', 'Gastrointestinales', 'Comprimidos', '40 mg',
   '1 mg/kg PO/IV cada 24h (perros y gatos; IBP)', 1, 1,
   'Oral/Intravenosa', 24, 'Merck Veterinary Manual'),
  ('Rabeprazol', 'Rabeprazol', 'Gastrointestinales', 'Comprimidos', '20 mg',
   '1 mg/kg PO cada 24h (perros y gatos; IBP)', 1, 1,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Misoprostol', 'Misoprostol', 'Gastrointestinales', 'Comprimidos', '200 µg',
   '2-4 µg/kg PO cada 8-12h (perros y gatos; protección GI con AINE)', 0.002, 0.004,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Domperidona', 'Domperidona', 'Gastrointestinales', 'Comprimidos', '10 mg',
   '0.5-1 mg/kg PO/IV cada 12h (perros y gatos; antiemético/procinético)', 0.5, 1,
   'Oral/Intravenosa', 12, 'Merck Veterinary Manual'),
  ('Cisaprida', 'Cisaprida', 'Gastrointestinales', 'Comprimidos', '5 mg',
   '0.1-0.5 mg/kg PO cada 8-12h (perros y gatos; procinético)', 0.1, 0.5,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Ursodiol', 'Ursodiol', 'Gastrointestinales', 'Cápsulas', '100 mg',
   '10-15 mg/kg PO cada 12h (perros y gatos; colagogos/hepatoprotector)', 10, 15,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('SAMe', 'S-adenosilmetionina', 'Gastrointestinales', 'Comprimidos', '200 mg',
   '20 mg/kg PO cada 24h (perros y gatos; hepatoprotector, Denosyl)', 20, 20,
   'Oral', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- CARDIOVASCULARES
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Sildenafilo', 'Sildenafilo', 'Cardiovasculares', 'Comprimidos', '50 mg',
   '1-3 mg/kg PO cada 8-12h (perros; hipertensión pulmonar)', 1, 3,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Tadalafilo', 'Tadalafilo', 'Cardiovasculares', 'Comprimidos', '20 mg',
   '1-2 mg/kg PO cada 24h (perros; hipertensión pulmonar)', 1, 2,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Torsemida', 'Torsemida', 'Cardiovasculares', 'Comprimidos', '10 mg',
   '0.2-0.4 mg/kg PO cada 24h (perros; diurético de asa)', 0.2, 0.4,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Hidroclorotiazida', 'Hidroclorotiazida', 'Cardiovasculares', 'Comprimidos', '25 mg',
   '2-4 mg/kg PO cada 12-24h (perros; diurético tiazídico)', 2, 4,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Propranolol', 'Propranolol', 'Cardiovasculares', 'Comprimidos', '10 mg',
   '0.2-0.5 mg/kg PO cada 8h (perros y gatos; betabloqueante)', 0.2, 0.5,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Metoprolol', 'Metoprolol', 'Cardiovasculares', 'Comprimidos', '50 mg',
   '0.2-0.5 mg/kg PO cada 12h (perros y gatos; betabloqueante)', 0.2, 0.5,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Carvedilol', 'Carvedilol', 'Cardiovasculares', 'Comprimidos', '25 mg',
   '0.2-0.5 mg/kg PO cada 12h (perros; betabloqueante/alfa bloqueante)', 0.2, 0.5,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Sotalol', 'Sotalol', 'Cardiovasculares', 'Comprimidos', '80 mg',
   '1-2 mg/kg PO cada 12h (perros y gatos; antiarrítmico)', 1, 2,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Lidocaína', 'Lidocaína', 'Cardiovasculares', 'Inyectable', '20 mg/ml',
   '2-4 mg/kg IV bolo (perros; arritmias ventriculares)', 2, 4,
   'Intravenosa', 1, 'Merck Veterinary Manual'),
  ('Losartán', 'Losartán', 'Cardiovasculares', 'Comprimidos', '50 mg',
   '0.5-1 mg/kg PO cada 24h (perros y gatos; ARA II)', 0.5, 1,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Telmisartán', 'Telmisartán', 'Cardiovasculares', 'Comprimidos', '40 mg',
   '1-2 mg/kg PO cada 24h (perros y gatos; ARA II)', 1, 2,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Ramipril', 'Ramipril', 'Cardiovasculares', 'Cápsulas', '2.5 mg',
   '0.125-0.25 mg/kg PO cada 24h (perros y gatos; IECA)', 0.125, 0.25,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Hidralazina', 'Hidralazina', 'Cardiovasculares', 'Inyectable', '20 mg/ml',
   '0.5-1 mg/kg IV/PO (perros; vasodilatador)', 0.5, 1,
   'Intravenosa/Oral', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ENDOCRINOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Prednisolona', 'Prednisolona', 'Endocrinos', 'Comprimidos', '20 mg',
   '0.5-2 mg/kg PO cada 24h (perros y gatos; corticoide activo)', 0.5, 2,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Fludrocortisona', 'Fludrocortisona', 'Endocrinos', 'Comprimidos', '0.1 mg',
   '0.01-0.02 mg/kg PO cada 24h (perros; Addison, mineralocorticoide)', 0.01, 0.02,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Desoxicorticosterona', 'Desoxicorticosterona', 'Endocrinos', 'Inyectable', '25 mg/ml',
   '2.2 mg/kg IM cada 25 días (perros; Addison, DOCP/Zycortal)', 2.2, 2.2,
   'Intramuscular', 600, 'DailyMed'),
  ('Mitotano', 'Mitotano', 'Endocrinos', 'Comprimidos', '500 mg',
   '50-75 mg/kg PO (inducción, perros; hiperadrenocorticismo, Lysodren)', 50, 75,
   'Oral', 24, 'DailyMed'),
  ('Metimazol', 'Metimazol', 'Endocrinos', 'Comprimidos', '5 mg',
   '2.5-5 mg/kg PO cada 12h (gatos; hipertiroidismo, Felimazole)', 2.5, 5,
   'Oral', 12, 'DailyMed'),
  ('Cabergolina', 'Cabergolina', 'Endocrinos', 'Comprimidos', '1 mg',
   '5 µg/kg PO cada 24h (perros; pseudogestación)', 0.005, 0.005,
   'Oral', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTIFÚNGICOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Voriconazol', 'Voriconazol', 'Antifúngicos', 'Comprimidos', '50 mg',
   '5-10 mg/kg PO cada 12h (perros y gatos; aspergilosis)', 5, 10,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Anfotericina B', 'Anfotericina B', 'Antifúngicos', 'Inyectable', '50 mg/vial',
   '0.15-0.5 mg/kg IV (perros y gatos; micosis sistémicas, uso hospitalario)', 0.15, 0.5,
   'Intravenosa', 24, 'Merck Veterinary Manual'),
  ('Miconazol', 'Miconazol', 'Antifúngicos', 'Crema/Champú', '20 mg/g',
   'Tópico 2% cada 24h (perros y gatos; dermatofitosis/otitis)', 20, 20,
   'Tópica', 24, 'Merck Veterinary Manual'),
  ('Clotrimazol', 'Clotrimazol', 'Antifúngicos', 'Crema', '10 mg/g',
   'Tópico 1% cada 12h (perros y gatos; dermatofitosis)', 10, 10,
   'Tópica', 12, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTICONVULSIVANTES
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Fenobarbital', 'Fenobarbital', 'Anticonvulsivantes', 'Comprimidos', '100 mg',
   '2-5 mg/kg PO cada 12h (perros y gatos; epilepsia)', 2, 5,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Levetiracetam', 'Levetiracetam', 'Anticonvulsivantes', 'Comprimidos', '250 mg',
   '20-60 mg/kg PO cada 8h (perros y gatos; epilepsia)', 20, 60,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Bromuro de potasio', 'Bromuro de potasio', 'Anticonvulsivantes', 'Cápsulas', '500 mg',
   '20-40 mg/kg PO cada 24h (perros; epilepsia refractaria)', 20, 40,
   'Oral', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- RESPIRATORIOS / BRONCODILATADORES
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Salbutamol', 'Salbutamol', 'Respiratorios / Broncodilatadores', 'Inhalador/Jarabe', '2 mg/5 ml',
   '0.1-0.2 mg/kg PO/inalado cada 8h (perros y gatos; broncoespasmo)', 0.1, 0.2,
   'Oral/Inhalada', 8, 'Merck Veterinary Manual'),
  ('Terbutalina', 'Terbutalina', 'Respiratorios / Broncodilatadores', 'Inyectable', '0.5 mg/ml',
   '0.05-0.1 mg/kg SC/PO cada 8h (perros y gatos; broncoespasmo)', 0.05, 0.1,
   'Subcutánea/Oral', 8, 'Merck Veterinary Manual'),
  ('Teofilina', 'Teofilina', 'Respiratorios / Broncodilatadores', 'Comprimidos', '100 mg',
   '5-10 mg/kg PO cada 8-12h (perros; broncodilatador metilxantina)', 5, 10,
   'Oral', 8, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- OFTÁLMICOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Atropina', 'Atropina', 'Oftálmicos', 'Gotas oftálmicas', '10 mg/ml',
   '1-2 gotas tópico cada 8-24h (perros y gatos; midriático/ciclopléjico)', 0.1, 0.2,
   'Tópica ocular', 8, 'Merck Veterinary Manual'),
  ('Tropicamida', 'Tropicamida', 'Oftálmicos', 'Gotas oftálmicas', '5 mg/ml',
   '1-2 gotas tópico cada 8h (perros y gatos; midriático de acción corta)', 0.05, 0.1,
   'Tópica ocular', 8, 'Merck Veterinary Manual'),
  ('Latanoprost', 'Latanoprost', 'Oftálmicos', 'Gotas oftálmicas', '50 µg/ml',
   '1 gota tópico cada 24h (perros y gatos; glaucoma, hipotensor)', 0.005, 0.005,
   'Tópica ocular', 24, 'Merck Veterinary Manual'),
  ('Timolol', 'Timolol', 'Oftálmicos', 'Gotas oftálmicas', '5 mg/ml',
   '1 gota tópico cada 12h (perros y gatos; glaucoma, betabloqueante)', 0.05, 0.05,
   'Tópica ocular', 12, 'Merck Veterinary Manual'),
  ('Dorzolamida', 'Dorzolamida', 'Oftálmicos', 'Gotas oftálmicas', '20 mg/ml',
   '1 gota tópico cada 8-12h (perros y gatos; glaucoma, inhibidor CA)', 0.2, 0.2,
   'Tópica ocular', 8, 'Merck Veterinary Manual'),
  ('Diclofenaco', 'Diclofenaco', 'Oftálmicos', 'Gotas oftálmicas', '1 mg/ml',
   '1 gota tópico cada 8-12h (perros y gatos; antiinflamatorio ocular)', 0.1, 0.1,
   'Tópica ocular', 8, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTIVIRALES
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Famciclovir', 'Famciclovir', 'Antivirales', 'Comprimidos', '250 mg',
   '40-90 mg/kg PO cada 8-12h (gatos; herpesvirus felino FHV-1)', 40, 90,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Aciclovir', 'Aciclovir', 'Antivirales', 'Comprimidos', '200 mg',
   '10-20 mg/kg PO cada 8h (perros; evitar IV en gatos por toxicidad)', 10, 20,
   'Oral', 8, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- CONDUCTA / PSICOTRÓPICOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Fluoxetina', 'Fluoxetina', 'Conducta / Psicotrópicos', 'Cápsulas', '20 mg',
   '1-2 mg/kg PO cada 24h (perros y gatos; ansiedad/agresión, Reconcile)', 1, 2,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Clomipramina', 'Clomipramina', 'Conducta / Psicotrópicos', 'Comprimidos', '25 mg',
   '1-2 mg/kg PO cada 24h (perros y gatos; ansiedad, Clomicalm)', 1, 2,
   'Oral', 24, 'DailyMed'),
  ('Selegilina', 'Selegilina', 'Conducta / Psicotrópicos', 'Comprimidos', '5 mg',
   '0.5-1 mg/kg PO cada 24h (perros; disfunción cognitiva, Anipryl)', 0.5, 1,
   'Oral', 24, 'DailyMed'),
  ('Trazodona', 'Trazodona', 'Conducta / Psicotrópicos', 'Comprimidos', '50 mg',
   '5-10 mg/kg PO cada 8-12h (perros; ansiedad situacional)', 5, 10,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Alprazolam', 'Alprazolam', 'Conducta / Psicotrópicos', 'Comprimidos', '0.5 mg',
   '0.02-0.1 mg/kg PO cada 8-12h (perros y gatos; ansiedad/fobias)', 0.02, 0.1,
   'Oral', 8, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- UROLÓGICOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Fenoxibenzamina', 'Fenoxibenzamina', 'Urológicos', 'Cápsulas', '10 mg',
   '0.5-1 mg/kg PO cada 12h (perros; obstrucción uretral, alfa bloqueante)', 0.5, 1,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Prazosina', 'Prazosina', 'Urológicos', 'Cápsulas', '1 mg',
   '0.5-1 mg/kg PO cada 8-12h (perros y gatos; alfa bloqueante)', 0.5, 1,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Tamsulosina', 'Tamsulosina', 'Urológicos', 'Cápsulas', '0.4 mg',
   '0.1-0.2 mg/kg PO cada 24h (perros; relajante uretral)', 0.1, 0.2,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Finasterida', 'Finasterida', 'Urológicos', 'Comprimidos', '5 mg',
   '1-5 mg/kg PO cada 24h (perros; hiperplasia prostática benigna)', 1, 5,
   'Oral', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTINEOPLÁSICOS / QUIMIOTERAPIA
-- (dosis por peso aproximada; la clínica suele calcular por m² de superficie)
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Doxorubicina', 'Doxorubicina', 'Antineoplásicos / Quimioterapia', 'Inyectable', '10 mg/ml',
   '1 mg/kg IV cada 21 días (perros; uso oncológico hospitalario)', 1, 1,
   'Intravenosa', 504, 'Merck Veterinary Manual'),
  ('Ciclofosfamida', 'Ciclofosfamida', 'Antineoplásicos / Quimioterapia', 'Comprimidos', '50 mg',
   '2-3 mg/kg PO (perros; uso oncológico, con precaución vesical)', 2, 3,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Vincristina', 'Vincristina', 'Antineoplásicos / Quimioterapia', 'Inyectable', '1 mg/ml',
   '0.025-0.07 mg/kg IV semanal (perros; uso oncológico hospitalario)', 0.025, 0.07,
   'Intravenosa', 168, 'Merck Veterinary Manual'),
  ('Carboplatino', 'Carboplatino', 'Antineoplásicos / Quimioterapia', 'Inyectable', '10 mg/ml',
   '10 mg/kg IV cada 21 días (perros y gatos; uso oncológico hospitalario)', 10, 10,
   'Intravenosa', 504, 'Merck Veterinary Manual'),
  ('Masitinib', 'Masitinib', 'Antineoplásicos / Quimioterapia', 'Comprimidos', '100 mg',
   '12.5 mg/kg PO cada 24h (perros; mastocitoma, Masivet)', 12.5, 12.5,
   'Oral', 24, 'DailyMed'),
  ('Toceranib', 'Toceranib', 'Antineoplásicos / Quimioterapia', 'Comprimidos', '10 mg',
   '3.25 mg/kg PO (lunes/miércoles/viernes; perros; Palladia)', 3.25, 3.25,
   'Oral', 24, 'DailyMed'),
  ('Lomustina', 'Lomustina', 'Antineoplásicos / Quimioterapia', 'Cápsulas', '10 mg',
   '2.5-3.3 mg/kg PO cada 21 días (perros; uso oncológico hospitalario)', 2.5, 3.3,
   'Oral', 504, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- VITAMINAS Y SUPLEMENTOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Vitamina K1', 'Fitonadiona', 'Vitaminas y Suplementos', 'Inyectable', '10 mg/ml',
   '1-5 mg/kg SC/IM/PO (antídoto rodenticidas anticoagulantes)', 1, 5,
   'Subcutánea/Intramuscular/Oral', 24, 'Merck Veterinary Manual'),
  ('Vitamina B12', 'Cobalamina', 'Vitaminas y Suplementos', 'Inyectable', '1000 µg/ml',
   '250-1000 µg/día (25-100 µg/kg en 10 kg; suplemento, cianocobalamina)', 0.025, 0.1,
   'Intramuscular/Oral', 24, 'Merck Veterinary Manual'),
  ('Taurina', 'Taurina', 'Vitaminas y Suplementos', 'Cápsulas', '500 mg',
   '25-50 mg/kg PO cada 24h (gatos; 250-500 mg/día)', 25, 50,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Glucosamina', 'Glucosamina', 'Vitaminas y Suplementos', 'Comprimidos', '500 mg',
   '20-50 mg/kg PO cada 24h (perros; salud articular)', 20, 50,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Condroitina', 'Condroitina', 'Vitaminas y Suplementos', 'Comprimidos', '400 mg',
   '10-25 mg/kg PO cada 24h (perros; salud articular)', 10, 25,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Silymarina', 'Silymarina', 'Vitaminas y Suplementos', 'Cápsulas', '140 mg',
   '20-50 mg/kg PO cada 24h (perros y gatos; cardo mariano, hepatoprotector)', 20, 50,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Coenzima Q10', 'Coenzima Q10', 'Vitaminas y Suplementos', 'Cápsulas', '30 mg',
   '3-9 mg/kg PO cada 24h (perros; 30-90 mg/día)', 3, 9,
   'Oral', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTÍDOTOS / EMERGENCIAS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Naloxona', 'Naloxona', 'Antídotos / Emergencias', 'Inyectable', '0.4 mg/ml',
   '0.01-0.04 mg/kg IV/IM/SC (perros y gatos; sobredosis opioides)', 0.01, 0.04,
   'Intravenosa/Intramuscular/Subcutánea', 1, 'Merck Veterinary Manual'),
  ('Flumazenil', 'Flumazenil', 'Antídotos / Emergencias', 'Inyectable', '0.1 mg/ml',
   '0.01 mg/kg IV (perros y gatos; sobredosis benzodiazepinas)', 0.01, 0.01,
   'Intravenosa', 1, 'Merck Veterinary Manual'),
  ('Acetilcisteína', 'Acetilcisteína', 'Antídotos / Emergencias', 'Comprimidos', '200 mg',
   '70-140 mg/kg PO/IV (perros y gatos; antídoto paracetamol)', 70, 140,
   'Oral/Intravenosa', 24, 'Merck Veterinary Manual'),
  ('Carbón activado', 'Carbón activado', 'Antídotos / Emergencias', 'Suspensión oral', '50 g',
   '1-3 g/kg PO (perros y gatos; adsorber tóxicos)', 1000, 3000,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Atropina', 'Atropina', 'Antídotos / Emergencias', 'Inyectable', '0.5 mg/ml',
   '0.02-0.2 mg/kg IV/IM/SC (perros y gatos; antídoto organofosforados)', 0.02, 0.2,
   'Intravenosa/Intramuscular/Subcutánea', 1, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANESTÉSICOS LOCALES
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Bupivacaína', 'Bupivacaína', 'Anestésicos Locales', 'Inyectable', '5 mg/ml',
   '1-2 mg/kg en bloqueos regionales (perros y gatos; máx. total 2 mg/kg)', 1, 2,
   'Infiltración/Regional', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ============================================================================
-- FIN DE SEGUNDA AMPLIACIÓN
-- Estimado: ~104 nuevos registros + corrección de duplicado Pimobendan
-- ============================================================================