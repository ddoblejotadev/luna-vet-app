-- Restaurar presentaciones perdidas en Atropina y Sucralfato tras el dedup
-- La fila Atropina que quedó: id 91b4d5a9 (inyectable 0.5 mg/mL)
-- La fila Sucralfato que quedó: id 4be8782c (comprimidos 1 g)
-- Agregamos las variantes como presentaciones alternativas en JSONB.

UPDATE public.medicamentos SET
  presentaciones = '[
    {"etiqueta":"Inyectable 0.5 mg/mL (uso sistémico)","presentacion":"Solución inyectable","concentracion":"0.5 mg/mL","concentracion_mg_ml":0.5,"dosis_min_mg_kg":0.02,"dosis_max_mg_kg":0.04,"dosis_texto":"Premedicación anestésica: 0.04 mg/kg IV/IM/SC; Bradycardia: 0.02-0.04 mg/kg IV"},
    {"etiqueta":"Inyectable 0.5 mg/mL (antídoto organofosforados)","presentacion":"Inyectable","concentracion":"0.5 mg/mL","concentracion_mg_ml":0.5,"dosis_min_mg_kg":0.02,"dosis_max_mg_kg":0.2,"dosis_texto":"Intoxicación organofosforados: 0.02-0.2 mg/kg IV/IM/SC repetir según signos"},
    {"etiqueta":"Oftálmica 10 mg/mL (midriático/ciclopléjico)","presentacion":"Gotas oftálmicas","concentracion":"10 mg/mL","concentracion_mg_ml":10,"dosis_min_mg_kg":null,"dosis_max_mg_kg":null,"dosis_texto":"1-2 gotas tópico cada 8-24h (perros y gatos)"}
  ]'::jsonb,
  concentracion_mg_ml = 0.5
WHERE id = '91b4d5a9-1467-4fce-8bba-62fb203d9328';

UPDATE public.medicamentos SET
  presentaciones = '[
    {"etiqueta":"Comprimidos 1 g","presentacion":"Comprimidos","concentracion":"1 g","concentracion_mg_ml":null,"dosis_min_mg_kg":50,"dosis_max_mg_kg":100,"dosis_texto":"50-100 mg/kg PO cada 8h (perros y gatos)"},
    {"etiqueta":"Suspensión 1 g/5 mL (200 mg/mL)","presentacion":"Suspensión oral","concentracion":"1 g/5 mL","concentracion_mg_ml":200,"dosis_min_mg_kg":50,"dosis_max_mg_kg":100,"dosis_texto":"0.5-1 g/perro PO cada 8h; 0.25 g/gato PO cada 8h"}
  ]'::jsonb,
  concentracion_mg_ml = COALESCE(concentracion_mg_ml, 200)
WHERE id = '4be8782c-a289-4f1c-a1f8-0f4238c39246';