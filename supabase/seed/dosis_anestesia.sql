-- Llenar dosis mín/máx para los de anestesiología según las descripciones string cargadas

BEGIN;

UPDATE medicamentos SET dosis_minima_mg_kg = 2.0, dosis_maxima_mg_kg = 6.0 WHERE nombre = 'Propofol';
UPDATE medicamentos SET dosis_minima_mg_kg = 1.0, dosis_maxima_mg_kg = 5.0 WHERE nombre = 'Alfaxalona (IV)';
UPDATE medicamentos SET dosis_minima_mg_kg = 2.0, dosis_maxima_mg_kg = 5.0 WHERE nombre = 'Ketamina (anestesia)';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.5, dosis_maxima_mg_kg = 2.0 WHERE nombre = 'Ketamina (baja)';
UPDATE medicamentos SET dosis_minima_mg_kg = 2.0, dosis_maxima_mg_kg = 4.0 WHERE nombre = 'Tiletamina + Zolazepam (Telazol)';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.5, dosis_maxima_mg_kg = 1.0 WHERE nombre = 'Xilacina';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.05, dosis_maxima_mg_kg = 0.2 WHERE nombre = 'Atipamezol';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.02, dosis_maxima_mg_kg = 0.04 WHERE nombre = 'Atropina';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.005, dosis_maxima_mg_kg = 0.01 WHERE nombre = 'Glicopirrolato';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.1, dosis_maxima_mg_kg = 0.5 WHERE nombre = 'Metadona (analgesia)';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.05, dosis_maxima_mg_kg = 0.1 WHERE nombre = 'Oximorfona';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.1, dosis_maxima_mg_kg = 0.4 WHERE nombre = 'Butorfanol (analgesia)';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.1, dosis_maxima_mg_kg = 0.5 WHERE nombre = 'Atracurio';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.4, dosis_maxima_mg_kg = 0.6 WHERE nombre = 'Rocuronio';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.01, dosis_maxima_mg_kg = 0.05 WHERE nombre = 'Neostigmina';
UPDATE medicamentos SET dosis_minima_mg_kg = 2.0, dosis_maxima_mg_kg = 4.0 WHERE nombre = 'Lidocaína (infiltración)';
UPDATE medicamentos SET dosis_minima_mg_kg = 1.0, dosis_maxima_mg_kg = 2.0 WHERE nombre = 'Bupivacaína (regional)';
UPDATE medicamentos SET dosis_minima_mg_kg = 1.0, dosis_maxima_mg_kg = 2.0 WHERE nombre = 'Ropivacaína (regional)';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.02, dosis_maxima_mg_kg = 0.04 WHERE nombre = 'Naloxona (anestesia)';
UPDATE medicamentos SET dosis_minima_mg_kg = 0.1, dosis_maxima_mg_kg = 0.1 WHERE nombre = 'Yohimbina';

COMMIT;
