-- Consolidación de anestesiología: eliminar duplicados genéricos antiguos
-- Se conservan las fichas completas (new anestesiologia_completa.sql) con indicaciones,
-- efectos secundarios, contraindicaciones, notas y fuentes verificables.
-- Octubre 2026

BEGIN;

-- Alfaxalona (viejo sedante, info genérica) -> se conserva Alfaxalona (IV) completo
DELETE FROM medicamentos WHERE id = 'bb7d0288-2a24-49df-b791-f707b23781b5';

-- Bupivacaína (2 filas viejas, info parcial) -> se conserva Bupivacaína (regional) completo
DELETE FROM medicamentos WHERE id IN ('b990ebd3-e8bd-4cc2-9c3f-9adc4ed2c92b','752dae9c-e930-49ad-bea1-86b5959947f3');

-- Lidocaína local (viejo, parcial) -> se conserva Lidocaína (infiltración) completo;
--    Lidocaína (Cardiovasculares/arritmias) se conserva (uso antiarrítmico distinto)
DELETE FROM medicamentos WHERE id = '4134ac84-146d-441d-ae17-9fab12208df9';

-- Naloxona (2 filas viejas, info genérica) -> se conserva Naloxona (anestesia) completo
DELETE FROM medicamentos WHERE id IN ('e682fc24-d83d-4d9b-b8ec-7ca2abb95b89','61b09e1f-6880-41da-a76f-0bf777602059');

-- Ketamina 10% (viejo, info parcial) -> se conservan Ketamina (anestesia) y (baja)
DELETE FROM medicamentos WHERE id = '613d8a7b-8e62-4515-976d-8c18bc939649';

-- Butorfanol (viejo, parcial) -> se conserva Butorfanol (analgesia) completo
DELETE FROM medicamentos WHERE id = '89d5160c-0207-45de-82b9-565bf53c45fb';

-- Ropivacaína (vieja, parcial) -> se conserva Ropivacaína (regional) completo
DELETE FROM medicamentos WHERE id = 'd17f1b6c-a895-41d6-a926-85fca46ccad1';

-- Metadona (vieja, parcial) -> se conservan Metadona (analgesia) y (oral)
DELETE FROM medicamentos WHERE id = '684f3d8a-22ca-46d2-a44a-748b6f6fc1e8';

-- Corregir especies_permitidas de Isoflurano (espacio en blanco ' Bovino')
UPDATE medicamentos
  SET especies_permitidas = ARRAY['Perro','Gato','Equino','Bovino']
WHERE nombre = 'Isoflurano';

COMMIT;