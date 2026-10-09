-- ============================================================================
-- SEGURIDAD CLÍNICA POR ESPECIE Y ALERTAS DE MEDICAMENTOS
-- ============================================================================
-- Agrega metadatos para que la UI pueda filtrar por especie y resaltar riesgos.
-- Mantiene el esquema compatible: no cambia RLS ni elimina dosis existentes.
-- ============================================================================

ALTER TABLE public.medicamentos
  ADD COLUMN IF NOT EXISTS especies_permitidas TEXT[] DEFAULT ARRAY['Perro', 'Gato'],
  ADD COLUMN IF NOT EXISTS especies_contraindicadas TEXT[] DEFAULT ARRAY[]::TEXT[],
  ADD COLUMN IF NOT EXISTS alertas_clinicas TEXT[] DEFAULT ARRAY[]::TEXT[],
  ADD COLUMN IF NOT EXISTS nivel_riesgo VARCHAR(20) DEFAULT 'normal';

ALTER TABLE public.medicamentos
  DROP CONSTRAINT IF EXISTS medicamentos_nivel_riesgo_check;

ALTER TABLE public.medicamentos
  ADD CONSTRAINT medicamentos_nivel_riesgo_check
  CHECK (nivel_riesgo IN ('normal', 'precaucion', 'alto', 'critico'));

CREATE INDEX IF NOT EXISTS idx_medicamentos_especies_permitidas
  ON public.medicamentos USING GIN (especies_permitidas);

CREATE INDEX IF NOT EXISTS idx_medicamentos_especies_contraindicadas
  ON public.medicamentos USING GIN (especies_contraindicadas);

CREATE INDEX IF NOT EXISTS idx_medicamentos_alertas_clinicas
  ON public.medicamentos USING GIN (alertas_clinicas);

CREATE INDEX IF NOT EXISTS idx_medicamentos_nivel_riesgo
  ON public.medicamentos(nivel_riesgo);

-- Defaults conservadores para registros donde el texto ya indica especie/uso.
UPDATE public.medicamentos
SET especies_permitidas = ARRAY['Perro'],
    especies_contraindicadas = ARRAY['Gato'],
    alertas_clinicas = ARRAY['Solo perros', 'Tóxico en gatos', 'Verificar criterio veterinario'],
    nivel_riesgo = 'critico'
WHERE nombre IN ('Paracetamol', 'Permetrina');

UPDATE public.medicamentos
SET especies_permitidas = ARRAY['Gato'],
    especies_contraindicadas = ARRAY['Perro'],
    alertas_clinicas = ARRAY['Solo gatos', 'Uso específico felino'],
    nivel_riesgo = 'precaucion'
WHERE nombre IN ('Famciclovir')
  AND dosis_recomendada ILIKE '%gatos%'
  AND dosis_recomendada NOT ILIKE '%perros%';

UPDATE public.medicamentos
SET alertas_clinicas = array_cat(alertas_clinicas, ARRAY['Uso hospitalario', 'Requiere supervisión veterinaria']),
    nivel_riesgo = 'alto'
WHERE familia_terapeutica IN ('Antineoplásicos / Quimioterapia', 'Sedantes y Anestésicos')
  AND nivel_riesgo <> 'critico';

UPDATE public.medicamentos
SET alertas_clinicas = array_cat(alertas_clinicas, ARRAY['Quimioterapia', 'Calcular preferentemente por superficie corporal', 'Requiere monitoreo hematológico']),
    nivel_riesgo = 'alto'
WHERE familia_terapeutica = 'Antineoplásicos / Quimioterapia'
  AND nivel_riesgo <> 'critico';

UPDATE public.medicamentos
SET alertas_clinicas = array_cat(alertas_clinicas, ARRAY['Requiere monitoreo renal/hepático', 'Evitar combinar con otros AINEs o corticoides']),
    nivel_riesgo = CASE WHEN nivel_riesgo = 'normal' THEN 'precaucion' ELSE nivel_riesgo END
WHERE familia_terapeutica = 'Analgésicos / Antiinflamatorios'
  AND nombre IN ('Carprofeno', 'Meloxicam', 'Ketoprofeno', 'Robenacoxib', 'Deracoxib', 'Firocoxib', 'Grapiprant', 'Aspirina');

UPDATE public.medicamentos
SET alertas_clinicas = array_cat(alertas_clinicas, ARRAY['Anticonvulsivante', 'No suspender bruscamente', 'Puede requerir monitoreo sérico']),
    nivel_riesgo = CASE WHEN nivel_riesgo = 'normal' THEN 'precaucion' ELSE nivel_riesgo END
WHERE familia_terapeutica = 'Anticonvulsivantes';

UPDATE public.medicamentos
SET alertas_clinicas = array_cat(alertas_clinicas, ARRAY['Cardiovascular', 'Requiere control clínico y presión/función renal según caso']),
    nivel_riesgo = CASE WHEN nivel_riesgo = 'normal' THEN 'precaucion' ELSE nivel_riesgo END
WHERE familia_terapeutica = 'Cardiovasculares';

UPDATE public.medicamentos
SET alertas_clinicas = array_cat(alertas_clinicas, ARRAY['Antídoto/Emergencia', 'Uso bajo criterio veterinario urgente']),
    nivel_riesgo = CASE WHEN nivel_riesgo = 'normal' THEN 'alto' ELSE nivel_riesgo END
WHERE familia_terapeutica = 'Antídotos / Emergencias';

UPDATE public.medicamentos
SET alertas_clinicas = array_cat(alertas_clinicas, ARRAY['Antibiótico', 'Usar con diagnóstico y criterio veterinario', 'Evitar uso empírico prolongado']),
    nivel_riesgo = CASE WHEN nivel_riesgo = 'normal' THEN 'precaucion' ELSE nivel_riesgo END
WHERE familia_terapeutica = 'Antibióticos / Antimicrobianos';

UPDATE public.medicamentos
SET alertas_clinicas = array_cat(alertas_clinicas, ARRAY['Glucocorticoide', 'No combinar con AINEs', 'Evitar suspensión brusca en tratamientos prolongados']),
    nivel_riesgo = CASE WHEN nivel_riesgo = 'normal' THEN 'precaucion' ELSE nivel_riesgo END
WHERE nombre IN ('Prednisona', 'Prednisolona', 'Dexametasona', 'Metilprednisolona');

UPDATE public.medicamentos
SET alertas_clinicas = array_cat(alertas_clinicas, ARRAY['Endocrino', 'Requiere monitoreo clínico/laboratorial']),
    nivel_riesgo = CASE WHEN nivel_riesgo = 'normal' THEN 'precaucion' ELSE nivel_riesgo END
WHERE familia_terapeutica = 'Endocrinos';

UPDATE public.medicamentos
SET alertas_clinicas = array_cat(alertas_clinicas, ARRAY['Uso tópico/ocular', 'No calcular como dosis sistémica salvo indicación específica']),
    nivel_riesgo = CASE WHEN nivel_riesgo = 'normal' THEN 'precaucion' ELSE nivel_riesgo END
WHERE via_administracion ILIKE '%Tópica%'
   OR via_administracion ILIKE '%ocular%'
   OR familia_terapeutica = 'Oftálmicos';

-- Normalizar duplicados de alertas generados por array_cat en updates sucesivos.
UPDATE public.medicamentos
SET alertas_clinicas = (
  SELECT ARRAY(SELECT DISTINCT alerta FROM unnest(alertas_clinicas) AS alerta ORDER BY alerta)
);
