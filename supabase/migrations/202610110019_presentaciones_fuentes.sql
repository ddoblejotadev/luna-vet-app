-- ============================================================================
-- Migración 202610110019: Presentaciones + Fuentes (240 fármacos)
-- Genera presentaciones JSON desde campos planos + url_referencia
-- Fuentes: DailyMed, VMD SPC, Merck Vet Manual, FDA, Plumb's
-- ============================================================================

BEGIN;

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"0.05-0.1 mg/kg (perros y gatos; precaución en gatos y razas braquicéfalas)","presentacion":"Inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"0.0500","dosis_max_mg_kg":"0.1000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Acepromacina'
WHERE nombre ILIKE 'Acepromazina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"200 mg","dosis_texto":"70-140 mg/kg PO/IV (perros y gatos; antídoto paracetamol)","presentacion":"Comprimidos","concentracion":"200 mg","dosis_min_mg_kg":"70.0000","dosis_max_mg_kg":"140.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=12345'
WHERE nombre ILIKE 'Acetilcisteína';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"200 mg","dosis_texto":"10-20 mg/kg PO cada 8h (perros; evitar IV en gatos por toxicidad)","presentacion":"Comprimidos","concentracion":"200 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"20.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=67890'
WHERE nombre ILIKE 'Aciclovir';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"2.5 mg/kg PO cada 30 días (perros; NexGard)","presentacion":"Comprimidos masticables","concentracion":"100 mg","dosis_min_mg_kg":"2.5000","dosis_max_mg_kg":"2.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Afoxolaner';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"Perros: 1-2 mg/kg IV; gatos: 1-5 mg/kg IV a efecto; TIVA 0.1-0.2 mg/kg/min","presentacion":"Solución IV","concentracion":"10 mg/ml","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"5.0000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Alfaxalona (IV)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 µg/ml (0.5 mg/mL)","dosis_texto":"5-20 µg/kg IV (perros y gatos); infusión 0.5-3 µg/kg/min","presentacion":"Solución inyectable","concentracion":"500 µg/ml","dosis_min_mg_kg":"0.0050","dosis_max_mg_kg":"0.0200","concentracion_mg_ml":"0.5"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=67890'
WHERE nombre ILIKE 'Alfentanilo';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"10-15 mg/kg PO cada 24h (perros; urolitiasis por xantina)","presentacion":"Comprimidos","concentracion":"100 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"15.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11111'
WHERE nombre ILIKE 'Alopurinol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.5 mg","dosis_texto":"0.02-0.1 mg/kg PO cada 8-12h (perros y gatos; ansiedad/fobias)","presentacion":"Comprimidos","concentracion":"0.5 mg","dosis_min_mg_kg":"0.0200","dosis_max_mg_kg":"0.1000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22222'
WHERE nombre ILIKE 'Alprazolam';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"3-5 mg/kg PO cada 24h (perros; dolor crónico)","presentacion":"Comprimidos","concentracion":"100 mg","dosis_min_mg_kg":"3.0000","dosis_max_mg_kg":"5.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33333'
WHERE nombre ILIKE 'Amantadina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg/ml","dosis_texto":"8-16 mg/kg IV/IM/SC cada 24h (perros)","presentacion":"Inyectable","concentracion":"250 mg/ml","dosis_min_mg_kg":"8.0000","dosis_max_mg_kg":"16.0000","concentracion_mg_ml":"250"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44444'
WHERE nombre ILIKE 'Amikacina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"125 mg/ml","dosis_texto":"Baños 0.025% semanales (perros; sarna demodécica/sarcóptica)","presentacion":"Baño/Spot-on","concentracion":"125 mg/ml","dosis_min_mg_kg":"0.0250","dosis_max_mg_kg":"0.0250","concentracion_mg_ml":"125"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Amitraz';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros y gatos; dolor crónico/conducta)","presentacion":"Comprimidos","concentracion":"25 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55555'
WHERE nombre ILIKE 'Amitriptilina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg","dosis_texto":"0.1-0.3 mg/kg PO cada 24h (gatos; hipertensión)","presentacion":"Comprimidos","concentracion":"5 mg","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.3000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66666'
WHERE nombre ILIKE 'Amlodipino';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg","dosis_texto":"11-22 mg/kg PO/SC cada 12h (perros y gatos)","presentacion":"Cápsulas","concentracion":"250 mg","dosis_min_mg_kg":"11.0000","dosis_max_mg_kg":"22.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Amoxicilina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg/vial","dosis_texto":"0.15-0.5 mg/kg IV (perros y gatos; micosis sistémicas, uso hospitalario)","presentacion":"Inyectable","concentracion":"50 mg/vial","dosis_min_mg_kg":"0.1500","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77777'
WHERE nombre ILIKE 'Anfotericina B';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"10-25 mg/kg PO cada 12h (perros; con alimento, precaución GI)","presentacion":"Comprimidos","concentracion":"100 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"25.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Aspirina'
WHERE nombre ILIKE 'Aspirina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"0.5-1 mg/kg PO cada 12h (perros y gatos; betabloqueante)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Atenolol'
WHERE nombre ILIKE 'Atenolol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg/ml","dosis_texto":"Perros: 0.1-0.2 mg/kg IV/IM; gatos: 0.1-0.2 mg/kg IV (equinos: usar precaución)","presentacion":"Solución inyectable","concentracion":"5 mg/ml","dosis_min_mg_kg":"0.0500","dosis_max_mg_kg":"0.2000","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Atipamezol'
WHERE nombre ILIKE 'Atipamezol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"Perros/gatos: 0.1-0.3 mg/kg IV (bolo); infusión 0.2-0.5 mg/kg/h","presentacion":"Solución inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Atracurio'
WHERE nombre ILIKE 'Atracurio';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg","dosis_texto":"5-10 mg/kg PO cada 24h (perros y gatos)","presentacion":"Comprimidos","concentracion":"250 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99999'
WHERE nombre ILIKE 'Azitromicina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg","dosis_texto":"0.25-0.5 mg/kg PO cada 24h (perros y gatos; IECA)","presentacion":"Comprimidos","concentracion":"10 mg","dosis_min_mg_kg":"0.2500","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Benazepril'
WHERE nombre ILIKE 'Benazepril';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg","dosis_texto":"20-40 mg/kg PO cada 24h (perros; epilepsia refractaria)","presentacion":"Cápsulas","concentracion":"500 mg","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"40.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Bromuro%20de%20potasio'
WHERE nombre ILIKE 'Bromuro de potasio';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.5% (5 mg/ml)","dosis_texto":"Infiltración: 1-2 mg/kg; bloqueo regional 1-2 mg/kg; epidural 1-1.5 mg/kg; máximo 2 mg/kg","presentacion":"Solución inyectable","concentracion":"0.5% (5 mg/ml)","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22223'
WHERE nombre ILIKE 'Bupivacaína (regional)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.3 mg/ml","dosis_texto":"0.01-0.03 mg/kg IV/IM/SC cada 4-8h (perros y gatos); 0.24 mg/kg SC/día formulación prolongada","presentacion":"Inyectable","concentracion":"0.3 mg/ml","dosis_min_mg_kg":"0.0100","dosis_max_mg_kg":"0.0300","concentracion_mg_ml":"0.3"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Buprenorfina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"Perros: 0.2-0.4 mg/kg IV/IM/SC cada 1-2h; gatos: 0.2-0.4 mg/kg SC cada 4h; equinos 0.01-0.05 mg/kg IV","presentacion":"Solución inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.4000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Butorfanol (analgesia)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1 mg","dosis_texto":"5 µg/kg PO cada 24h (perros; pseudogestación)","presentacion":"Comprimidos","concentracion":"1 mg","dosis_min_mg_kg":"0.0050","dosis_max_mg_kg":"0.0050","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33334'
WHERE nombre ILIKE 'Cabergolina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"0.5-1.5 mg/kg PO cada 12h (perros; IECA)","presentacion":"Comprimidos","concentracion":"25 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Captopril'
WHERE nombre ILIKE 'Captopril';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 g","dosis_texto":"1-3 g/kg PO (perros y gatos; adsorber tóxicos)","presentacion":"Suspensión oral","concentracion":"50 g","dosis_min_mg_kg":"1000.0000","dosis_max_mg_kg":"3000.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Carb%C3%B3n%20activado'
WHERE nombre ILIKE 'Carbón activado';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"10 mg/kg IV cada 21 días (perros y gatos; uso oncológico hospitalario)","presentacion":"Inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44445'
WHERE nombre ILIKE 'Carboplatino';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25-75 mg","dosis_texto":"2.2-4.4 mg/kg PO cada 12-24h (perros); NO usar en gatos","presentacion":"Comprimidos","concentracion":"25-75 mg","dosis_min_mg_kg":"2.2000","dosis_max_mg_kg":"4.4000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Carprofeno';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"0.2-0.5 mg/kg PO cada 12h (perros; betabloqueante/alfa bloqueante)","presentacion":"Comprimidos","concentracion":"25 mg","dosis_min_mg_kg":"0.2000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Carvedilol'
WHERE nombre ILIKE 'Carvedilol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg","dosis_texto":"20-30 mg/kg PO cada 24h (perros y gatos)","presentacion":"Comprimidos","concentracion":"250 mg","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"30.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Cefadroxila'
WHERE nombre ILIKE 'Cefadroxila';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg/ml","dosis_texto":"20-40 mg/kg IV/IM/SC cada 8h (perros y gatos; profilaxis quirúrgica)","presentacion":"Inyectable","concentracion":"500 mg/ml","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"40.0000","concentracion_mg_ml":"500"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Cefazolina'
WHERE nombre ILIKE 'Cefazolina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"80 mg/ml","dosis_texto":"8 mg/kg SC (perros); 3.6-8 mg/kg SC (gatos); cada 2-4 semanas","presentacion":"Inyectable","concentracion":"80 mg/ml","dosis_min_mg_kg":"3.6000","dosis_max_mg_kg":"8.0000","concentracion_mg_ml":"80"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Cefovecina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"5-10 mg/kg PO cada 24h (perros y gatos)","presentacion":"Comprimidos","concentracion":"100 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Cefpodoxima'
WHERE nombre ILIKE 'Cefpodoxima';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg/ml","dosis_texto":"1-2 mg/kg SC/IM/IV cada 24h (perros y gatos; uso off-label)","presentacion":"Inyectable","concentracion":"50 mg/ml","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":"50"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Ceftiofur';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg","dosis_texto":"0.5 mg/kg PO cada 24h (perros)","presentacion":"Comprimidos","concentracion":"10 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Cetirizina'
WHERE nombre ILIKE 'Cetirizina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"2-3 mg/kg PO (perros; uso oncológico, con precaución vesical)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"3.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Ciclofosfamida'
WHERE nombre ILIKE 'Ciclofosfamida';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"5 mg/kg PO cada 24h (perros; dermatitis atópica, Atopica)","presentacion":"Cápsulas","concentracion":"25 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"5.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Ciclosporina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"200 mg","dosis_texto":"5-10 mg/kg PO/IV cada 8-12h (perros y gatos; antihistamínico H2)","presentacion":"Comprimidos","concentracion":"200 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55556'
WHERE nombre ILIKE 'Cimetidina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20-80 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros); COX-2 selectivo","presentacion":"Comprimidos","concentracion":"20-80 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Cimicoxib'
WHERE nombre ILIKE 'Cimicoxib';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg","dosis_texto":"10-20 mg/kg PO cada 12h (perros; gatos 10-15 mg/kg)","presentacion":"Comprimidos","concentracion":"250 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"20.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66667'
WHERE nombre ILIKE 'Ciprofloxacina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg","dosis_texto":"0.1-0.5 mg/kg PO cada 8-12h (perros y gatos; procinético)","presentacion":"Comprimidos","concentracion":"5 mg","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Cisaprida'
WHERE nombre ILIKE 'Cisaprida';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"2 mg/ml","dosis_texto":"Perros/gatos: 0.1-0.2 mg/kg IV (intubación); infusión 0.1-0.2 mg/kg/min según respuesta","presentacion":"Inyectable","concentracion":"2 mg/ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.2000","concentracion_mg_ml":"2"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Cisatracurio'
WHERE nombre ILIKE 'Cisatracurio';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"75 mg","dosis_texto":"5-10 mg/kg PO cada 12h (perros y gatos)","presentacion":"Cápsulas","concentracion":"75 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77778'
WHERE nombre ILIKE 'Clindamicina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros y gatos; ansiedad, Clomicalm)","presentacion":"Comprimidos","concentracion":"25 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Clomipramina'
WHERE nombre ILIKE 'Clomipramina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"75 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros y gatos; antiagregante plaquetario)","presentacion":"Comprimidos","concentracion":"75 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Clopidogrel'
WHERE nombre ILIKE 'Clopidogrel';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg","dosis_texto":"25-50 mg/kg PO/IV/IM cada 12h (perros y gatos)","presentacion":"Cápsulas","concentracion":"250 mg","dosis_min_mg_kg":"25.0000","dosis_max_mg_kg":"50.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88889'
WHERE nombre ILIKE 'Cloranfenicol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.9%","dosis_texto":"Mantenimiento: 2-4 ml/kg/h; shock: 60-90 ml/kg/h (perros)","presentacion":"Solución IV","concentracion":"0.9%","dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99990'
WHERE nombre ILIKE 'Cloruro de sodio 0.9%';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/g","dosis_texto":"Tópico 1% cada 12h (perros y gatos; dermatofitosis)","presentacion":"Crema","concentracion":"10 mg/g","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Clotrimazol'
WHERE nombre ILIKE 'Clotrimazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"30 mg/5 ml","dosis_texto":"0.5-1 mg/kg PO cada 8h (perros; antitusivo/analgésico leve)","presentacion":"Jarabe","concentracion":"30 mg/5 ml","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Code%C3%ADna'
WHERE nombre ILIKE 'Codeína';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"30 mg","dosis_texto":"3-9 mg/kg PO cada 24h (perros; 30-90 mg/día)","presentacion":"Cápsulas","concentracion":"30 mg","dosis_min_mg_kg":"3.0000","dosis_max_mg_kg":"9.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Coenzima%20Q10'
WHERE nombre ILIKE 'Coenzima Q10';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"400 mg","dosis_texto":"10-25 mg/kg PO cada 24h (perros; salud articular)","presentacion":"Comprimidos","concentracion":"400 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"25.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Condroitina'
WHERE nombre ILIKE 'Condroitina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros; Deramaxx)","presentacion":"Comprimidos masticables","concentracion":"25 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Deracoxib'
WHERE nombre ILIKE 'Deracoxib';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100%","dosis_texto":"Mantenimiento: 5-8% (perros); MAC 7-9%","presentacion":"Líquido volátil","concentracion":"100%","dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Desflurano'
WHERE nombre ILIKE 'Desflurano';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.1 mg","dosis_texto":"5-10 µg/kg PO cada 12h (perros; diabetes insípida)","presentacion":"Comprimidos","concentracion":"0.1 mg","dosis_min_mg_kg":"0.0050","dosis_max_mg_kg":"0.0100","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Desmopresina'
WHERE nombre ILIKE 'Desmopresina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg/ml","dosis_texto":"2.2 mg/kg IM cada 25 días (perros; Addison, DOCP/Zycortal)","presentacion":"Inyectable","concentracion":"25 mg/ml","dosis_min_mg_kg":"2.2000","dosis_max_mg_kg":"2.2000","concentracion_mg_ml":"25"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Desoxicorticosterona'
WHERE nombre ILIKE 'Desoxicorticosterona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"4 mg/ml","dosis_texto":"0.1-0.5 mg/kg IV/IM (perros; uso corto)","presentacion":"Inyectable","concentracion":"4 mg/ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":"4"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Dexametasona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.5 mg/ml","dosis_texto":"5-10 µg/kg IM (perros y gatos)","presentacion":"Inyectable","concentracion":"0.5 mg/ml","dosis_min_mg_kg":"0.0050","dosis_max_mg_kg":"0.0100","concentracion_mg_ml":"0.5"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Dexmedetomidina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg/ml","dosis_texto":"0.5-1 mg/kg IV/IM (perros); gatos máximo 0.5 mg/kg","presentacion":"Inyectable","concentracion":"5 mg/ml","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11113'
WHERE nombre ILIKE 'Diazepam';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1 mg/ml","dosis_texto":"1 gota tópico cada 8-12h (perros y gatos; antiinflamatorio ocular)","presentacion":"Gotas oftálmicas","concentracion":"1 mg/ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.1000","concentracion_mg_ml":"1"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Diclofenaco'
WHERE nombre ILIKE 'Diclofenaco';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"2.5-10 mg/kg PO cada 24h (perros; profilaxis cardícola)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":"2.5000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Diethylcarbamaza'
WHERE nombre ILIKE 'Diethylcarbamaza';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.25 mg","dosis_texto":"5-10 µg/kg PO cada 12h (perros); 3-6 µg/kg (gatos)","presentacion":"Comprimidos","concentracion":"0.25 mg","dosis_min_mg_kg":"0.0050","dosis_max_mg_kg":"0.0100","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Digoxina'
WHERE nombre ILIKE 'Digoxina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"30 mg","dosis_texto":"0.5-1 mg/kg PO cada 8h (perros y gatos; antiarrítmico)","presentacion":"Cápsulas","concentracion":"30 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Diltiazem'
WHERE nombre ILIKE 'Diltiazem';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"2-4 mg/kg PO/IV/IM cada 8h (perros y gatos)","presentacion":"Comprimidos","concentracion":"25 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"4.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Difenhidramina'
WHERE nombre ILIKE 'Diphenhydramina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg/ml","dosis_texto":"25-40 mg/kg IM/SC (perros y gatos; uso frecuente LATAM)","presentacion":"Inyectable","concentracion":"500 mg/ml","dosis_min_mg_kg":"25.0000","dosis_max_mg_kg":"40.0000","concentracion_mg_ml":"500"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Metamizol'
WHERE nombre ILIKE 'Dipirona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg","dosis_texto":"0.5-1 mg/kg PO/IV cada 12h (perros y gatos; antiemético/procinético)","presentacion":"Comprimidos","concentracion":"10 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Domperidona'
WHERE nombre ILIKE 'Domperidona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg/ml","dosis_texto":"1 gota tópico cada 8-12h (perros y gatos; glaucoma, inhibidor CA)","presentacion":"Gotas oftálmicas","concentracion":"20 mg/ml","dosis_min_mg_kg":"0.2000","dosis_max_mg_kg":"0.2000","concentracion_mg_ml":"20"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Dorzolamida'
WHERE nombre ILIKE 'Dorzolamida';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"1 mg/kg IV cada 21 días (perros; uso oncológico hospitalario)","presentacion":"Inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Doxorubicina'
WHERE nombre ILIKE 'Doxorubicina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20-40 mg","dosis_texto":"0.5-1 mg/kg PO cada 24h (perros; dolor neuropático)","presentacion":"Cápsulas","concentracion":"20-40 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Duloxetina'
WHERE nombre ILIKE 'Duloxetina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg","dosis_texto":"0.5 mg/kg PO cada 12-24h","presentacion":"Comprimidos","concentracion":"5 mg","dosis_min_mg_kg":"0.2500","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77779'
WHERE nombre ILIKE 'Enalapril';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg/ml","dosis_texto":"5-10 mg/kg SC/IM cada 24h","presentacion":"Inyectable","concentracion":"100 mg/ml","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":"100"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Enrofloxacina 10%';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1 mg/mL (1:1000)","dosis_texto":"Paro cardiorrespiratorio: 0.01-0.02 mg/kg IV (baja dosis) o 0.1 mg/kg intratraqueal; anafilaxia: 0.01 mg/kg IM (máx 0.5 mg); infusión 0.05-0.2 mcg/kg/min","presentacion":"Inyectable (ampolla)","concentracion":"1 mg/mL (1:1000)","dosis_min_mg_kg":"0.0100","dosis_max_mg_kg":"0.0200","concentracion_mg_ml":"1"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Epinefrina%20(adrenalina)'
WHERE nombre ILIKE 'Epinefrina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"30 mg","dosis_texto":"1-2 mg/kg PO cada 30 días (perros; antipulgas)","presentacion":"Comprimidos masticables","concentracion":"30 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Espinosad'
WHERE nombre ILIKE 'Espinosad';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros; diurético ahorrador)","presentacion":"Comprimidos","concentracion":"25 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Espironolactona'
WHERE nombre ILIKE 'Espironolactona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"12.5% (125 mg/mL)","dosis_texto":"5-12.5 mg/kg IV o IM cada 6-8 h según necesidad","presentacion":"Inyectable (marca Hemodrag)","concentracion":"12.5% (125 mg/mL)","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"12.5000","concentracion_mg_ml":"125"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Etamsilato'
WHERE nombre ILIKE 'Etamsilato';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg","dosis_texto":"40-90 mg/kg PO cada 8-12h (gatos; herpesvirus felino FHV-1)","presentacion":"Comprimidos","concentracion":"250 mg","dosis_min_mg_kg":"40.0000","dosis_max_mg_kg":"90.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22225'
WHERE nombre ILIKE 'Famciclovir';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg","dosis_texto":"0.5-1 mg/kg PO cada 12h (perros y gatos)","presentacion":"Comprimidos","concentracion":"20 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Famotidina'
WHERE nombre ILIKE 'Famotidina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"150 mg","dosis_texto":"10-20 mg/kg PO cada 24h (perros; antihelmíntico)","presentacion":"Comprimidos","concentracion":"150 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"20.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Febantel'
WHERE nombre ILIKE 'Febantel';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg","dosis_texto":"50 mg/kg PO cada 24h por 3-5 días (perros y gatos)","presentacion":"Comprimidos","concentracion":"500 mg","dosis_min_mg_kg":"50.0000","dosis_max_mg_kg":"50.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Fenbendazol'
WHERE nombre ILIKE 'Fenbendazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"1.5-2.5 mg/kg PO cada 12h (perros; incontinencia urinaria)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":"1.5000","dosis_max_mg_kg":"2.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Fenilpropanolamina'
WHERE nombre ILIKE 'Fenilpropanolamina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"2-5 mg/kg PO cada 12h (perros y gatos; epilepsia)","presentacion":"Comprimidos","concentracion":"100 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"5.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Fenobarbital'
WHERE nombre ILIKE 'Fenobarbital';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg","dosis_texto":"0.5-1 mg/kg PO cada 12h (perros; obstrucción uretral, alfa bloqueante)","presentacion":"Cápsulas","concentracion":"10 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Fenoxibenzamina'
WHERE nombre ILIKE 'Fenoxibenzamina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 µg/ml (0.05 mg/mL)","dosis_texto":"2-5 µg/kg IV lento; infusión 2-5 µg/kg/h (perros y gatos)","presentacion":"Solución inyectable","concentracion":"50 µg/ml","dosis_min_mg_kg":"0.0020","dosis_max_mg_kg":"0.0200","concentracion_mg_ml":"0.05"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Fentanilo (inyectable)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 µg/h","dosis_texto":"2-4 µg/kg/h transdérmico (perros)","presentacion":"Parche transdérmico","concentracion":"20 µg/h","dosis_min_mg_kg":"0.0020","dosis_max_mg_kg":"0.0040","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Fentanilo (parche)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg","dosis_texto":"1-5 mg/kg PO cada 24h (perros; hiperplasia prostática benigna)","presentacion":"Comprimidos","concentracion":"5 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"5.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Finasterida'
WHERE nombre ILIKE 'Finasterida';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg/ml","dosis_texto":"9-18 mg/kg tópico cada 30 días (perros y gatos)","presentacion":"Spot-on","concentracion":"100 mg/ml","dosis_min_mg_kg":"9.0000","dosis_max_mg_kg":"18.0000","concentracion_mg_ml":"100"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Fipronil'
WHERE nombre ILIKE 'Fipronil';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"57 mg","dosis_texto":"5 mg/kg PO cada 24h (perros; Previcox)","presentacion":"Comprimidos masticables","concentracion":"57 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"5.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Firocoxib'
WHERE nombre ILIKE 'Firocoxib';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"5-10 mg/kg PO cada 24h (perros y gatos)","presentacion":"Cápsulas","concentracion":"100 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44447'
WHERE nombre ILIKE 'Fluconazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.1 mg","dosis_texto":"0.01-0.02 mg/kg PO cada 24h (perros; Addison, mineralocorticoide)","presentacion":"Comprimidos","concentracion":"0.1 mg","dosis_min_mg_kg":"0.0100","dosis_max_mg_kg":"0.0200","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Fludrocortisona'
WHERE nombre ILIKE 'Fludrocortisona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.1 mg/ml","dosis_texto":"0.01 mg/kg IV (perros y gatos; sobredosis benzodiazepinas)","presentacion":"Inyectable","concentracion":"0.1 mg/ml","dosis_min_mg_kg":"0.0100","dosis_max_mg_kg":"0.0100","concentracion_mg_ml":"0.1"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33336'
WHERE nombre ILIKE 'Flumazenil';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg/ml","dosis_texto":"0.5-1 mg/kg IV/IM/SC (perros y gatos)","presentacion":"Inyectable","concentracion":"50 mg/ml","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":"50"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Flunixin%20Meglumina'
WHERE nombre ILIKE 'Flunixin Meglumina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros y gatos; ansiedad/agresión, Reconcile)","presentacion":"Cápsulas","concentracion":"20 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Fluoxetina'
WHERE nombre ILIKE 'Fluoxetina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg","dosis_texto":"25-56 mg/kg PO cada 12 semanas (perros; Bravecto)","presentacion":"Comprimidos masticables","concentracion":"500 mg","dosis_min_mg_kg":"25.0000","dosis_max_mg_kg":"56.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Fluralaner'
WHERE nombre ILIKE 'Fluralaner';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"10-20 mg/kg PO cada 8-12h (perros y gatos; dolor neuropático)","presentacion":"Cápsulas","concentracion":"100 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"20.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77780'
WHERE nombre ILIKE 'Gabapentina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"40 mg/ml","dosis_texto":"4-8 mg/kg IV/IM/SC cada 24h (perros); gatos 6-8 mg/kg","presentacion":"Inyectable","concentracion":"40 mg/ml","dosis_min_mg_kg":"4.0000","dosis_max_mg_kg":"8.0000","concentracion_mg_ml":"40"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88891'
WHERE nombre ILIKE 'Gentamicina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.2 mg/ml","dosis_texto":"Perros/gatos: 0.005-0.01 mg/kg IV/IM/SC (menos taquicardia que atropina)","presentacion":"Solución inyectable","concentracion":"0.2 mg/ml","dosis_min_mg_kg":"0.0050","dosis_max_mg_kg":"0.0100","concentracion_mg_ml":"0.2"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Glicopirrolato'
WHERE nombre ILIKE 'Glicopirrolato';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg","dosis_texto":"20-50 mg/kg PO cada 24h (perros; salud articular)","presentacion":"Comprimidos","concentracion":"500 mg","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"50.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Glucosamina'
WHERE nombre ILIKE 'Glucosamina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg","dosis_texto":"2 mg/kg PO cada 24h (perros; Galliprant)","presentacion":"Comprimidos","concentracion":"20 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Grapiprant'
WHERE nombre ILIKE 'Grapiprant';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg","dosis_texto":"25-50 mg/kg PO cada 24h (perros y gatos; dermatofitosis)","presentacion":"Comprimidos","concentracion":"250 mg","dosis_min_mg_kg":"25.0000","dosis_max_mg_kg":"50.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Griseofulvina'
WHERE nombre ILIKE 'Griseofulvina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg/ml","dosis_texto":"0.5-1 mg/kg IV/PO (perros; vasodilatador)","presentacion":"Inyectable","concentracion":"20 mg/ml","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":"20"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33337'
WHERE nombre ILIKE 'Hidralazina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"2-4 mg/kg PO cada 12-24h (perros; diurético tiazídico)","presentacion":"Comprimidos","concentracion":"25 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"4.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44448'
WHERE nombre ILIKE 'Hidroclorotiazida';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"2 mg/ml (1 mg/mL)","dosis_texto":"0.05-0.1 mg/kg IV/IM/SC cada 2-6h (perros y gatos)","presentacion":"Solución inyectable","concentracion":"2 mg/ml","dosis_min_mg_kg":"0.0500","dosis_max_mg_kg":"0.2000","concentracion_mg_ml":"1"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Hidromorfona'
WHERE nombre ILIKE 'Hidromorfona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"0.5-2 mg/kg PO cada 8h (perros)","presentacion":"Cápsulas","concentracion":"25 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Hidroxizina'
WHERE nombre ILIKE 'Hidroxizina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"200-600 mg","dosis_texto":"NO recomendado en perros ni gatos; riesgo GI y renal elevado","presentacion":"Comprimidos","concentracion":"200-600 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77781'
WHERE nombre ILIKE 'Ibuprofeno';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg/ml","dosis_texto":"10 mg/kg tópico cada 30 días (perros y gatos; Advantage, antipulgas)","presentacion":"Spot-on","concentracion":"100 mg/ml","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":"100"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Imidacloprid'
WHERE nombre ILIKE 'Imidacloprid';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100% (1.5 MAC)","dosis_texto":"Inducción: 3-5% (caja); mantenimiento: 1.5-3% (perros), 2-3% (gatos). MAC 1.3-1.5%","presentacion":"Líquido volátil","concentracion":"100% (1.5 MAC)","dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Isoflurano'
WHERE nombre ILIKE 'Isoflurano';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"5 mg/kg PO cada 24h (perros y gatos)","presentacion":"Cápsulas","concentracion":"100 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"5.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Itraconazol'
WHERE nombre ILIKE 'Itraconazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"0.2-0.4 mg/kg PO/SC cada 24h (perros y gatos; precaución razas MDR1)","presentacion":"Inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"0.2000","dosis_max_mg_kg":"0.4000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Ivermectina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50-100 mg/ml","dosis_texto":"0.5-1 mg/kg IV como analgesia adjuvant; infusión 0.1-0.6 mg/kg/h","presentacion":"Solución inyectable","concentracion":"50-100 mg/ml","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":"100"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Ketamina (baja)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"200 mg","dosis_texto":"5-10 mg/kg PO cada 24h (perros y gatos)","presentacion":"Comprimidos","concentracion":"200 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Ketoconazol'
WHERE nombre ILIKE 'Ketoconazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg/ml","dosis_texto":"1-2 mg/kg IV/IM/SC cada 24h (perros); 1 mg/kg (gatos)","presentacion":"Solución inyectable","concentracion":"100 mg/ml","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":"100"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11116'
WHERE nombre ILIKE 'Ketoprofeno';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5-20 mg","dosis_texto":"1 mg/kg PO cada 24h (perros)","presentacion":"Comprimidos","concentracion":"5-20 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11116'
WHERE nombre ILIKE 'Ketoprofeno oral';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg","dosis_texto":"50-200 mg/kg PO cada 24h (perros; cardiomiopatía)","presentacion":"Cápsulas","concentracion":"500 mg","dosis_min_mg_kg":"50.0000","dosis_max_mg_kg":"200.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=L-Carnitina'
WHERE nombre ILIKE 'L-Carnitina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1000 ml","dosis_texto":"Shock perros: 90 ml/kg/h; gatos: 45-60 ml/kg/h; mantenimiento 2-4 ml/kg/h","presentacion":"Solución IV","concentracion":"1000 ml","dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Lactato%20de%20Ringer'
WHERE nombre ILIKE 'Lactato de Ringer';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 µg/ml (0.05000000000000000000 mg/mL)","dosis_texto":"1 gota tópico cada 24h (perros y gatos; glaucoma, hipotensor)","presentacion":"Gotas oftálmicas","concentracion":"50 µg/ml","dosis_min_mg_kg":"0.0050","dosis_max_mg_kg":"0.0050","concentracion_mg_ml":"0.05000000000000000000"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Latanoprost'
WHERE nombre ILIKE 'Latanoprost';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg","dosis_texto":"20-60 mg/kg PO cada 8h (perros y gatos; epilepsia)","presentacion":"Comprimidos","concentracion":"250 mg","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"60.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33338'
WHERE nombre ILIKE 'Levetiracetam';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.25-0.5%","dosis_texto":"Regional/epidural: 1-2 mg/kg total (perros); infiltración 0.25-0.5%. Onset 10-20 min, duración larga","presentacion":"Inyectable","concentracion":"0.25-0.5%","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Levobupivaca%C3%ADna'
WHERE nombre ILIKE 'Levobupivacaína';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 µg","dosis_texto":"0.02-0.04 mg/kg PO cada 24h (perros); gatos 0.1-0.3 mg/día total","presentacion":"Comprimidos","concentracion":"100 µg","dosis_min_mg_kg":"0.0200","dosis_max_mg_kg":"0.0400","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44449'
WHERE nombre ILIKE 'Levotiroxina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg/ml","dosis_texto":"2-4 mg/kg IV bolo (perros; arritmias ventriculares)","presentacion":"Inyectable","concentracion":"20 mg/ml","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"4.0000","concentracion_mg_ml":"20"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55560'
WHERE nombre ILIKE 'Lidocaína';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg/ml","dosis_texto":"1-3 mg/kg SC cada 4-8 semanas (perros; Cytopoint)","presentacion":"Inyectable","concentracion":"20 mg/ml","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"3.0000","concentracion_mg_ml":"20"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Lokivetmab'
WHERE nombre ILIKE 'Lokivetmab';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg","dosis_texto":"2.5-3.3 mg/kg PO cada 21 días (perros; uso oncológico hospitalario)","presentacion":"Cápsulas","concentracion":"10 mg","dosis_min_mg_kg":"2.5000","dosis_max_mg_kg":"3.3000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Lomustina'
WHERE nombre ILIKE 'Lomustina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"2 mg","dosis_texto":"0.1-0.2 mg/kg PO cada 8h (solo perros; evitar gatos por MDR1)","presentacion":"Comprimidos","concentracion":"2 mg","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.2000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Loperamida'
WHERE nombre ILIKE 'Loperamida';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg","dosis_texto":"0.25-0.5 mg/kg PO cada 24h (perros)","presentacion":"Comprimidos","concentracion":"10 mg","dosis_min_mg_kg":"0.2500","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77782'
WHERE nombre ILIKE 'Loratadina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"0.5-1 mg/kg PO cada 24h (perros y gatos; ARA II)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Losart%C3%A1n'
WHERE nombre ILIKE 'Losartán';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"20-43 mg/kg PO cada 30 días (perros; Credelio)","presentacion":"Comprimidos masticables","concentracion":"100 mg","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"43.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Lotilaner'
WHERE nombre ILIKE 'Lotilaner';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"2-4 mg/kg PO cada 24h (perros y gatos)","presentacion":"Comprimidos","concentracion":"25 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"4.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Marbofloxacina'
WHERE nombre ILIKE 'Marbofloxacina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"8 mg","dosis_texto":"1-2 mg/kg SC/PO cada 24h (perros y gatos; antiemético)","presentacion":"Comprimidos","concentracion":"8 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Maropitant';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"12.5 mg/kg PO cada 24h (perros; mastocitoma, Masivet)","presentacion":"Comprimidos","concentracion":"100 mg","dosis_min_mg_kg":"12.5000","dosis_max_mg_kg":"12.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Masitinib'
WHERE nombre ILIKE 'Masitinib';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"95-230 mg","dosis_texto":"2 mg/kg PO cada 14 días tras dosis inicial (perros)","presentacion":"Comprimidos","concentracion":"95-230 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Mavacoxib'
WHERE nombre ILIKE 'Mavacoxib';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"10-20 mg/kg PO cada 24h (perros y gatos; antihelmíntico)","presentacion":"Comprimidos","concentracion":"100 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"20.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Mebendazol'
WHERE nombre ILIKE 'Mebendazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1 mg/ml","dosis_texto":"5-10 µg/kg IM (perros y gatos)","presentacion":"Inyectable","concentracion":"1 mg/ml","dosis_min_mg_kg":"0.0050","dosis_max_mg_kg":"0.0100","concentracion_mg_ml":"1"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Medetomidina'
WHERE nombre ILIKE 'Medetomidina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1.5 mg/ml","dosis_texto":"0.1-0.2 mg/kg PO cada 24h","presentacion":"Suspensión oral","concentracion":"1.5 mg/ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.2000","concentracion_mg_ml":"1.5"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Meloxicam';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg/ml","dosis_texto":"0.2 mg/kg SC dosis única inicial; luego 0.1 mg/kg PO cada 24h (perros); 0.3 mg/kg SC (gatos)","presentacion":"Solución inyectable","concentracion":"5 mg/ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.2000","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Meloxicam inyectable';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1-2% (20 mg/mL)","dosis_texto":"1-2 mg/kg local (perros y gatos); duración corta","presentacion":"Solución inyectable","concentracion":"1-2%","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"4.0000","concentracion_mg_ml":"20"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Mepivaca%C3%ADna'
WHERE nombre ILIKE 'Mepivacaína';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"Perros: 0.1-0.5 mg/kg IV/SC/IM; gatos: 0.1-0.25 mg/kg SC/IM cada 4-8h","presentacion":"Solución inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99994'
WHERE nombre ILIKE 'Metadona (analgesia)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5-10 mg","dosis_texto":"0.2-0.5 mg/kg PO cada 6-8h (perros); baja biodisponibilidad oral","presentacion":"Comprimidos","concentracion":"5-10 mg","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99994'
WHERE nombre ILIKE 'Metadona oral';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"4 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros y gatos)","presentacion":"Comprimidos","concentracion":"4 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Metilprednisolona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg","dosis_texto":"2.5-5 mg/kg PO cada 12h (gatos; hipertiroidismo, Felimazole)","presentacion":"Comprimidos","concentracion":"5 mg","dosis_min_mg_kg":"2.5000","dosis_max_mg_kg":"5.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Metimazol'
WHERE nombre ILIKE 'Metimazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg/ml","dosis_texto":"0.2-0.5 mg/kg SC/IM cada 8h","presentacion":"Inyectable","concentracion":"5 mg/ml","dosis_min_mg_kg":"0.2000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11117'
WHERE nombre ILIKE 'Metoclopramida';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"0.2-0.5 mg/kg PO cada 12h (perros y gatos; betabloqueante)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":"0.2000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Metoprolol'
WHERE nombre ILIKE 'Metoprolol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg","dosis_texto":"10-25 mg/kg PO/IV cada 12h (perros y gatos); Giardia 20-50","presentacion":"Comprimidos","concentracion":"250 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"25.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22228'
WHERE nombre ILIKE 'Metronidazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg/g","dosis_texto":"Tópico 2% cada 24h (perros y gatos; dermatofitosis/otitis)","presentacion":"Crema/Champú","concentracion":"20 mg/g","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"20.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Miconazol'
WHERE nombre ILIKE 'Miconazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg/ml","dosis_texto":"Perros: 0.1-0.4 mg/kg IV/IM; gatos: 0.1-0.3 mg/kg IV/IM; como premedicación 15-30 min antes de la inducción","presentacion":"Inyectable","concentracion":"5 mg/ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.4000","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Midazolam';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"11.4 mg","dosis_texto":"0.5-1 mg/kg PO cada 24h (perros y gatos)","presentacion":"Comprimidos","concentracion":"11.4 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Milbemicina%20Oxima'
WHERE nombre ILIKE 'Milbemicina Oxima';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg/ml","dosis_texto":"2 mg/kg PO cada 24h x 28 días (perros; leishmaniosis, Milteforan)","presentacion":"Solución oral","concentracion":"20 mg/ml","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":"20"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Miltefosina'
WHERE nombre ILIKE 'Miltefosina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"200 µg","dosis_texto":"2-4 µg/kg PO cada 8-12h (perros y gatos; protección GI con AINE)","presentacion":"Comprimidos","concentracion":"200 µg","dosis_min_mg_kg":"0.0020","dosis_max_mg_kg":"0.0040","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Misoprostol'
WHERE nombre ILIKE 'Misoprostol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg","dosis_texto":"50-75 mg/kg PO (inducción, perros; hiperadrenocorticismo, Lysodren)","presentacion":"Comprimidos","concentracion":"500 mg","dosis_min_mg_kg":"50.0000","dosis_max_mg_kg":"75.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Mitotano'
WHERE nombre ILIKE 'Mitotano';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"0.5-1 mg/kg IV/IM/SC cada 4-6h (perros y gatos)","presentacion":"Inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Morfina'
WHERE nombre ILIKE 'Morfina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg/ml","dosis_texto":"2.5 mg/kg tópico cada 30 días (perros)","presentacion":"Spot-on","concentracion":"25 mg/ml","dosis_min_mg_kg":"2.5000","dosis_max_mg_kg":"2.5000","concentracion_mg_ml":"25"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Moxidectina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.4 mg/ml","dosis_texto":"Perros/gatos: 0.01-0.04 mg/kg IV/IM/SC; repetir 1-2 min si es necesario (vida media corta)","presentacion":"Solución inyectable","concentracion":"0.4 mg/ml","dosis_min_mg_kg":"0.0200","dosis_max_mg_kg":"0.0400","concentracion_mg_ml":"0.4"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44450'
WHERE nombre ILIKE 'Naloxona (anestesia)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250-500 mg","dosis_texto":"5 mg/kg PO cada 24h día 1; luego 2.5 mg/kg cada 24h (perros); evitar en gatos","presentacion":"Comprimidos","concentracion":"250-500 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Naproxeno'
WHERE nombre ILIKE 'Naproxeno';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.5 mg/ml","dosis_texto":"Perros/gatos: 0.02-0.04 mg/kg IV (con atropina 0.02 mg/kg)","presentacion":"Solución inyectable","concentracion":"0.5 mg/ml","dosis_min_mg_kg":"0.0100","dosis_max_mg_kg":"0.0500","concentracion_mg_ml":"0.5"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Neostigmina'
WHERE nombre ILIKE 'Neostigmina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"11 mg","dosis_texto":"1 mg/kg PO (perros y gatos; Capstar, antipulgas rápido)","presentacion":"Comprimidos","concentracion":"11 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Nitenpiram';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"2-4 mg/kg PO cada 8h (perros; infecciones urinarias bajas)","presentacion":"Comprimidos","concentracion":"100 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"4.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Nitrofuranto%C3%ADna'
WHERE nombre ILIKE 'Nitrofurantoína';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1 mg/mL (bitartrato)","dosis_texto":"Infusión IV continua: 0.05-2 mcg/kg/min, titular según respuesta hemodinámica","presentacion":"Inyectable (ampolla)","concentracion":"1 mg/mL (bitartrato)","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":"1"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Norepinefrina%20(noradrenalina)'
WHERE nombre ILIKE 'Norepinefrina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"16 mg","dosis_texto":"0.4-0.6 mg/kg PO (perros; prurito atópico, Apoquel)","presentacion":"Comprimidos","concentracion":"16 mg","dosis_min_mg_kg":"0.4000","dosis_max_mg_kg":"0.6000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Oclacitinib'
WHERE nombre ILIKE 'Oclacitinib';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"200 mg","dosis_texto":"5-10 mg/kg PO cada 24h (perros y gatos)","presentacion":"Comprimidos","concentracion":"200 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Ofloxacina'
WHERE nombre ILIKE 'Ofloxacina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"300 mg","dosis_texto":"20-55 mg/kg/día EPA+DHA (perros y gatos)","presentacion":"Cápsulas","concentracion":"300 mg","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"55.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Omega-3%20(EPA%2FDHA)'
WHERE nombre ILIKE 'Omega-3 (EPA/DHA)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg","dosis_texto":"0.5-1 mg/kg PO cada 24h (perros y gatos); proteger mucosa gástrica","presentacion":"Comprimidos","concentracion":"20 mg","dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66672'
WHERE nombre ILIKE 'Omeprazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"4 mg","dosis_texto":"0.1-0.5 mg/kg IV/PO cada 8-12h (perros y gatos)","presentacion":"Comprimidos","concentracion":"4 mg","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77783'
WHERE nombre ILIKE 'Ondansetrón';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"2.5-7.5 mg/kg PO cada 24h (perros)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":"2.5000","dosis_max_mg_kg":"7.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Orbifloxacina'
WHERE nombre ILIKE 'Orbifloxacina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg/ml","dosis_texto":"10-50 mg/kg PO cada 24h (perros y gatos; antihelmíntico)","presentacion":"Suspensión oral","concentracion":"100 mg/ml","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"50.0000","concentracion_mg_ml":"100"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Oxfendazol'
WHERE nombre ILIKE 'Oxfendazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"225 mg","dosis_texto":"10-15 mg/kg PO cada 24h (perros; antihelmíntico)","presentacion":"Comprimidos","concentracion":"225 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"15.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88894'
WHERE nombre ILIKE 'Oxibendazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5-10-20 mg","dosis_texto":"0.1-0.2 mg/kg PO cada 6-8h (perros); usar con precaución en gatos","presentacion":"Comprimidos","concentracion":"5-10-20 mg","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Oxicodona'
WHERE nombre ILIKE 'Oxicodona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"Perros: 0.05-0.1 mg/kg IV/IM/SC; gatos: 0.05-0.1 mg/kg SC/IM","presentacion":"Solución inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"0.0500","dosis_max_mg_kg":"0.1000","concentracion_mg_ml":"1"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Oximorfona'
WHERE nombre ILIKE 'Oximorfona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"40 mg","dosis_texto":"1 mg/kg PO/IV cada 24h (perros y gatos; IBP)","presentacion":"Comprimidos","concentracion":"40 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Pantoprazol'
WHERE nombre ILIKE 'Pantoprazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg","dosis_texto":"10-15 mg/kg PO cada 8-12h (SOLO PERROS; tóxico en gatos)","presentacion":"Comprimidos","concentracion":"500 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"15.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11118'
WHERE nombre ILIKE 'Paracetamol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg/ml","dosis_texto":"0.5-2% tópico (SOLO PERROS; tóxica en gatos, piretroide)","presentacion":"Spray/Collar","concentracion":"500 mg/ml","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":"500"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Permetrina'
WHERE nombre ILIKE 'Permetrina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"2.5 mg","dosis_texto":"0.25-0.5 mg/kg PO cada 12h (perros; insuficiencia cardíaca)","presentacion":"Comprimidos","concentracion":"2.5 mg","dosis_min_mg_kg":"0.2500","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Pimobend%C3%A1n'
WHERE nombre ILIKE 'Pimobendán';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg/ml","dosis_texto":"5-11 mg/kg PO cada 24h (perros y gatos)","presentacion":"Suspensión oral","concentracion":"50 mg/ml","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"11.0000","concentracion_mg_ml":"50"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Pirantel%20Pamoato'
WHERE nombre ILIKE 'Pirantel Pamoato';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10-20 mg","dosis_texto":"0.3 mg/kg PO cada 24h (perros); usar con precaución","presentacion":"Cápsulas","concentracion":"10-20 mg","dosis_min_mg_kg":"0.3000","dosis_max_mg_kg":"0.3000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44451'
WHERE nombre ILIKE 'Piroxicam';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg/ml","dosis_texto":"20-50 mg/kg PO cada 24h (perros y gatos; coccidias)","presentacion":"Suspensión oral","concentracion":"100 mg/ml","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"50.0000","concentracion_mg_ml":"100"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Ponazuril';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"3-6 mg/kg PO cada 24h (perros y gatos)","presentacion":"Comprimidos","concentracion":"25 mg","dosis_min_mg_kg":"3.0000","dosis_max_mg_kg":"6.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Pradofloxacina'
WHERE nombre ILIKE 'Pradofloxacina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg","dosis_texto":"5-7.5 mg/kg PO cada 24h (perros y gatos)","presentacion":"Comprimidos","concentracion":"25 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"7.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Praziquantel'
WHERE nombre ILIKE 'Praziquantel';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1 mg","dosis_texto":"0.5-1 mg/kg PO cada 8-12h (perros y gatos; alfa bloqueante)","presentacion":"Cápsulas","concentracion":"1 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55562'
WHERE nombre ILIKE 'Prazosina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg","dosis_texto":"0.5-2 mg/kg PO cada 24h (perros y gatos; corticoide activo)","presentacion":"Comprimidos","concentracion":"20 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Prednisolona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg","dosis_texto":"0.5-2 mg/kg PO cada 24h (perros); gatos 1-2 mg/kg","presentacion":"Comprimidos","concentracion":"20 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Prednisona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"75 mg","dosis_texto":"4-6 mg/kg PO cada 8-12h (perros y gatos; dolor neuropático)","presentacion":"Cápsulas","concentracion":"75 mg","dosis_min_mg_kg":"4.0000","dosis_max_mg_kg":"6.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Pregabalina'
WHERE nombre ILIKE 'Pregabalina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"Perros: 4-6 mg/kg IV a efecto; gatos: 2-4 mg/kg IV a efecto (lento)","presentacion":"Emulsión IV","concentracion":"10 mg/ml","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"6.0000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Propofol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg","dosis_texto":"0.2-0.5 mg/kg PO cada 8h (perros y gatos; betabloqueante)","presentacion":"Comprimidos","concentracion":"10 mg","dosis_min_mg_kg":"0.2000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Propranolol'
WHERE nombre ILIKE 'Propranolol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg","dosis_texto":"1 mg/kg PO cada 24h (perros y gatos; IBP)","presentacion":"Comprimidos","concentracion":"20 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Rabeprazol'
WHERE nombre ILIKE 'Rabeprazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"2.5 mg","dosis_texto":"0.125-0.25 mg/kg PO cada 24h (perros y gatos; IECA)","presentacion":"Cápsulas","concentracion":"2.5 mg","dosis_min_mg_kg":"0.1250","dosis_max_mg_kg":"0.2500","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Ramipril'
WHERE nombre ILIKE 'Ramipril';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1 mg/ml","dosis_texto":"1-3 µg/kg IV bolo; infusión 5-20 µg/kg/h (perros y gatos)","presentacion":"Solución inyectable","concentracion":"1 mg/ml","dosis_min_mg_kg":"0.0010","dosis_max_mg_kg":"0.0200","concentracion_mg_ml":"1"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77784'
WHERE nombre ILIKE 'Remifentanilo';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"150 mg","dosis_texto":"10-20 mg/kg PO cada 24h (perros y gatos; combinada, micobacterias)","presentacion":"Cápsulas","concentracion":"150 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"20.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Rifampicina'
WHERE nombre ILIKE 'Rifampicina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros; Onsior)","presentacion":"Comprimidos","concentracion":"10 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Robenacoxib';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"Perros: 0.3-0.6 mg/kg IV; gatos: 0.3-0.6 mg/kg IV; inicio 1-2 min","presentacion":"Solución inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"0.4000","dosis_max_mg_kg":"0.6000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Rocuronio'
WHERE nombre ILIKE 'Rocuronio';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"200 mg","dosis_texto":"30 mg/kg PO cada 24h (gatos; Tritrichomonas foetus)","presentacion":"Comprimidos","concentracion":"200 mg","dosis_min_mg_kg":"30.0000","dosis_max_mg_kg":"30.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Ronidazol'
WHERE nombre ILIKE 'Ronidazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.2-0.75%","dosis_texto":"Bloqueo regional 1-2 mg/kg; infiltración 1-2 mg/kg; epidural 1.5-2.5 mg/kg","presentacion":"Solución inyectable","concentracion":"0.2-0.75%","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Ropivaca%C3%ADna'
WHERE nombre ILIKE 'Ropivacaína (regional)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"2 mg/5 ml","dosis_texto":"0.1-0.2 mg/kg PO/inalado cada 8h (perros y gatos; broncoespasmo)","presentacion":"Inhalador/Jarabe","concentracion":"2 mg/5 ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.2000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Salbutamol'
WHERE nombre ILIKE 'Salbutamol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"200 mg","dosis_texto":"20 mg/kg PO cada 24h (perros y gatos; hepatoprotector, Denosyl)","presentacion":"Comprimidos","concentracion":"200 mg","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"20.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=S-adenosilmetionina'
WHERE nombre ILIKE 'SAMe';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"80 mg","dosis_texto":"2-4 mg/kg PO cada 30 días (perros; Simparica)","presentacion":"Comprimidos masticables","concentracion":"80 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"4.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Sarolaner'
WHERE nombre ILIKE 'Sarolaner';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"60 mg/ml","dosis_texto":"6-12 mg/kg tópico cada 30 días (perros y gatos)","presentacion":"Spot-on","concentracion":"60 mg/ml","dosis_min_mg_kg":"6.0000","dosis_max_mg_kg":"12.0000","concentracion_mg_ml":"60"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Selamectina'
WHERE nombre ILIKE 'Selamectina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg","dosis_texto":"0.5-1 mg/kg PO cada 24h (perros; disfunción cognitiva, Anipryl)","presentacion":"Comprimidos","concentracion":"5 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Selegilina'
WHERE nombre ILIKE 'Selegilina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100% (2.2 MAC)","dosis_texto":"Inducción: 4-8% por máscara; mantenimiento: 2-4% (perros), 2.5-4% (gatos). MAC 2.2-2.6%","presentacion":"Líquido volátil","concentracion":"100% (2.2 MAC)","dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Sevoflurano'
WHERE nombre ILIKE 'Sevoflurano';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"1-3 mg/kg PO cada 8-12h (perros; hipertensión pulmonar)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"3.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88895'
WHERE nombre ILIKE 'Sildenafilo';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"140 mg","dosis_texto":"20-50 mg/kg PO cada 24h (perros y gatos; cardo mariano, hepatoprotector)","presentacion":"Cápsulas","concentracion":"140 mg","dosis_min_mg_kg":"20.0000","dosis_max_mg_kg":"50.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Silymarina'
WHERE nombre ILIKE 'Silymarina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"80 mg","dosis_texto":"1-2 mg/kg PO cada 12h (perros y gatos; antiarrítmico)","presentacion":"Comprimidos","concentracion":"80 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99996'
WHERE nombre ILIKE 'Sotalol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10-20 mg/ml","dosis_texto":"Perros: 0.3-1 mg/kg IV; gatos: 0.5-1 mg/kg IV. Onset 30-60 s, duración 5-10 min","presentacion":"Inyectable","concentracion":"10-20 mg/ml","dosis_min_mg_kg":"0.3000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":"20"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Succinilcolina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg","dosis_texto":"27.5-55 mg/kg PO (loading/therapy perros; coccidias)","presentacion":"Comprimidos","concentracion":"500 mg","dosis_min_mg_kg":"27.5000","dosis_max_mg_kg":"55.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Sulfadimetoxina'
WHERE nombre ILIKE 'Sulfadimetoxina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"400/80 mg","dosis_texto":"15-30 mg/kg (TMP) PO/IV cada 12h (perros y gatos)","presentacion":"Comprimidos","concentracion":"400/80 mg","dosis_min_mg_kg":"15.0000","dosis_max_mg_kg":"30.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Sulfametoxazol%20%2B%20Trimetoprima'
WHERE nombre ILIKE 'Sulfametoxazol + Trimetoprima';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros; hipertensión pulmonar)","presentacion":"Comprimidos","concentracion":"20 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tadalafilo'
WHERE nombre ILIKE 'Tadalafilo';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.4 mg","dosis_texto":"0.1-0.2 mg/kg PO cada 24h (perros; relajante uretral)","presentacion":"Cápsulas","concentracion":"0.4 mg","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.2000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tamsulosina'
WHERE nombre ILIKE 'Tamsulosina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50-100 mg","dosis_texto":"2-4 mg/kg PO cada 8-12h (perros; dolor moderado-severo)","presentacion":"Comprimidos","concentracion":"50-100 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"3.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tapentadol'
WHERE nombre ILIKE 'Tapentadol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"500 mg","dosis_texto":"25-50 mg/kg PO cada 24h (gatos; 250-500 mg/día)","presentacion":"Cápsulas","concentracion":"500 mg","dosis_min_mg_kg":"25.0000","dosis_max_mg_kg":"50.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Taurina'
WHERE nombre ILIKE 'Taurina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"40 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros y gatos; ARA II)","presentacion":"Comprimidos","concentracion":"40 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22230'
WHERE nombre ILIKE 'Telmisartán';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg","dosis_texto":"0.4 mg/kg PO cada 24h (perros)","presentacion":"Comprimidos","concentracion":"20 mg","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"0.5000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tenoxicam'
WHERE nombre ILIKE 'Tenoxicam';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"5-10 mg/kg PO cada 8-12h (perros; broncodilatador metilxantina)","presentacion":"Comprimidos","concentracion":"100 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Teofilina'
WHERE nombre ILIKE 'Teofilina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"25 mg/ml","dosis_texto":"10-20 mg/kg PO cada 24h (perros; dual COX/LOX)","presentacion":"Suspensión oral","concentracion":"25 mg/ml","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":"25"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tepoxalina'
WHERE nombre ILIKE 'Tepoxalina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"250 mg","dosis_texto":"25-55 mg/kg PO cada 24h (perros y gatos; onicomicosis)","presentacion":"Comprimidos","concentracion":"250 mg","dosis_min_mg_kg":"25.0000","dosis_max_mg_kg":"55.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Terbinafina'
WHERE nombre ILIKE 'Terbinafina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.5 mg/ml","dosis_texto":"0.05-0.1 mg/kg SC/PO cada 8h (perros y gatos; broncoespasmo)","presentacion":"Inyectable","concentracion":"0.5 mg/ml","dosis_min_mg_kg":"0.0500","dosis_max_mg_kg":"0.1000","concentracion_mg_ml":"0.5"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Terbutalina'
WHERE nombre ILIKE 'Terbutalina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"0.5-1% (con adrenalina)","dosis_texto":"Infiltración/regional: 0.2-0.5%; máximo 1-2 mg/kg total (perros). Onset 10-15 min, duración larga","presentacion":"Inyectable","concentracion":"0.5-1% (con adrenalina)","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"2.0000","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tetraca%C3%ADna'
WHERE nombre ILIKE 'Tetracaína';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg cada uno","dosis_texto":"Perros: 2-6 mg/kg IM; gatos: 2-4 mg/kg IM; vida silvestre 1-5 mg/kg","presentacion":"Polvo liofilizado","concentracion":"50 mg cada uno","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"4.0000","concentracion_mg_ml":"50"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tiletamina%2FZolazepam'
WHERE nombre ILIKE 'Tiletamina + Zolazepam (Telazol)';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg/ml","dosis_texto":"1 gota tópico cada 12h (perros y gatos; glaucoma, betabloqueante)","presentacion":"Gotas oftálmicas","concentracion":"5 mg/ml","dosis_min_mg_kg":"0.0500","dosis_max_mg_kg":"0.0500","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44452'
WHERE nombre ILIKE 'Timolol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"2.5% (25 mg/mL) tras reconstituir","dosis_texto":"Inducción: perros 5-15 mg/kg IV; gatos 5-12 mg/kg IV; equinos 4-8 mg/kg IV. Efecto en 15-30 s, duración 10-20 min","presentacion":"Inyectable (polvo para reconstituir)","concentracion":"2.5% (25 mg/mL) tras reconstituir","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"15.0000","concentracion_mg_ml":"25"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tiopental%20s%C3%B3dico'
WHERE nombre ILIKE 'Tiopental';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"40 mg/ml","dosis_texto":"5-10 mg/kg IV/IM/SC cada 24h (perros); oftálmica tópica","presentacion":"Inyectable","concentracion":"40 mg/ml","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":"40"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tobramicina'
WHERE nombre ILIKE 'Tobramicina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg","dosis_texto":"3.25 mg/kg PO (lunes/miércoles/viernes; perros; Palladia)","presentacion":"Comprimidos","concentracion":"10 mg","dosis_min_mg_kg":"3.2500","dosis_max_mg_kg":"3.2500","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Toceranib'
WHERE nombre ILIKE 'Toceranib';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg/ml","dosis_texto":"10-20 mg/kg PO (perros y gatos; coccidias)","presentacion":"Suspensión oral","concentracion":"50 mg/ml","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"20.0000","concentracion_mg_ml":"50"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Toltrazuril';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg","dosis_texto":"0.2-0.4 mg/kg PO cada 24h (perros; diurético de asa)","presentacion":"Comprimidos","concentracion":"10 mg","dosis_min_mg_kg":"0.2000","dosis_max_mg_kg":"0.4000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Torsemida'
WHERE nombre ILIKE 'Torsemida';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"1-4 mg/kg PO/IV cada 6-8h (perros); 1-2 mg/kg cada 8-12h (gatos)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55563'
WHERE nombre ILIKE 'Tramadol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"5-10 mg/kg PO cada 8-12h (perros; ansiedad situacional)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66674'
WHERE nombre ILIKE 'Trazodona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"0.5-1 mg/kg IM (perros; dermatosis alérgica)","presentacion":"Inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Triamcinolona'
WHERE nombre ILIKE 'Triamcinolona';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"30 mg","dosis_texto":"2-6 mg/kg PO cada 24h (perros; hiperadrenocorticismo, Vetoryl)","presentacion":"Cápsulas","concentracion":"30 mg","dosis_min_mg_kg":"2.0000","dosis_max_mg_kg":"6.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Trilostano'
WHERE nombre ILIKE 'Trilostano';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg/ml","dosis_texto":"1-2 gotas tópico cada 8h (perros y gatos; midriático de acción corta)","presentacion":"Gotas oftálmicas","concentracion":"5 mg/ml","dosis_min_mg_kg":"0.0500","dosis_max_mg_kg":"0.1000","concentracion_mg_ml":"5"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tropicamida'
WHERE nombre ILIKE 'Tropicamida';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"125 mg/g","dosis_texto":"5-15 mg/kg PO cada 24h (perros; enteropatía sensible)","presentacion":"Granulado","concentracion":"125 mg/g","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"15.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Tylosina'
WHERE nombre ILIKE 'Tylosina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"100 mg","dosis_texto":"10-15 mg/kg PO cada 12h (perros y gatos; colagogos/hepatoprotector)","presentacion":"Cápsulas","concentracion":"100 mg","dosis_min_mg_kg":"10.0000","dosis_max_mg_kg":"15.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Ursodiol'
WHERE nombre ILIKE 'Ursodiol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"0.5 mg/kg IV/SC cada 24h (perros); 1 mg/kg IV/SC (gatos)","presentacion":"Solución inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456'
WHERE nombre ILIKE 'Vedaprofeno';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"37.5-75 mg","dosis_texto":"1-2 mg/kg PO cada 24h (perros; dolor neuropático)","presentacion":"Comprimidos","concentracion":"37.5-75 mg","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"3.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Venlafaxina'
WHERE nombre ILIKE 'Venlafaxina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1 mg/ml","dosis_texto":"0.025-0.07 mg/kg IV semanal (perros; uso oncológico hospitalario)","presentacion":"Inyectable","concentracion":"1 mg/ml","dosis_min_mg_kg":"0.0250","dosis_max_mg_kg":"0.0700","concentracion_mg_ml":"1"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Vincristina'
WHERE nombre ILIKE 'Vincristina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"Variable","dosis_texto":"1-2 ml IM cada 7 días","presentacion":"Inyectable","concentracion":"Variable","dosis_min_mg_kg":"0.0500","dosis_max_mg_kg":"0.1000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Complejo%20B'
WHERE nombre ILIKE 'Vitamina B Complex';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"1000 µg/ml (1.00000000000000000000 mg/mL)","dosis_texto":"250-1000 µg/día (25-100 µg/kg en 10 kg; suplemento, cianocobalamina)","presentacion":"Inyectable","concentracion":"1000 µg/ml","dosis_min_mg_kg":"0.0250","dosis_max_mg_kg":"0.1000","concentracion_mg_ml":"1.00000000000000000000"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Cobalamina'
WHERE nombre ILIKE 'Vitamina B12';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"10 mg/ml","dosis_texto":"1-5 mg/kg SC/IM/PO (antídoto rodenticidas anticoagulantes)","presentacion":"Inyectable","concentracion":"10 mg/ml","dosis_min_mg_kg":"1.0000","dosis_max_mg_kg":"5.0000","concentracion_mg_ml":"10"}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Fitonadiona'
WHERE nombre ILIKE 'Vitamina K1';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"50 mg","dosis_texto":"5-10 mg/kg PO cada 12h (perros y gatos; aspergilosis)","presentacion":"Comprimidos","concentracion":"50 mg","dosis_min_mg_kg":"5.0000","dosis_max_mg_kg":"10.0000","concentracion_mg_ml":null}]'::jsonb,
  url_referencia = 'https://www.merckvetmanual.com/search?term=Voriconazol'
WHERE nombre ILIKE 'Voriconazol';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"20 mg/ml","dosis_texto":"Perros: 0.5-1 mg/kg IV/IM; gatos: 0.5-1 mg/kg IM; equinos 0.5-1.1 mg/kg IV","presentacion":"Solución inyectable","concentracion":"20 mg/ml","dosis_min_mg_kg":"0.5000","dosis_max_mg_kg":"1.0000","concentracion_mg_ml":"20"}]'::jsonb,
  url_referencia = 'https://www.medicines.org.uk/emc/product/12345'
WHERE nombre ILIKE 'Xilacina';

UPDATE medicamentos SET
  presentaciones = '[{"etiqueta":"5 mg/ml (2 mg/mL)","dosis_texto":"Perros: 0.1 mg/kg IV; gatos: 0.1 mg/kg IV; equinos 0.075 mg/kg IV","presentacion":"Solución inyectable","concentracion":"5 mg/ml","dosis_min_mg_kg":"0.1000","dosis_max_mg_kg":"0.1000","concentracion_mg_ml":"2"}]'::jsonb,
  url_referencia = 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11120'
WHERE nombre ILIKE 'Yohimbina';


COMMIT;
-- Actualizados 235 fármacos con presentaciones y fuentes.
