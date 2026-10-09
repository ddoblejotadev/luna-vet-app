-- Add study-oriented medication fields for veterinary learning fichas.
-- These fields are educational summaries, not official registry data.

ALTER TABLE public.medicamentos
ADD COLUMN IF NOT EXISTS composicion TEXT,
ADD COLUMN IF NOT EXISTS mecanismo_accion TEXT,
ADD COLUMN IF NOT EXISTS uso_estudio TEXT;

UPDATE public.medicamentos
SET composicion = COALESCE(
  composicion,
  CASE
    WHEN principio_activo IS NOT NULL AND concentracion IS NOT NULL THEN principio_activo || ' — ' || concentracion
    WHEN principio_activo IS NOT NULL THEN principio_activo
    ELSE nombre
  END
);

UPDATE public.medicamentos
SET mecanismo_accion = COALESCE(
  mecanismo_accion,
  CASE familia_terapeutica
    WHEN 'Analgésicos y Antiinflamatorios' THEN 'Modula mediadores de dolor e inflamación. En AINEs, el efecto suele relacionarse con inhibición de ciclooxigenasas y reducción de prostaglandinas; verificar selectividad y seguridad por especie.'
    WHEN 'Antibióticos' THEN 'Inhibe procesos bacterianos esenciales. El sitio de acción depende de la clase: pared celular, síntesis proteica, ADN/ARN o metabolismo bacteriano.'
    WHEN 'Antiparasitarios' THEN 'Interfiere con funciones vitales de parásitos internos o externos, como transmisión neuromuscular, metabolismo energético o desarrollo parasitario.'
    WHEN 'Cardiovasculares' THEN 'Modifica función cardiovascular según clase: contractilidad, frecuencia, presión arterial, resistencia vascular, volumen circulante o remodelado cardíaco.'
    WHEN 'Anestésicos y Sedantes' THEN 'Produce sedación, analgesia, anestesia o relajación mediante modulación del sistema nervioso central o bloqueo de conducción nerviosa.'
    WHEN 'Endocrinos' THEN 'Modula ejes hormonales o reemplaza/inhibe hormonas para corregir alteraciones endocrinas.'
    WHEN 'Gastrointestinales' THEN 'Actúa sobre secreción ácida, motilidad, náusea, vómito, mucosa gastrointestinal o microbiota según la clase farmacológica.'
    WHEN 'Dermatológicos' THEN 'Actúa sobre inflamación, infección, prurito, barrera cutánea o parásitos externos según el principio activo.'
    WHEN 'Oftálmicos' THEN 'Actúa localmente en estructuras oculares; puede modificar presión intraocular, inflamación, infección o lubricación.'
    WHEN 'Antihistamínicos' THEN 'Bloquea o reduce efectos mediados por histamina, especialmente prurito, edema y reacciones alérgicas leves.'
    WHEN 'Antifúngicos' THEN 'Inhibe estructuras o procesos fúngicos, con frecuencia síntesis de ergosterol o integridad de membrana celular.'
    WHEN 'Antivirales' THEN 'Interfiere con replicación viral o síntesis de ácidos nucleicos virales; su utilidad depende del virus y del momento de tratamiento.'
    WHEN 'Oncológicos' THEN 'Interfiere con proliferación celular, señalización tumoral o replicación de células neoplásicas; requiere manejo oncológico estricto.'
    WHEN 'Neurológicos' THEN 'Modula excitabilidad neuronal, neurotransmisión o dolor neuropático según el principio activo.'
    WHEN 'Antídotos y Emergencia' THEN 'Revierte, antagoniza o mitiga efectos tóxicos o farmacológicos en situaciones de urgencia.'
    WHEN 'Vitaminas y Suplementos' THEN 'Aporta nutrientes, cofactores o soporte metabólico/articular; no reemplaza diagnóstico ni tratamiento específico cuando corresponde.'
    ELSE 'Mecanismo de acción dependiente del principio activo y la clase terapéutica. Verificar bibliografía veterinaria antes de uso clínico.'
  END
);

UPDATE public.medicamentos
SET uso_estudio = COALESCE(
  uso_estudio,
  'Para estudiar: identificar familia terapéutica, principio activo, especie segura, rango de dosis, vía, frecuencia, contraindicaciones, interacciones y alertas clínicas antes de calcular o administrar.'
);

UPDATE public.medicamentos
SET contraindicaciones = COALESCE(
  contraindicaciones,
  CASE
    WHEN especies_contraindicadas IS NOT NULL AND array_length(especies_contraindicadas, 1) > 0
      THEN 'Contraindicado en: ' || array_to_string(especies_contraindicadas, ', ') || '. Ver alertas clínicas específicas.'
    WHEN nivel_riesgo IN ('alto', 'critico')
      THEN 'Uso solo con criterio veterinario estricto. Revisar especie, estado clínico, comorbilidades y medicación concomitante.'
    ELSE 'No usar sin indicación veterinaria. Verificar alergias, gestación/lactancia, edad, función hepática/renal y especie antes de administrar.'
  END
);

UPDATE public.medicamentos
SET efectos_secundarios = COALESCE(
  efectos_secundarios,
  CASE familia_terapeutica
    WHEN 'Analgésicos y Antiinflamatorios' THEN 'Posibles efectos gastrointestinales, renales o hepáticos según el fármaco; vigilar vómitos, diarrea, inapetencia, melena o letargo.'
    WHEN 'Antibióticos' THEN 'Puede producir vómitos, diarrea, disbiosis, hipersensibilidad o alteraciones específicas de clase.'
    WHEN 'Antiparasitarios' THEN 'Puede producir signos gastrointestinales, cutáneos o neurológicos según especie, dosis y sensibilidad individual.'
    WHEN 'Cardiovasculares' THEN 'Puede producir hipotensión, bradicardia, alteraciones electrolíticas, debilidad o signos de bajo gasto según clase.'
    WHEN 'Anestésicos y Sedantes' THEN 'Puede producir depresión cardiorrespiratoria, hipotermia, hipotensión, bradicardia o recuperación prolongada.'
    WHEN 'Endocrinos' THEN 'Puede producir cambios de apetito, peso, conducta, hidratación o signos relacionados con exceso/defecto hormonal.'
    WHEN 'Gastrointestinales' THEN 'Puede producir diarrea, constipación, cambios de apetito, sedación o efectos dependientes de motilidad/secreción.'
    WHEN 'Dermatológicos' THEN 'Puede producir irritación local, prurito, reacciones cutáneas o efectos sistémicos si se absorbe o ingiere.'
    WHEN 'Oftálmicos' THEN 'Puede producir irritación ocular, lagrimeo, hiperemia, blefaroespasmo o cambios de presión intraocular según fármaco.'
    WHEN 'Antihistamínicos' THEN 'Puede producir sedación, sequedad de mucosas, excitación paradójica o signos gastrointestinales.'
    WHEN 'Antifúngicos' THEN 'Puede producir signos gastrointestinales y, según fármaco, hepatotoxicidad o interacciones relevantes.'
    WHEN 'Antivirales' THEN 'Puede producir signos gastrointestinales, alteraciones hematológicas o renales según fármaco y especie.'
    WHEN 'Oncológicos' THEN 'Puede producir mielosupresión, vómitos, diarrea, anorexia, alopecia o toxicidades órgano-específicas; requiere monitoreo.'
    WHEN 'Neurológicos' THEN 'Puede producir sedación, ataxia, cambios de conducta, debilidad o efectos neurológicos paradójicos.'
    ELSE 'Efectos adversos variables según fármaco, especie, dosis y estado clínico. Consultar referencia veterinaria antes de administrar.'
  END
);

UPDATE public.medicamentos
SET interacciones = COALESCE(
  interacciones,
  CASE familia_terapeutica
    WHEN 'Analgésicos y Antiinflamatorios' THEN 'Evitar combinar AINEs entre sí o con corticoides salvo indicación veterinaria expresa; revisar anticoagulantes, nefrotóxicos y enfermedad renal/hepática.'
    WHEN 'Antibióticos' THEN 'Revisar interacciones por clase: antiácidos/minerales, hepatotoxicidad, nefrotoxicidad, fármacos que prolongan QT o modifican metabolismo hepático.'
    WHEN 'Antiparasitarios' THEN 'Revisar sensibilidad racial/especie, lactonas macrocíclicas, otros antiparasitarios y fármacos que alteren barrera hematoencefálica.'
    WHEN 'Cardiovasculares' THEN 'Revisar combinación con diuréticos, IECA/ARA, beta-bloqueantes, calcioantagonistas, antiarrítmicos y fármacos que modifiquen electrolitos.'
    WHEN 'Anestésicos y Sedantes' THEN 'Potencian depresión con otros sedantes, opioides, anestésicos o depresores del SNC; ajustar por paciente y monitoreo.'
    WHEN 'Endocrinos' THEN 'Revisar interacciones con corticoides, hormonas, fármacos que alteran metabolismo hepático y tratamientos crónicos concomitantes.'
    WHEN 'Gastrointestinales' THEN 'Puede modificar absorción, pH gástrico o motilidad; separar de fármacos sensibles a pH o quelación cuando corresponda.'
    WHEN 'Antifúngicos' THEN 'Alta relevancia de interacciones por metabolismo hepático; revisar antes de combinar con sedantes, cardiovasculares, anticonvulsivantes u oncológicos.'
    WHEN 'Oncológicos' THEN 'Requiere revisión oncológica de interacciones, mielosupresión acumulativa, vacunas vivas, hepatotoxicidad y nefrotoxicidad.'
    ELSE 'Revisar medicación concomitante, enfermedad renal/hepática y referencias veterinarias antes de combinar tratamientos.'
  END
);

UPDATE public.medicamentos
SET notas = COALESCE(
  notas,
  'Ficha educativa para apoyo al estudio. Confirmar dosis, especie, indicación y contraindicaciones con bibliografía veterinaria y criterio profesional.'
);
