-- Fármacos faltantes: emergencia/cardiovascular + Mastilac (marca multi-presentación) + etamsilato
-- Fuentes: Plumb's Veterinary Drug Handbook (10a ed.), AAHA Anesthesia Guidelines,
--          MSD Veterinary Manual, fichas de producto Mastilac (Callbest/Zoetis/Veterland).
-- Idempotente: borra por nombre y reinserta.

DELETE FROM public.medicamentos WHERE nombre IN ('Tiopental','Epinefrina','Norepinefrina','Etamsilato','Mastilac');

INSERT INTO public.medicamentos
  (nombre, principio_activo, familia_terapeutica, presentacion, concentracion, concentracion_mg_ml,
   dosis_recomendada, dosis_minima_mg_kg, dosis_maxima_mg_kg, via_administracion, especies_permitidas,
   nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por, presentaciones)
VALUES
  ('Tiopental', 'Tiopental sódico', 'Anestésicos / Barbitúricos', 'Inyectable (polvo para reconstituir)',
   '2.5% (25 mg/mL) tras reconstituir', 25,
   'Inducción: perros 5-15 mg/kg IV; gatos 5-12 mg/kg IV; equinos 4-8 mg/kg IV. Efecto en 15-30 s, duración 10-20 min',
   5, 15, 'Intravenosa', ARRAY['Perro','Gato','Equino'], 'alto', true,
   'Inducción anestésica; estado epiléptico refractario; control de hipertensión intracraneal',
   'Depresión respiratoria y apnea; hipotensión; arritmias; recuperación prolongada y excitación; necrosis perivascular por extravasación',
   'Insuficiencia hepática o renal grave; hipovolemia no corregida; galgos y razas sighthound (recuperación muy prolongada); porfiria',
   'Solución muy alcalina (pH ~10.5): nunca mezclar con soluciones ácidas ni administrar con otros fármacos en la misma vía. Extravasación causa necrosis; usar vía IV permeable. Acumula en tejido graso (redistribución).',
   'Plumb''s Veterinary Drug Handbook; AAHA Anesthesia Guidelines', 'https://www.msdvetmanual.com', NULL, NULL),

  ('Epinefrina', 'Epinefrina (adrenalina)', 'Cardiovascular / Vasopresor', 'Inyectable (ampolla)',
   '1 mg/mL (1:1000)', 1,
   'Paro cardiorrespiratorio: 0.01-0.02 mg/kg IV (baja dosis) o 0.1 mg/kg intratraqueal; anafilaxia: 0.01 mg/kg IM (máx 0.5 mg); infusión 0.05-0.2 mcg/kg/min',
   0.01, 0.02, 'Intravenosa / Intramuscular / Intratraqueal', ARRAY['Perro','Gato'], 'critico', true,
   'Paro cardiorrespiratorio (RCP); anafilaxia; broncoespasmo severo; hipotensión refractaria',
   'Taquicardia y arritmias ventriculares; hipertensión; isquemia miocárdica; temblor; hiperglucemia',
   'Taquiarritmias; no usar junto con anestésicos halogenados (sensibilización miocárdica a catecolaminas); hipertiroidismo',
   'Dosis IV de RCP: 0.01 mg/kg es la dosis baja recomendada (evita efectos adversos); repetir cada 3-5 min si es necesario. Diluir la ampolla 1:1000 para bolos precisos en animales pequeños.',
   'Plumb''s Veterinary Drug Handbook; RECOVER CPR Guidelines', 'https://www.msdvetmanual.com', NULL, NULL),

  ('Norepinefrina', 'Norepinefrina (noradrenalina)', 'Cardiovascular / Vasopresor', 'Inyectable (ampolla)',
   '1 mg/mL (bitartrato)', NULL,
   'Infusión IV continua: 0.05-2 mcg/kg/min, titular según respuesta hemodinámica',
   NULL, NULL, 'Intravenosa (infusión)', ARRAY['Perro','Gato'], 'critico', true,
   'Shock vasodilatador (séptico, distributivo); hipotensión refractaria a fluidos; hipotensión intraoperatoria',
   'Vasoconstricción periférica e isquemia; bradicardia refleja; arritmias; necrosis por extravasación',
   'Hipovolemia no corregida (corregir volumen primero); trombosis vascular periférica; hipersensibilidad a sulfitos',
   'Administrar SIEMPRE por vía central o vena de buen calibre por riesgo de necrosis por extravasación. No es un bolo: requiere bomba de infusión. Dosis mcg/kg/min, no mg/kg.',
   'Plumb''s Veterinary Drug Handbook; MSD Veterinary Manual', 'https://www.msdvetmanual.com', NULL, NULL),

  ('Etamsilato', 'Etamsilato', 'Hemostáticos / Coagulación', 'Inyectable (marca Hemodrag)',
   '12.5% (125 mg/mL)', 125,
   '5-12.5 mg/kg IV o IM cada 6-8 h según necesidad',
   5, 12.5, 'Intravenosa / Intramuscular', ARRAY['Perro','Gato','Equino','Bovino'], 'precaucion', true,
   'Hemorragias capilares; profilaxis de sangrado quirúrgico; epistaxis; hemorragia gastrointestinal leve; menorragia',
   'Náusea; cefalea; hipotensión transitoria si la inyección IV es rápida; rash cutáneo',
   'Hipersensibilidad al etamsilato; porfiria; evitar en pacientes con trombosis activa',
   'Comercializado como Hemodrag (125 mg/mL). Angioprotector y hemostático: reduce tiempo de sangrado sin efecto sobre la coagulación sistémica. No reemplaza la corrección de la causa del sangrado.',
   'Plumb''s Veterinary Drug Handbook; ficha de producto Hemodrag', 'https://www.msdvetmanual.com', NULL, NULL),

  ('Mastilac', 'Marca comercial (3 presentaciones)', 'Antibióticos / Antimastíticos', 'Jeringa intramamaria / frasco inyectable',
   'Ver selector de presentaciones', NULL,
   'Depende de la presentación (ver opciones en la ficha)',
   NULL, NULL, 'Intramamaria / Subcutánea / Intramuscular', ARRAY['Bovino','Perro','Gato'], 'precaucion', true,
   'Mastitis bovina (aguda y subclínica); terapia de secado; infecciones de piel/tejidos blandos e urinarias (presentación inyectable)',
   'Irritación local en el sitio de aplicación; reacciones de hipersensibilidad; alteración de la flora (antibióticos)',
   'Hipersensibilidad a penicilinas/aminoglucósidos; no usar intramamario en vacas en lactancia con leche destinada a consumo sin respetar el tiempo de retiro',
   'Marca con 3 presentaciones distintas. Usar el selector de presentaciones en la ficha para ver composición, concentración y dosis de cada una. Respetar tiempos de retiro en bovinos de producción.',
   'Fichas de producto Mastilac (Laboratorios Callbest / Zoetis / Veterland); SENASA SIMEV', 'https://www.zoetis.cl', NULL,
   '[{"etiqueta":"Intramamario (mastitis)","presentacion":"Jeringa intramamaria 10 mL","concentracion":"Lincomicina 200 mg + Neomicina 500 mg + Betametasona 4 mg / 10 mL","concentracion_mg_ml":null,"dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"dosis_texto":"1 jeringa por cuarto afectado cada 12-24 h (mastitis aguda/subclinica)"},
    {"etiqueta":"Inyectable (amoxicilina/clavulanato)","presentacion":"Frasco ampolla","concentracion":"Amoxicilina 140 mg + Acido clavulanico 35 mg / mL","concentracion_mg_ml":140,"dosis_min_mg_kg":8.75,"dosis_max_mg_kg":8.75,"dosis_texto":"8.75 mg/kg cada 24 h SC/IM (perros y gatos)"},
    {"etiqueta":"Secado (ampicilina/cloxacilina)","presentacion":"Jeringa intramamaria 10 mL","concentracion":"Ampicilina 350 mg + Cloxacilina 700 mg / 10 mL","concentracion_mg_ml":null,"dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"dosis_texto":"1 jeringa por cuarto al momento del secado"}]'::jsonb);

-- Presentaciones alternativas (casos 5% / 10%) para el selector de la ficha
UPDATE public.medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg/mL (5%)","presentacion":"Frasco ampolla","concentracion":"50 mg/mL","concentracion_mg_ml":50,"dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"dosis_texto":"Presentacion diluida; ajustar volumen segun dosis en mg/kg"},
                     {"etiqueta":"100 mg/mL (10%)","presentacion":"Frasco ampolla","concentracion":"100 mg/mL","concentracion_mg_ml":100,"dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"dosis_texto":"Presentacion concentrada; ajustar volumen segun dosis en mg/kg"}]'::jsonb,
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 100)
WHERE nombre = 'Ketamina (anestesia)';

UPDATE public.medicamentos SET
  presentaciones = '[{"etiqueta":"1% (10 mg/mL)","presentacion":"Frasco ampolla","concentracion":"10 mg/mL","concentracion_mg_ml":10,"dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"dosis_texto":"Usar para volumenes mayores o dosis bajas"},
                     {"etiqueta":"2% (20 mg/mL)","presentacion":"Frasco ampolla","concentracion":"20 mg/mL","concentracion_mg_ml":20,"dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"dosis_texto":"Presentacion mas concentrada; menos volumen"}]'::jsonb,
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 20)
WHERE nombre = 'Lidocaína (infiltración)';
