-- ============================================================================
-- AMPLIACIÓN DEL CATÁLOGO DE MEDICAMENTOS VETERINARIOS
-- Formulario veterinario de uso en perros y gatos — todas las familias
-- ============================================================================
-- Criterio de fuentes (sesiones previas, memoria `luna-vet-formulary-sources`):
-- la dosis de referencia es la aprobada en prospecto oficial (SPC / DailyMed /
-- NOAH Compendium / VMD) o el consenso de referencia clínica (Plumb's /
-- Merck Veterinary Manual / WSAVA). No se copian datos sin verificar.
--
-- NOTA CHILE: el registro local es SAG (Servicio Agrícola y Ganadero). Las
-- dosis mg/kg son independientes del país; solo cambia la disponibilidad de
-- marcas comerciales. Verificar producto registrado ante SAG antes de usar.
--
-- El esquema es especie-agnostic: dosis_minima_mg_kg / dosis_maxima_mg_kg
-- representan el rango general canino/felino; las diferencias por especie
-- se anotan en dosis_recomendada.
--
-- EXCLUSIONES: se omiten medicamentos cuyo principio activo y presentación
-- ya existen en el seed.sql (Doxiciclina, Omeprazol, Furosemida, Pimobendan,
-- Ranitidina, Vitamina E + Selenio, Calcio Inyectable, Ketoprofeno,
-- Carprofeno, Tramadol, Xilazina, Midazolam, Propofol, Cefalexina,
-- Amoxicilina + Clavulánico).
-- ============================================================================

-- ----------------------------------------------------------------------------
-- SEDANTES Y ANESTÉSICOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Acepromazina', 'Acepromacina', 'Sedantes y Anestésicos', 'Inyectable', '10 mg/ml',
   '0.05-0.1 mg/kg (perros y gatos; precaución en gatos y razas braquicéfalas)', 0.05, 0.1,
   'Intramuscular/Intravenosa/Subcutánea', 8, 'Merck Veterinary Manual'),
  ('Medetomidina', 'Medetomidina', 'Sedantes y Anestésicos', 'Inyectable', '1 mg/ml',
   '0.005-0.01 mg/kg IM (perros y gatos)', 0.005, 0.01,
   'Intramuscular', 6, 'NOAH Compendium'),
  ('Dexmedetomidina', 'Dexmedetomidina', 'Sedantes y Anestésicos', 'Inyectable', '0.5 mg/ml',
   '0.005-0.01 mg/kg IM (perros y gatos)', 0.005, 0.01,
   'Intramuscular', 6, 'DailyMed'),
  ('Diazepam', 'Diazepam', 'Sedantes y Anestésicos', 'Inyectable', '5 mg/ml',
   '0.5-1 mg/kg IV/IM (perros); gatos máximo 0.5 mg/kg', 0.5, 1,
   'Intravenosa/Intramuscular', 6, 'Merck Veterinary Manual'),
  ('Alfaxalona', 'Alfaxalona', 'Sedantes y Anestésicos', 'Inyectable', '10 mg/ml',
   '1-5 mg/kg IV (perros y gatos)', 1, 5,
   'Intravenosa', 24, 'NOAH Compendium'),
  ('Tiletamina + Zolazepam', 'Tiletamina + Zolazepam', 'Sedantes y Anestésicos', 'Inyectable', '100 mg/ml',
   '5-10 mg/kg IM (perros y gatos)', 5, 10,
   'Intramuscular', 24, 'DailyMed')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANALGÉSICOS / ANTIINFLAMATORIOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Flunixin Meglumina', 'Flunixin Meglumina', 'Analgésicos / Antiinflamatorios', 'Inyectable', '50 mg/ml',
   '0.5-1 mg/kg IV/IM/SC (perros y gatos)', 0.5, 1,
   'Intravenosa/Intramuscular/Subcutánea', 24, 'DailyMed'),
  ('Dipirona', 'Metamizol', 'Analgésicos / Antiinflamatorios', 'Inyectable', '500 mg/ml',
   '25-40 mg/kg IM/SC (perros y gatos; uso frecuente LATAM)', 25, 40,
   'Intramuscular/Subcutánea', 6, 'Referencia clínica LatAm'),
  ('Buprenorfina', 'Buprenorfina', 'Analgésicos / Antiinflamatorios', 'Inyectable', '0.3 mg/ml',
   '0.01-0.03 mg/kg IV/IM/SC (perros y gatos)', 0.01, 0.03,
   'Intravenosa/Intramuscular/Subcutánea', 8, 'DailyMed'),
  ('Morfina', 'Morfina', 'Analgésicos / Antiinflamatorios', 'Inyectable', '10 mg/ml',
   '0.5-1 mg/kg IM/SC/IV (perros y gatos)', 0.5, 1,
   'Intramuscular/Subcutánea/Intravenosa', 6, 'Merck Veterinary Manual'),
  ('Fentanilo (parche)', 'Fentanilo', 'Analgésicos / Antiinflamatorios', 'Parche transdérmico', '20 µg/h',
   '2-4 µg/kg/h transdérmico (perros)', 0.002, 0.004,
   'Transdérmico', 168, 'DailyMed'),
  ('Codeína', 'Codeína', 'Analgésicos / Antiinflamatorios', 'Jarabe', '30 mg/5 ml',
   '0.5-1 mg/kg PO cada 8h (perros; antitusivo/analgésico leve)', 0.5, 1,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Amantadina', 'Amantadina', 'Analgésicos / Antiinflamatorios', 'Comprimidos', '100 mg',
   '3-5 mg/kg PO cada 24h (perros; dolor crónico)', 3, 5,
   'Oral', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTIBIÓTICOS / ANTIMICROBIANOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Amoxicilina', 'Amoxicilina', 'Antibióticos / Antimicrobianos', 'Cápsulas', '250 mg',
   '11-22 mg/kg PO/SC cada 12h (perros y gatos)', 11, 22,
   'Oral/Subcutánea', 12, 'DailyMed'),
  ('Cefadroxila', 'Cefadroxila', 'Antibióticos / Antimicrobianos', 'Comprimidos', '250 mg',
   '20-30 mg/kg PO cada 24h (perros y gatos)', 20, 30,
   'Oral', 24, 'DailyMed'),
  ('Cefovecina', 'Cefovecina', 'Antibióticos / Antimicrobianos', 'Inyectable', '80 mg/ml',
   '8 mg/kg SC (perros); 3.6-8 mg/kg SC (gatos); cada 2-4 semanas', 3.6, 8,
   'Subcutánea', 336, 'DailyMed'),
  ('Marbofloxacina', 'Marbofloxacina', 'Antibióticos / Antimicrobianos', 'Comprimidos', '25 mg',
   '2-4 mg/kg PO cada 24h (perros y gatos)', 2, 4,
   'Oral', 24, 'NOAH Compendium'),
  ('Orbifloxacina', 'Orbifloxacina', 'Antibióticos / Antimicrobianos', 'Comprimidos', '50 mg',
   '2.5-7.5 mg/kg PO cada 24h (perros)', 2.5, 7.5,
   'Oral', 24, 'DailyMed'),
  ('Pradofloxacina', 'Pradofloxacina', 'Antibióticos / Antimicrobianos', 'Comprimidos', '25 mg',
   '3-6 mg/kg PO cada 24h (perros y gatos)', 3, 6,
   'Oral', 24, 'NOAH Compendium'),
  ('Gentamicina', 'Gentamicina', 'Antibióticos / Antimicrobianos', 'Inyectable', '40 mg/ml',
   '4-8 mg/kg IV/IM/SC cada 24h (perros); gatos 6-8 mg/kg', 4, 8,
   'Intravenosa/Intramuscular/Subcutánea', 24, 'Merck Veterinary Manual'),
  ('Amikacina', 'Amikacina', 'Antibióticos / Antimicrobianos', 'Inyectable', '250 mg/ml',
   '8-16 mg/kg IV/IM/SC cada 24h (perros)', 8, 16,
   'Intravenosa/Intramuscular/Subcutánea', 24, 'Merck Veterinary Manual'),
  ('Cloranfenicol', 'Cloranfenicol', 'Antibióticos / Antimicrobianos', 'Cápsulas', '250 mg',
   '25-50 mg/kg PO/IV/IM cada 12h (perros y gatos)', 25, 50,
   'Oral/Intravenosa/Intramuscular', 12, 'Merck Veterinary Manual'),
  ('Clindamicina', 'Clindamicina', 'Antibióticos / Antimicrobianos', 'Cápsulas', '75 mg',
   '5-10 mg/kg PO cada 12h (perros y gatos)', 5, 10,
   'Oral', 12, 'DailyMed'),
  ('Metronidazol', 'Metronidazol', 'Antibióticos / Antimicrobianos', 'Comprimidos', '250 mg',
   '10-25 mg/kg PO/IV cada 12h (perros y gatos); Giardia 20-50', 10, 25,
   'Oral/Intravenosa', 12, 'Merck Veterinary Manual'),
  ('Azitromicina', 'Azitromicina', 'Antibióticos / Antimicrobianos', 'Comprimidos', '250 mg',
   '5-10 mg/kg PO cada 24h (perros y gatos)', 5, 10,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Ceftiofur', 'Ceftiofur', 'Antibióticos / Antimicrobianos', 'Inyectable', '50 mg/ml',
   '1-2 mg/kg SC/IM/IV cada 24h (perros y gatos; uso off-label)', 1, 2,
   'Subcutánea/Intramuscular/Intravenosa', 24, 'DailyMed'),
  ('Nitrofurantoína', 'Nitrofurantoína', 'Antibióticos / Antimicrobianos', 'Comprimidos', '100 mg',
   '2-4 mg/kg PO cada 8h (perros; infecciones urinarias bajas)', 2, 4,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Sulfametoxazol + Trimetoprima', 'Sulfametoxazol + Trimetoprima', 'Antibióticos / Antimicrobianos', 'Comprimidos', '400/80 mg',
   '15-30 mg/kg (TMP) PO/IV cada 12h (perros y gatos)', 15, 30,
   'Oral/Intravenosa', 12, 'Merck Veterinary Manual'),
  ('Tylosina', 'Tylosina', 'Antibióticos / Antimicrobianos', 'Granulado', '125 mg/g',
   '5-15 mg/kg PO cada 24h (perros; enteropatía sensible)', 5, 15,
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
  ('Famotidina', 'Famotidina', 'Gastrointestinales', 'Comprimidos', '20 mg',
   '0.5-1 mg/kg PO cada 12h (perros y gatos)', 0.5, 1,
   'Oral', 12, 'DailyMed'),
  ('Maropitant', 'Maropitant', 'Gastrointestinales', 'Comprimidos', '8 mg',
   '1-2 mg/kg SC/PO cada 24h (perros y gatos; antiemético)', 1, 2,
   'Subcutánea/Oral', 24, 'DailyMed'),
  ('Ondansetrón', 'Ondansetrón', 'Gastrointestinales', 'Comprimidos', '4 mg',
   '0.1-0.5 mg/kg IV/PO cada 8-12h (perros y gatos)', 0.1, 0.5,
   'Intravenosa/Oral', 8, 'Merck Veterinary Manual'),
  ('Loperamida', 'Loperamida', 'Gastrointestinales', 'Comprimidos', '2 mg',
   '0.1-0.2 mg/kg PO cada 8h (solo perros; evitar gatos por MDR1)', 0.1, 0.2,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Sucralfato', 'Sucralfato', 'Gastrointestinales', 'Comprimidos', '1 g',
   '50-100 mg/kg PO cada 8h (perros y gatos)', 50, 100,
   'Oral', 8, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTIPARASITARIOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Fenbendazol', 'Fenbendazol', 'Antiparasitarios', 'Comprimidos', '500 mg',
   '50 mg/kg PO cada 24h por 3-5 días (perros y gatos)', 50, 50,
   'Oral', 24, 'DailyMed'),
  ('Praziquantel', 'Praziquantel', 'Antiparasitarios', 'Comprimidos', '25 mg',
   '5-7.5 mg/kg PO cada 24h (perros y gatos)', 5, 7.5,
   'Oral', 24, 'DailyMed'),
  ('Ivermectina', 'Ivermectina', 'Antiparasitarios', 'Inyectable', '10 mg/ml',
   '0.2-0.4 mg/kg PO/SC cada 24h (perros y gatos; precaución razas MDR1)', 0.2, 0.4,
   'Oral/Subcutánea', 24, 'DailyMed'),
  ('Milbemicina Oxima', 'Milbemicina Oxima', 'Antiparasitarios', 'Comprimidos', '11.4 mg',
   '0.5-1 mg/kg PO cada 24h (perros y gatos)', 0.5, 1,
   'Oral', 24, 'DailyMed'),
  ('Selamectina', 'Selamectina', 'Antiparasitarios', 'Spot-on', '60 mg/ml',
   '6-12 mg/kg tópico cada 30 días (perros y gatos)', 6, 12,
   'Tópica', 720, 'DailyMed'),
  ('Moxidectina', 'Moxidectina', 'Antiparasitarios', 'Spot-on', '25 mg/ml',
   '2.5 mg/kg tópico cada 30 días (perros)', 2.5, 2.5,
   'Tópica', 720, 'DailyMed'),
  ('Fipronil', 'Fipronil', 'Antiparasitarios', 'Spot-on', '100 mg/ml',
   '9-18 mg/kg tópico cada 30 días (perros y gatos)', 9, 18,
   'Tópica', 720, 'DailyMed'),
  ('Ponazuril', 'Ponazuril', 'Antiparasitarios', 'Suspensión oral', '100 mg/ml',
   '20-50 mg/kg PO cada 24h (perros y gatos; coccidias)', 20, 50,
   'Oral', 24, 'Referencia clínica'),
  ('Sulfadimetoxina', 'Sulfadimetoxina', 'Antiparasitarios', 'Comprimidos', '500 mg',
   '27.5-55 mg/kg PO (loading/therapy perros; coccidias)', 27.5, 55,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Diethylcarbamaza', 'Diethylcarbamaza', 'Antiparasitarios', 'Comprimidos', '50 mg',
   '2.5-10 mg/kg PO cada 24h (perros; profilaxis cardícola)', 2.5, 10,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Pirantel Pamoato', 'Pirantel Pamoato', 'Antiparasitarios', 'Suspensión oral', '50 mg/ml',
   '5-11 mg/kg PO cada 24h (perros y gatos)', 5, 11,
   'Oral', 24, 'DailyMed'),
  ('Espinosad', 'Espinosad', 'Antiparasitarios', 'Comprimidos masticables', '30 mg',
   '1-2 mg/kg PO cada 30 días (perros; antipulgas)', 1, 2,
   'Oral', 720, 'DailyMed')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ANTIHISTAMÍNICOS / ALÉRGICOS / DERMATOLÓGICOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Diphenhydramina', 'Difenhidramina', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Comprimidos', '25 mg',
   '2-4 mg/kg PO/IV/IM cada 8h (perros y gatos)', 2, 4,
   'Oral/Intravenosa/Intramuscular', 8, 'Merck Veterinary Manual'),
  ('Cetirizina', 'Cetirizina', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Comprimidos', '10 mg',
   '0.5 mg/kg PO cada 24h (perros)', 0.5, 0.5,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Loratadina', 'Loratadina', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Comprimidos', '10 mg',
   '0.25-0.5 mg/kg PO cada 24h (perros)', 0.25, 0.5,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Hidroxizina', 'Hidroxizina', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Cápsulas', '25 mg',
   '0.5-2 mg/kg PO cada 8h (perros)', 0.5, 2,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Prednisona', 'Prednisona', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Comprimidos', '20 mg',
   '0.5-2 mg/kg PO cada 24h (perros); gatos 1-2 mg/kg', 0.5, 2,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Metilprednisolona', 'Metilprednisolona', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Comprimidos', '4 mg',
   '1-2 mg/kg PO cada 24h (perros y gatos)', 1, 2,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Dexametasona', 'Dexametasona', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Inyectable', '4 mg/ml',
   '0.1-0.5 mg/kg IV/IM (perros; uso corto)', 0.1, 0.5,
   'Intravenosa/Intramuscular', 24, 'Merck Veterinary Manual'),
  ('Triamcinolona', 'Triamcinolona', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Inyectable', '10 mg/ml',
   '0.5-1 mg/kg IM (perros; dermatosis alérgica)', 0.5, 1,
   'Intramuscular', 24, 'DailyMed'),
  ('Oclacitinib', 'Oclacitinib', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Comprimidos', '16 mg',
   '0.4-0.6 mg/kg PO (perros; prurito atópico, Apoquel)', 0.4, 0.6,
   'Oral', 24, 'DailyMed'),
  ('Ciclosporina', 'Ciclosporina', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Cápsulas', '25 mg',
   '5 mg/kg PO cada 24h (perros; dermatitis atópica, Atopica)', 5, 5,
   'Oral', 24, 'DailyMed'),
  ('Ketoconazol', 'Ketoconazol', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Comprimidos', '200 mg',
   '5-10 mg/kg PO cada 24h (perros y gatos)', 5, 10,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Fluconazol', 'Fluconazol', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Cápsulas', '100 mg',
   '5-10 mg/kg PO cada 24h (perros y gatos)', 5, 10,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Itraconazol', 'Itraconazol', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Cápsulas', '100 mg',
   '5 mg/kg PO cada 24h (perros y gatos)', 5, 5,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Griseofulvina', 'Griseofulvina', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Comprimidos', '250 mg',
   '25-50 mg/kg PO cada 24h (perros y gatos; dermatofitosis)', 25, 50,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Lokivetmab', 'Lokivetmab', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Inyectable', '20 mg/ml',
   '1-3 mg/kg SC cada 4-8 semanas (perros; Cytopoint)', 1, 3,
   'Subcutánea', 336, 'DailyMed'),
  ('Terbinafina', 'Terbinafina', 'Antihistamínicos / Alérgicos / Dermatológicos', 'Comprimidos', '250 mg',
   '25-55 mg/kg PO cada 24h (perros y gatos; onicomicosis)', 25, 55,
   'Oral', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- ENDOCRINOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Levotiroxina', 'Levotiroxina', 'Endocrinos', 'Comprimidos', '100 µg',
   '0.02-0.04 mg/kg PO cada 24h (perros); gatos 0.1-0.3 mg/día total', 0.02, 0.04,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Trilostano', 'Trilostano', 'Endocrinos', 'Cápsulas', '30 mg',
   '2-6 mg/kg PO cada 24h (perros; hiperadrenocorticismo, Vetoryl)', 2, 6,
   'Oral', 24, 'DailyMed'),
  ('Desmopresina', 'Desmopresina', 'Endocrinos', 'Comprimidos', '0.1 mg',
   '0.005-0.01 mg/kg PO cada 12h (perros; diabetes insípida)', 0.005, 0.01,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Alopurinol', 'Alopurinol', 'Endocrinos', 'Comprimidos', '100 mg',
   '10-15 mg/kg PO cada 24h (perros; urolitiasis por xantina)', 10, 15,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Fenilpropanolamina', 'Fenilpropanolamina', 'Endocrinos', 'Comprimidos', '50 mg',
   '1.5-2.5 mg/kg PO cada 12h (perros; incontinencia urinaria)', 1.5, 2.5,
   'Oral', 12, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- CARDIOVASCULARES
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Benazepril', 'Benazepril', 'Cardiovasculares', 'Comprimidos', '10 mg',
   '0.25-0.5 mg/kg PO cada 24h (perros y gatos; IECA)', 0.25, 0.5,
   'Oral', 24, 'DailyMed'),
  ('Captopril', 'Captopril', 'Cardiovasculares', 'Comprimidos', '25 mg',
   '0.5-1.5 mg/kg PO cada 12h (perros; IECA)', 0.5, 1.5,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Espironolactona', 'Espironolactona', 'Cardiovasculares', 'Comprimidos', '25 mg',
   '1-2 mg/kg PO cada 24h (perros; diurético ahorrador)', 1, 2,
   'Oral', 24, 'DailyMed'),
  ('Pimobendán', 'Pimobendán', 'Cardiovasculares', 'Comprimidos', '2.5 mg',
   '0.25-0.5 mg/kg PO cada 12h (perros; insuficiencia cardíaca)', 0.25, 0.5,
   'Oral', 12, 'DailyMed'),
  ('Atenolol', 'Atenolol', 'Cardiovasculares', 'Comprimidos', '50 mg',
   '0.5-1 mg/kg PO cada 12h (perros y gatos; betabloqueante)', 0.5, 1,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Diltiazem', 'Diltiazem', 'Cardiovasculares', 'Cápsulas', '30 mg',
   '0.5-1 mg/kg PO cada 8h (perros y gatos; antiarrítmico)', 0.5, 1,
   'Oral', 8, 'Merck Veterinary Manual'),
  ('Digoxina', 'Digoxina', 'Cardiovasculares', 'Comprimidos', '0.25 mg',
   '0.005-0.01 mg/kg PO cada 12h (perros); gatos 0.003-0.006 mg/kg', 0.005, 0.01,
   'Oral', 12, 'Merck Veterinary Manual'),
  ('Amlodipino', 'Amlodipino', 'Cardiovasculares', 'Comprimidos', '5 mg',
   '0.1-0.3 mg/kg PO cada 24h (gatos; hipertensión)', 0.1, 0.3,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Clopidogrel', 'Clopidogrel', 'Cardiovasculares', 'Comprimidos', '75 mg',
   '1-2 mg/kg PO cada 24h (perros y gatos; antiagregante plaquetario)', 1, 2,
   'Oral', 24, 'Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ----------------------------------------------------------------------------
-- VITAMINAS Y SUPLEMENTOS
-- ----------------------------------------------------------------------------
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('L-Carnitina', 'L-Carnitina', 'Vitaminas y Suplementos', 'Cápsulas', '500 mg',
   '50-200 mg/kg PO cada 24h (perros; cardiomiopatía)', 50, 200,
   'Oral', 24, 'Merck Veterinary Manual'),
  ('Omega-3 (EPA/DHA)', 'Omega-3 (EPA/DHA)', 'Vitaminas y Suplementos', 'Cápsulas', '300 mg',
   '20-55 mg/kg/día EPA+DHA (perros y gatos)', 20, 55,
   'Oral', 24, 'WSAVA / Merck Veterinary Manual')
ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING;

-- ============================================================================
-- FIN DE AMPLIACIÓN
-- Estimado: 79 nuevos registros, cubriendo 15 familias terapéuticas
-- Total post-migración: ≈ 100 medicamentos (21 existentes + 79 nuevos)
-- ============================================================================