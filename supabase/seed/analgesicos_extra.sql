-- Analgésicos adicionales y vías de administración faltantes
-- Octubre 2026

-- Completar via_administracion en los que quedaron en NULL
UPDATE public.medicamentos SET via_administracion = 'Intravenosa/Intramuscular/Subcutánea' WHERE nombre IN ('Butorfanol','Hidromorfona','Metadona') AND via_administracion IS NULL;
UPDATE public.medicamentos SET via_administracion = 'Oral' WHERE nombre IN ('Oxicodona','Tramadol','Carprofeno','Piroxicam','Tenoxicam','Ketamina (baja)') AND via_administracion IS NULL;
UPDATE public.medicamentos SET via_administracion = 'Intravenosa/Infusión' WHERE nombre = 'Lidocaína' AND via_administracion IS NULL;
UPDATE public.medicamentos SET via_administracion = 'Local/Infiltración' WHERE nombre = 'Bupivacaína' AND via_administracion IS NULL;
UPDATE public.medicamentos SET via_administracion = 'Oral' WHERE nombre IN ('Omeprazol','Sucralfato') AND via_administracion IS NULL;

-- AINEs COX-2 selectivos y otros faltantes
INSERT INTO public.medicamentos (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, creado_por)
VALUES
  ('Cimicoxib', 'Cimicoxib', 'Analgésicos / AINEs', 'Comprimidos', '20-80 mg', '1-2 mg/kg PO cada 24h (perros); COX-2 selectivo', 'Oral', ARRAY['Perro'], 'normal', true, NULL),
  ('Mavacoxib', 'Mavacoxib', 'Analgésicos / AINEs', 'Comprimidos', '95-230 mg', '2 mg/kg PO cada 14 días tras dosis inicial (perros)', 'Oral', ARRAY['Perro'], 'normal', true, NULL),
  ('Ketoprofeno', 'Ketoprofeno', 'Analgésicos / AINEs', 'Solución inyectable', '100 mg/ml', '1-2 mg/kg IV/IM/SC cada 24h (perros); 1 mg/kg (gatos)', 'Intravenosa/Intramuscular/Subcutánea', ARRAY['Perro','Gato'], 'normal', true, NULL),
  ('Meloxicam inyectable', 'Meloxicam', 'Analgésicos / AINEs', 'Solución inyectable', '5 mg/ml', '0.2 mg/kg SC dosis única inicial; luego 0.1 mg/kg PO cada 24h (perros); 0.3 mg/kg SC (gatos)', 'Subcutánea/Oral', ARRAY['Perro','Gato'], 'normal', true, NULL),
  ('Vedaprofeno', 'Vedaprofeno', 'Analgésicos / AINEs', 'Solución inyectable', '10 mg/ml', '0.5 mg/kg IV/SC cada 24h (perros); 1 mg/kg IV/SC (gatos)', 'Intravenosa/Subcutánea', ARRAY['Perro','Gato'], 'normal', true, NULL),
  ('Ibuprofeno', 'Ibuprofeno', 'Analgésicos / AINEs', 'Comprimidos', '200-600 mg', 'NO recomendado en perros ni gatos; riesgo GI y renal elevado', 'Oral', ARRAY[]::text[], 'alto', true, NULL),
  ('Naproxeno', 'Naproxeno', 'Analgésicos / AINEs', 'Comprimidos', '250-500 mg', '5 mg/kg PO cada 24h día 1; luego 2.5 mg/kg cada 24h (perros); evitar en gatos', 'Oral', ARRAY['Perro'], 'normal', true, NULL),

  -- Opioides adicionales
  ('Fentanilo (inyectable)', 'Fentanilo', 'Analgésicos / Opioides', 'Solución inyectable', '50 µg/ml', '2-5 µg/kg IV lento; infusión 2-5 µg/kg/h (perros y gatos)', 'Intravenosa/Infusión', ARRAY['Perro','Gato'], 'alto', true, NULL),
  ('Remifentanilo', 'Remifentanilo', 'Analgésicos / Opioides', 'Solución inyectable', '1 mg/ml', '1-3 µg/kg IV bolo; infusión 5-20 µg/kg/h (perros y gatos)', 'Intravenosa/Infusión', ARRAY['Perro','Gato'], 'alto', true, NULL),
  ('Alfentanilo', 'Alfentanilo', 'Analgésicos / Opioides', 'Solución inyectable', '500 µg/ml', '5-20 µg/kg IV (perros y gatos); infusión 0.5-3 µg/kg/min', 'Intravenosa/Infusión', ARRAY['Perro','Gato'], 'alto', true, NULL),
  ('Naloxona', 'Naloxona', 'Analgésicos / Antagonista opioide', 'Solución inyectable', '0.4 mg/ml', '0.01-0.04 mg/kg IV/IM/SC (reversión de opioides)', 'Intravenosa/Intramuscular/Subcutánea', ARRAY['Perro','Gato'], 'alto', true, NULL),

  -- Analgésicos adyuvantes / neuropáticos
  ('Duloxetina', 'Duloxetina', 'Analgésicos / Adyuvantes', 'Cápsulas', '20-40 mg', '0.5-1 mg/kg PO cada 24h (perros; dolor neuropático)', 'Oral', ARRAY['Perro'], 'normal', true, NULL),
  ('Venlafaxina', 'Venlafaxina', 'Analgésicos / Adyuvantes', 'Comprimidos', '37.5-75 mg', '1-2 mg/kg PO cada 24h (perros; dolor neuropático)', 'Oral', ARRAY['Perro'], 'normal', true, NULL),
  ('Metadona oral', 'Metadona', 'Analgésicos / Opioides', 'Comprimidos', '5-10 mg', '0.2-0.5 mg/kg PO cada 6-8h (perros); baja biodisponibilidad oral', 'Oral', ARRAY['Perro'], 'alto', true, NULL),
  ('Tapentadol', 'Tapentadol', 'Analgésicos / Opioides', 'Comprimidos', '50-100 mg', '2-4 mg/kg PO cada 8-12h (perros; dolor moderado-severo)', 'Oral', ARRAY['Perro'], 'alto', true, NULL),

  -- Anestésicos locales
  ('Ropivacaína', 'Ropivacaína', 'Analgésicos / Local', 'Solución inyectable', '0.2-1%', '1-2 mg/kg infiltración/local (perros); menos cardiotóxica que bupivacaína', 'Local/Infiltración', ARRAY['Perro','Gato'], 'normal', true, NULL),
  ('Mepivacaína', 'Mepivacaína', 'Analgésicos / Local', 'Solución inyectable', '1-2%', '1-2 mg/kg local (perros y gatos); duración corta', 'Local/Infiltración', ARRAY['Perro','Gato'], 'normal', true, NULL),

  -- Antagonistas / adyuvantes
  ('Ketoprofeno oral', 'Ketoprofeno', 'Analgésicos / AINEs', 'Comprimidos', '5-20 mg', '1 mg/kg PO cada 24h (perros)', 'Oral', ARRAY['Perro'], 'normal', true, NULL),
  ('Tepoxalina', 'Tepoxalina', 'Analgésicos / AINEs', 'Suspensión oral', '25 mg/ml', '10-20 mg/kg PO cada 24h (perros; dual COX/LOX)', 'Oral', ARRAY['Perro'], 'normal', true, NULL)
ON CONFLICT DO NOTHING;