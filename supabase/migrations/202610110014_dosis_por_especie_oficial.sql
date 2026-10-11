-- ============================================================================
-- Migración 202610110014: Dosis por especie oficiales (Plumb's, Merck, VMD, FDA)
-- Cubre 226 fármacos con rangos de dosis por especie, permitidas y contraindicadas.
-- ============================================================================

BEGIN;

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.02,0.1],"Gato":[0.02,0.1],"Caballo":[0.05,0.1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo','Vaca'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Acepromazina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,5],"Gato":[2,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Alfaxalona (IV)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.001,0.005],"Gato":[0.001,0.005],"Caballo":[0.0025,0.005]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Dexmedetomidina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,2],"Gato":[0.2,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Diazepam';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,15],"Caballo":[2.2,2.2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ketamina (anestesia)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ketamina (baja)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.001,0.005],"Gato":[0.001,0.005],"Caballo":[0.0025,0.005]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Medetomidina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.4],"Gato":[0.1,0.4]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Midazolam';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[4,6],"Gato":[2,4]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Propofol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[4,8],"Gato":[4,8]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Tiletamina + Zolazepam (Telazol)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[8,12],"Gato":[8,12]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Tiopental';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[0.5,1],"Caballo":[0.5,1],"Vaca":[0.02,0.05]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo','Vaca'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Xilacina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.2,0.5],"Gato":[0.2,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Atracurio';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.2],"Gato":[0.1,0.2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Cisatracurio';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.3,0.6],"Gato":[0.3,0.6]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Rocuronio';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.3,1],"Gato":[0.3,1],"Caballo":[0.02,0.05]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Succinilcolina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,4],"Gato":[2,4]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Bupivacaína (regional)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,4],"Gato":[2,4]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Levobupivacaína';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[4,6],"Gato":[4,6]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Lidocaína';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,4],"Gato":[2,4]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Mepivacaína';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,4],"Gato":[2,4]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ropivacaína (regional)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Tetracaína';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.02,0.04],"Gato":[0.02,0.04]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Neostigmina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.005,0.02],"Gato":[0.005,0.02]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Alfentanilo';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.2,0.4],"Gato":[0.2,0.4],"Caballo":[0.01,0.05]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Butorfanol (analgesia)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.002,0.005],"Gato":[0.002,0.005]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fentanilo (inyectable)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.05,0.1],"Gato":[0.05,0.1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Hidromorfona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.5],"Gato":[0.1,0.25]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Metadona (analgesia)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.2,0.5],"Gato":[0.1,0.25]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Metadona oral';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.2],"Gato":[0.1,0.2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Oxicodona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.05,0.1],"Gato":[0.05,0.1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Oximorfona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.001,0.003],"Gato":[0.001,0.003]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Remifentanilo';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,4]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Tapentadol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,5],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Tramadol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2.2,4.4]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Carprofeno';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Cimicoxib';

UPDATE medicamentos SET
  dosis_por_especie = '{}'::jsonb,
  especies_permitidas = ARRAY[]::text[],
  especies_contraindicadas = ARRAY['Perro','Gato']
WHERE nombre ILIKE 'Ibuprofeno';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ketoprofeno';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Ketoprofeno oral';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Mavacoxib';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.2],"Gato":[0.2,0.3]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Meloxicam inyectable';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2.5,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Naproxeno';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.3,0.3]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Piroxicam';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.4,0.4]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Tenoxicam';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Tepoxalina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,0.5],"Gato":[1,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Vedaprofeno';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[3,5],"Gato":[3,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Amantadina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Amitriptilina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,25],"Gato":[10,25]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Aspirina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.01,0.03],"Gato":[0.01,0.03]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Buprenorfina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Codeína';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Deracoxib';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[25,40],"Gato":[25,40]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Dipirona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.002,0.004],"Gato":[0.002,0.004]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fentanilo (parche)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Firocoxib';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Flunixin Meglumina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20],"Gato":[10,20]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Gabapentina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Grapiprant';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.2],"Gato":[0.05,0.1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Meloxicam';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Morfina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,15]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Paracetamol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[4,6],"Gato":[4,6]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Pregabalina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Robenacoxib';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Duloxetina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Venlafaxina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Amikacina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[11,22],"Gato":[11,15],"Vaca":[6.6,11],"Cerdo":[6.6,11]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Vaca','Cerdo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Amoxicilina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Azitromicina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[22,30],"Gato":[22,30]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Cefadroxila';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20],"Gato":[10,20]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Cefazolina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[8,8],"Gato":[8,8]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Cefovecina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Cefpodoxima';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2.2,2.2],"Vaca":[1.1,2.2],"Caballo":[1.1,2.2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Vaca','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ceftiofur';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,15],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ciprofloxacina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Clindamicina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[25,50],"Gato":[25,50]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Cloranfenicol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Enrofloxacina 10%';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[3,5],"Gato":[3,5],"Vaca":[2.2,4.4]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Vaca'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Gentamicina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2.75,5.5],"Gato":[2.75,5.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Marbofloxacina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,25],"Gato":[10,15]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Metronidazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,5],"Gato":[2,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Nitrofurantoína';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2.5,5],"Gato":[2.5,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ofloxacina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2.5,7.5],"Gato":[2.5,7.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Orbifloxacina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[3,6],"Gato":[3,6]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Pradofloxacina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10],"Caballo":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Rifampicina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[25,50],"Gato":[25,50],"Vaca":[25,50]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Vaca'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Sulfadimetoxina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[15,30],"Gato":[15,30]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Sulfametoxazol + Trimetoprima';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[3,5],"Gato":[3,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Tobramicina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20],"Cerdo":[10,20]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Cerdo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Tylosina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.25,0.5],"Gato":[0.25,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Anfotericina B';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fluconazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[25,50],"Gato":[25,50]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Griseofulvina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Itraconazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ketoconazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[20,40],"Gato":[20,40]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Terbinafina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,5],"Gato":[2,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Voriconazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Cetirizina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,5],"Gato":[7,7]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ciclosporina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.3],"Gato":[0.1,0.3]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Dexametasona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,4],"Gato":[2,4]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Diphenhydramina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,2],"Gato":[0.5,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Hidroxizina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,3]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Lokivetmab';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.5],"Gato":[0.1,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Loratadina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,2],"Gato":[0.5,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Metilprednisolona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.4,0.6]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Oclacitinib';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,2],"Gato":[0.5,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Prednisona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,2],"Gato":[0.5,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Prednisolona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.5],"Gato":[0.1,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Triamcinolona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2.5,6.8]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Afoxolaner';

UPDATE medicamentos SET
  dosis_por_especie = '{}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Amitraz';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[3,6]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Diethylcarbamaza';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1.5,2.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Espinosad';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Febantel';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[50,50],"Gato":[50,50]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fenbendazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[6,12],"Gato":[6,12]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fipronil';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[25,56]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fluralaner';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.006,0.012],"Gato":[0.024,0.024]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ivermectina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,10],"Gato":[10,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Imidacloprid';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[20,43]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Lotilaner';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20],"Gato":[10,20]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Mebendazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[2,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Milbemicina Oxima';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Miltefosina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.0025,0.005],"Gato":[0.001,0.002]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Moxidectina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1.3,2.2],"Gato":[0.9,1.4]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Nitenpiram';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10],"Caballo":[10,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Oxfendazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10],"Caballo":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Oxibendazol';

UPDATE medicamentos SET
  dosis_por_especie = '{}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Permetrina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Pirantel Pamoato';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Praziquantel';

UPDATE medicamentos SET
  dosis_por_especie = '{"Caballo":[5,5],"Perro":[20,50],"Gato":[20,50]}'::jsonb,
  especies_permitidas = ARRAY['Caballo','Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ponazuril';

UPDATE medicamentos SET
  dosis_por_especie = '{"Gato":[30,60],"Perro":[30,60]}'::jsonb,
  especies_permitidas = ARRAY['Gato','Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ronidazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,4]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Sarolaner';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[6,12],"Gato":[6,12]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Selamectina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20],"Gato":[10,20],"Caballo":[5,15]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Toltrazuril';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,15],"Gato":[8,12]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Carboplatino';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,15],"Gato":[5,15]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ciclofosfamida';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Doxorubicina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1.5,2.5],"Gato":[1.5,2.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Lomustina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[12.5,12.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Masitinib';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2.75,2.75]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Toceranib';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,0.75],"Gato":[0.5,0.75]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Vincristina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20],"Gato":[10,20]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Aciclovir';

UPDATE medicamentos SET
  dosis_por_especie = '{"Gato":[40,90],"Perro":[20,40]}'::jsonb,
  especies_permitidas = ARRAY['Gato','Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Famciclovir';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[70,140],"Gato":[70,140]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Acetilcisteína';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,5],"Gato":[1,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Carbón activado';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.01,0.02],"Gato":[0.01,0.02]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Flumazenil';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.01,0.04],"Gato":[0.01,0.04]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Naloxona (anestesia)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.05,0.1],"Gato":[0.05,0.1],"Caballo":[0.075,0.075]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Yohimbina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.02,0.04],"Gato":[0.02,0.04],"Caballo":[0.01,0.02]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Atropina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.005,0.01],"Gato":[0.005,0.01]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Glicopirrolato';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[15,40]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Bromuro de potasio';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,5],"Gato":[2,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fenobarbital';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[20,30],"Gato":[20,30]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Levetiracetam';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.3],"Gato":[0.625,1.25]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Amlodipino';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Atenolol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.25,0.5],"Gato":[0.25,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Benazepril';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Captopril';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.2],"Gato":[0.1,0.2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Carvedilol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,3],"Gato":[3,4]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Clopidogrel';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.005,0.01],"Gato":[0.005,0.01]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Digoxina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[1.5,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Diltiazem';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.25,0.5],"Gato":[0.25,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Enalapril';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Espironolactona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Hidralazina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Hidroclorotiazida';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Losartán';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.2,1],"Gato":[0.2,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Metoprolol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.25,0.5],"Gato":[0.25,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Pimobendán';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Propranolol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.125,0.25],"Gato":[0.125,0.25]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ramipril';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Sildenafilo';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Sotalol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Tadalafilo';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Telmisartán';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.2],"Gato":[0.1,0.2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Torsemida';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.01,0.02],"Gato":[0.01,0.02]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Epinefrina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.001,0.01],"Gato":[0.001,0.01]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Norepinefrina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20],"Gato":[10,20]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Alopurinol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.005,0.01],"Gato":[0.005,0.01]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Cabergolina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.001,0.002],"Gato":[0.001,0.002]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Desmopresina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.15,0.2]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Desoxicorticosterona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fenilpropanolamina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.01,0.02],"Gato":[0.01,0.02]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fludrocortisona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.01,0.02],"Gato":[0.015,0.03]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Levotiroxina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Metimazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[25,50]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Mitotano';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,5],"Gato":[2,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Trilostano';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[3,5],"Gato":[3,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Cimetidina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.5],"Gato":[0.1,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Cisaprida';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.2,0.5],"Gato":[0.2,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Domperidona';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Famotidina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.2]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Loperamida';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Maropitant';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.2,0.5],"Gato":[0.2,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Metoclopramida';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[2,3],"Gato":[2,3]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Misoprostol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Omeprazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.5],"Gato":[0.1,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ondansetrón';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Pantoprazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Rabeprazol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20],"Gato":[10,20]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'SAMe';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.25,1],"Gato":[0.25,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Sucralfato';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Ursodiol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[5,10],"Gato":[5,10]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Etamsilato';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.02,0.1],"Gato":[0.02,0.1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Salbutamol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[4,6],"Gato":[4,6]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Teofilina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.3,0.6],"Gato":[0.3,0.6]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Terbutalina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.005,0.05],"Gato":[0.005,0.05],"Caballo":[0.005,0.05]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato','Caballo'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Atipamezol';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.2,0.5],"Gato":[0.2,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fenoxibenzamina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.1,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Finasterida';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Prazosina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.004,0.01],"Gato":[0.004,0.01]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Tamsulosina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Coenzima Q10';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20],"Gato":[10,20]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Condroitina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,20],"Gato":[10,20]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Glucosamina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[25,50]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'L-Carnitina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[10,40],"Gato":[10,40]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Omega-3 (EPA/DHA)';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,2],"Gato":[1,2]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Silymarina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.2,0.5],"Gato":[0.2,0.5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Taurina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Vitamina B Complex';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.005,0.01],"Gato":[0.005,0.01]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Vitamina B12';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[1,5],"Gato":[1,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Vitamina K1';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.02,0.1],"Gato":[0.02,0.1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Alprazolam';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,2],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Clomipramina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,2],"Gato":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Fluoxetina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[0.5,1]}'::jsonb,
  especies_permitidas = ARRAY['Perro'],
  especies_contraindicadas = ARRAY['Gato']
WHERE nombre ILIKE 'Selegilina';

UPDATE medicamentos SET
  dosis_por_especie = '{"Perro":[3,7],"Gato":[2,5]}'::jsonb,
  especies_permitidas = ARRAY['Perro','Gato'],
  especies_contraindicadas = ARRAY[]::text[]
WHERE nombre ILIKE 'Trazodona';

COMMIT;
