-- Analgésicos faltantes y corrección de dosis
-- Octubre 2026

-- Agregar analgésicos faltantes
INSERT INTO public.medicamentos (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, especies_permitidas, nivel_riesgo, activo, creado_por)
VALUES
  -- Opioides IV/IM
  ('Metadona', 'Metadona', 'Analgésicos / Opioides', 'Solución inyectable', '10 mg/ml', '0.05-0.5 mg/kg IV/SC/IM cada 4-6h (perros y gatos); 0.1 mg/kg SC causa vómitos en gatos', ARRAY['Perro', 'Gato'], 'alto', true, NULL),
  ('Butorfanol', 'Butorfanol', 'Analgésicos / Opioides', 'Solución inyectable', '10 mg/ml', '0.2-0.4 mg/kg IV/IM/SC cada 1-2h (perros y gatos); depresor respiratorio mínimo', ARRAY['Perro', 'Gato'], 'alto', true, NULL),
  ('Tramadol', 'Tramadol', 'Analgésicos / Opioides', 'Comprimidos', '50 mg', '1-4 mg/kg PO/IV cada 6-8h (perros); 1-2 mg/kg cada 8-12h (gatos)', ARRAY['Perro', 'Gato'], 'alto', true, NULL),
  ('Hidromorfona', 'Hidromorfona', 'Analgésicos / Opioides', 'Solución inyectable', '2 mg/ml', '0.05-0.1 mg/kg IV/IM/SC cada 2-6h (perros y gatos)', ARRAY['Perro', 'Gato'], 'alto', true, NULL),
  ('Oxicodona', 'Oxicodona', 'Analgésicos / Opioides', 'Comprimidos', '5-10-20 mg', '0.1-0.2 mg/kg PO cada 6-8h (perros); usar con precaución en gatos', ARRAY['Perro', 'Gato'], 'alto', true, NULL),
  
  -- Analgésicos complementarios
  ('Ketamina (baja)', 'Ketamina', 'Analgésicos / Disociativo', 'Solución inyectable', '50-100 mg/ml', '0.5-1 mg/kg IV como analgesia adjuvant; infusión 0.1-0.6 mg/kg/h', ARRAY['Perro', 'Gato'], 'alto', true, NULL),
  ('Lidocaína', 'Lidocaína', 'Analgésicos / Local', 'Solución inyectable', '2% (20 mg/ml)', '1-2 mg/kg IV bolo; infusión 25-50 µg/kg/min (perros); NO en gatos', ARRAY['Perro'], 'alto', true, NULL),
  ('Bupivacaína', 'Bupivacaína', 'Analgésicos / Local', 'Solución inyectable', '0.5% (5 mg/ml)', '1-2 mg/kg infiltración local; máximo 2 mg/kg/hora', ARRAY['Perro', 'Gato'], 'alto', true, NULL),

  -- AINEs adicionales
  ('Carprofeno', 'Carprofeno', 'Analgésicos / AINEs', 'Comprimidos', '25-75 mg', '2.2-4.4 mg/kg PO cada 12-24h (perros); NO usar en gatos', ARRAY['Perro'], 'normal', true, NULL),
  ('Piroxicam', 'Piroxicam', 'Analgésicos / AINEs', 'Cápsulas', '10-20 mg', '0.3 mg/kg PO cada 24h (perros); usar con precaución', ARRAY['Perro'], 'normal', true, NULL),
  ('Tenoxicam', 'Tenoxicam', 'Analgésicos / AINEs', 'Comprimidos', '20 mg', '0.4 mg/kg PO cada 24h (perros)', ARRAY['Perro'], 'normal', true, NULL),

  -- Protectores gástricos que pueden usarse con AINEs
  ('Omeprazol', 'Omeprazol', 'Gastroprotectores', 'Comprimidos', '20 mg', '0.5-1 mg/kg PO cada 24h (perros y gatos); proteger mucosa gástrica', ARRAY['Perro', 'Gato'], 'normal', true, NULL),
  ('Sucralfato', 'Sucralfato', 'Gastroprotectores', 'Suspensión', '1 g/5 ml', '0.5-1 g/perro PO cada 8h; 0.25 g/gato PO cada 8h', ARRAY['Perro', 'Gato'], 'normal', true, NULL)
ON CONFLICT DO NOTHING;

-- Corregir dosis pequeñas a µg (más legible)
UPDATE public.medicamentos SET dosis_recomendada = '5-10 µg/kg IM (perros y gatos)' WHERE nombre = 'Medetomidina';
UPDATE public.medicamentos SET dosis_recomendada = '5-10 µg/kg IM (perros y gatos)' WHERE nombre = 'Dexmedetomidina';
UPDATE public.medicamentos SET dosis_recomendada = '5-10 µg/kg PO cada 12h (perros); 3-6 µg/kg (gatos)' WHERE nombre = 'Digoxina';
UPDATE public.medicamentos SET dosis_recomendada = '5-10 µg/kg PO cada 12h (perros; diabetes insípida)' WHERE nombre = 'Desmopresina';

-- Agregar vía de administración a los que faltaban
UPDATE public.medicamentos SET dosis_recomendada = '0.01-0.03 mg/kg IV/IM/SC cada 4-8h (perros y gatos); 0.24 mg/kg SC/día formulación prolongada' WHERE nombre = 'Buprenorfina';
UPDATE public.medicamentos SET dosis_recomendada = '0.5-1 mg/kg IV/IM/SC cada 4-6h (perros y gatos)' WHERE nombre = 'Morfina';