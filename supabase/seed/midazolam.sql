-- Midazolam — benzodiazepina de premedicación (faltaba en el catálogo vivo)
-- Fuentes: Plumb's Veterinary Drug Handbook (10a ed.), Lumb & Jones' Veterinary Anesthesia and Analgesia, MSD Veterinary Manual

INSERT INTO public.medicamentos
  (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por)
VALUES
  ('Midazolam', 'Midazolam', 'Sedantes y Anestésicos', 'Inyectable', '5 mg/ml',
   'Perros: 0.1-0.4 mg/kg IV/IM; gatos: 0.1-0.3 mg/kg IV/IM; como premedicación 15-30 min antes de la inducción',
   'Intravenosa/Intramuscular', ARRAY['Perro','Gato','Equino','Bovino'], 'precaucion', true,
   'Premedicación y sedación previa a anestesia; ansiólisis; inducción (asociado a opioides); anticonvulsivante; relajante muscular esquelético',
   'Sedación, ataxia; excitación paradójica (más frecuente en gatos y equinos); depresión respiratoria (potenciada con opioides); hipotensión; reducción de motilidad GI',
   'Hipersensibilidad a benzodiazepinas; shock; insuficiencia hepática severa; embarazo; no mezclar en la misma jeringa con fármacos incompatibles',
   'Benzodiazepina de acción corta y soluble en agua (menos dolor en sitio IV que diazepam). Potencia opioides y ketamina, permitiendo reducir dosis de inducción. Reversible con flumazenil.',
   'Plumb''s Veterinary Drug Handbook; Lumb & Jones'' Veterinary Anesthesia',
   'https://www.msdvetmanual.com', NULL)
ON CONFLICT DO NOTHING;

-- Rango numérico para el método "catálogo" de la calculadora
UPDATE public.medicamentos SET dosis_minima_mg_kg = 0.1, dosis_maxima_mg_kg = 0.4 WHERE nombre = 'Midazolam';
