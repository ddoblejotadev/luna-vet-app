-- ============================================================================
-- LUNAVET SEED DATA
-- Datos adicionales de ejemplo para desarrollo
-- ============================================================================

-- Más medicamentos de ejemplo para cada familia terapéutica

-- SEDANTES Y ANESTÉSICOS
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Xilazina 2%', 'Xilazina', 'Sedantes y Anestésicos', 'Inyectable', '20 mg/ml',
   '0.5-1 mg/kg IM', 0.5, 1.0, 'Intramuscular', 24, 'DailyMed'),
  ('Midazolam', 'Midazolam', 'Sedantes y Anestésicos', 'Inyectable', '5 mg/ml',
   '0.2-0.4 mg/kg IM/IV', 0.2, 0.4, 'Intramuscular/Intravenosa', 12, 'NOAH'),
  ('Propofol', 'Propofol', 'Sedantes y Anestésicos', 'Inyectable', '10 mg/ml',
   '4-6 mg/kg IV', 4.0, 6.0, 'Intravenosa', 24, 'DailyMed')
ON CONFLICT DO NOTHING;

-- ANALGÉSICOS / ANTIINFLAMATORIOS
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Carprofeno', 'Carprofeno', 'Analgésicos / Antiinflamatorios', 'Comprimidos', '50 mg',
   '2-4 mg/kg PO cada 12-24h', 2.0, 4.0, 'Oral', 12, 'NOAH'),
  ('Tramadol', 'Tramadol', 'Analgésicos / Antiinflamatorios', 'Comprimidos', '50 mg',
   '2-4 mg/kg PO cada 8-12h', 2.0, 4.0, 'Oral', 8, 'WSAVA'),
  ('Ketoprofeno', 'Ketoprofeno', 'Analgésicos / Antiinflamatorios', 'Inyectable', '100 mg/ml',
   '2 mg/kg SC/IM cada 24h', 1.0, 2.0, 'Subcutánea/Intramuscular', 24, 'SENASA')
ON CONFLICT DO NOTHING;

-- ANTIBIÓTICOS / ANTIMICROBIANOS
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Amoxicilina + Clavulánico', 'Amoxicilina + Ácido Clavulánico', 'Antibióticos / Antimicrobianos', 'Comprimidos', '500/125 mg',
   '12.5-25 mg/kg PO cada 12h', 12.5, 25.0, 'Oral', 12, 'DailyMed'),
  ('Cefalexina', 'Cefalexina', 'Antibióticos / Antimicrobianos', 'Comprimidos', '500 mg',
   '15-30 mg/kg PO cada 8-12h', 15.0, 30.0, 'Oral', 12, 'NOAH'),
  ('Doxiciclina', 'Doxiciclina', 'Antibióticos / Antimicrobianos', 'Comprimidos', '100 mg',
   '5-10 mg/kg PO cada 12-24h', 5.0, 10.0, 'Oral', 12, 'WSAVA')
ON CONFLICT DO NOTHING;

-- VITAMINAS Y SUPLEMENTOS
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Vitamina E + Selenio', 'Tocoferol + Selenio', 'Vitaminas y Suplementos', 'Inyectable', 'Variable',
   '0.1 ml/10kg IM', 0.01, 0.02, 'Intramuscular', 168, 'SENASA'),
  ('Calcio Inyectable', 'Gluconato de Calcio', 'Vitaminas y Suplementos', 'Inyectable', '10%',
   '0.5-1.5 ml/kg IV lento', 5.0, 15.0, 'Intravenosa', 24, 'DailyMed')
ON CONFLICT DO NOTHING;

-- GASTROINTESTINALES
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Omeprazol', 'Omeprazol', 'Gastrointestinales', 'Comprimidos', '20 mg',
   '0.5-1 mg/kg PO cada 24h', 0.5, 1.0, 'Oral', 24, 'NOAH'),
  ('Ranitidina', 'Ranitidina', 'Gastrointestinales', 'Inyectable', '25 mg/ml',
   '1-2 mg/kg SC/IM cada 8-12h', 1.0, 2.0, 'Subcutánea/Intramuscular', 12, 'WSAVA')
ON CONFLICT DO NOTHING;

-- CARDIOVASCULARES
INSERT INTO public.medicamentos (
  nombre, principio_activo, familia_terapeutica, presentacion, concentracion,
  dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg,
  via_administracion, frecuencia_horas, fuente
) VALUES
  ('Furosemida', 'Furosemida', 'Cardiovasculares', 'Inyectable', '50 mg/ml',
   '2-4 mg/kg SC/IM/IV cada 8-12h', 2.0, 4.0, 'Subcutánea/Intramuscular/Intravenosa', 12, 'DailyMed'),
  ('Pimobendan', 'Pimobendan', 'Cardiovasculares', 'Comprimidos', '5 mg',
   '0.25-0.3 mg/kg PO cada 12h', 0.25, 0.3, 'Oral', 12, 'NOAH')
ON CONFLICT DO NOTHING;
