-- Cierre de catálogo de anestesia: 4 fármacos faltantes
-- Fuentes: Plumb's Veterinary Drug Handbook (10a ed.), Lumb & Jones' Veterinary Anesthesia and Analgesia, MSD Veterinary Manual

INSERT INTO public.medicamentos
  (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, dosis_recomendada, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por)
VALUES
  ('Tetracaína', 'Tetracaína', 'Anestésicos / Local', 'Inyectable', '0.5-1% (con adrenalina)',
   'Infiltración/regional: 0.2-0.5%; máximo 1-2 mg/kg total (perros). Onset 10-15 min, duración larga',
   'Infiltración/Epidural', ARRAY['Perro','Gato','Equino'], 'alto', true,
   'Anestesia local regional y espinal; tópica oftálmica (colirio)',
   'Toxicidad SNC y cardiovascular (más que lidocaína); hipotensión; bradicardia; convulsiones en sobredosis',
   'No usar por vía IV; hipersensibilidad a ésteres de ácido para-aminobenzoico; evitar en hipotensión severa',
   'Éster de acción larga, más potente y tóxico que lidocaína. En veterinaria es poco usado: bupivacaína/ropivacaína son preferidas. Suele combinarse con adrenalina.',
   'Plumb''s Veterinary Drug Handbook; Lumb & Jones'' Veterinary Anesthesia',
   'https://www.msdvetmanual.com', NULL),
  ('Levobupivacaína', 'Levobupivacaína', 'Anestésicos / Local', 'Inyectable', '0.25-0.5%',
   'Regional/epidural: 1-2 mg/kg total (perros); infiltración 0.25-0.5%. Onset 10-20 min, duración larga',
   'Infiltración/Epidural', ARRAY['Perro','Gato'], 'precaucion', true,
   'Anestesia local regional, epidural e infiltración de heridas',
   'Menos cardiotóxica y neurotóxica que bupivacaína; hipotensión; bradicardia; toxicidad SNC en sobredosis',
   'Hipersensibilidad a amidas; no usar IV; precaución en hipotensión o bloqueo AV',
   'Isómero S de bupivacaína: margen de seguridad más amplio. Alternativa más segura para bloqueos regionales prolongados.',
   'Plumb''s Veterinary Drug Handbook; BSAVA Small Animal Formulary',
   'https://www.bsava.com', NULL),
  ('Succinilcolina', 'Succinilcolina', 'Anestésicos / Bloqueante neuromuscular', 'Inyectable', '10-20 mg/ml',
   'Perros: 0.3-1 mg/kg IV; gatos: 0.5-1 mg/kg IV. Onset 30-60 s, duración 5-10 min',
   'Intravenosa', ARRAY['Perro','Gato','Equino'], 'alto', true,
   'Relajación muscular de acción ultracorta para intubación y procedimientos breves',
   'Hiperpotasemia, apnea, arritmias; hipertermia maligna (especies susceptibles); dolor muscular postoperatorio; bradicardia',
   'Hipertermia maligna; hiperpotasemia; quemaduras extensas; lesiones oculares/cerradas; miopatías; insuficiencia renal/hepática grave',
   'Único bloqueante despolarizante en uso. NO se revierte con neostigmina. Requiere ventilación controlada disponible. Uso infrecuente en veterinaria.',
   'Plumb''s Veterinary Drug Handbook; Lumb & Jones'' Veterinary Anesthesia',
   'https://www.msdvetmanual.com', NULL),
  ('Cisatracurio', 'Cisatracurio', 'Anestésicos / Bloqueante neuromuscular', 'Inyectable', '2 mg/ml',
   'Perros/gatos: 0.1-0.2 mg/kg IV (intubación); infusión 0.1-0.2 mg/kg/min según respuesta',
   'Intravenosa', ARRAY['Perro','Gato','Equino'], 'alto', true,
   'Bloqueo neuromuscular no despolarizante para intubación y cirugía; relajación muscular',
   'Hipotensión leve; liberación mínima de histamina (menor que atracurio); apnea; debilidad residual',
   'Hipersensibilidad a benzilisoquinolinas; miastenia grave; insuficiencia hepática/renal grave (precaución)',
   'Isómero 1R de atracurio: menos liberación de histamina. Se degrada por vía de Hofmann (independiente de órganos). Reversible con neostigmina.',
   'Plumb''s Veterinary Drug Handbook; Lumb & Jones'' Veterinary Anesthesia',
   'https://www.msdvetmanual.com', NULL)
ON CONFLICT DO NOTHING;

-- Rangos numéricos para el método "catálogo" de la calculadora
UPDATE public.medicamentos SET dosis_minima_mg_kg = 0.5, dosis_maxima_mg_kg = 2.0 WHERE nombre = 'Tetracaína';
UPDATE public.medicamentos SET dosis_minima_mg_kg = 1.0, dosis_maxima_mg_kg = 2.0 WHERE nombre = 'Levobupivacaína';
UPDATE public.medicamentos SET dosis_minima_mg_kg = 0.3, dosis_maxima_mg_kg = 1.0 WHERE nombre = 'Succinilcolina';
UPDATE public.medicamentos SET dosis_minima_mg_kg = 0.1, dosis_maxima_mg_kg = 0.2 WHERE nombre = 'Cisatracurio';
