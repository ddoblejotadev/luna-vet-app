-- Selector de presentaciones en la ficha + concentracion numerica
-- Permite que un farmaco con varias presentaciones (ej. Mastilac, concentracion 10% vs 5%)
-- muestre un "recuadro con opciones" en su ficha y actualice la dosis automaticamente.

ALTER TABLE public.medicamentos ADD COLUMN IF NOT EXISTS presentaciones jsonb;
ALTER TABLE public.medicamentos ADD COLUMN IF NOT EXISTS concentracion_mg_ml numeric;

COMMENT ON COLUMN public.medicamentos.presentaciones IS 'Array de presentaciones alternativas: [{etiqueta, presentacion, concentracion, concentracion_mg_ml, dosis_min_mg_kg, dosis_max_mg_kg, dosis_texto}]. Nulo/vacio = usar columnas top-level.';
COMMENT ON COLUMN public.medicamentos.concentracion_mg_ml IS 'Concentracion numerica de la presentacion principal en mg/mL (para calcular mL a administrar).';
