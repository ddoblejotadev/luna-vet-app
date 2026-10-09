-- Refine study fields to actual therapeutic families already present in the catalog.

UPDATE public.medicamentos
SET
  mecanismo_accion = CASE familia_terapeutica
    WHEN 'Analgésicos / Antiinflamatorios' THEN 'Depende de la clase: los AINEs inhiben ciclooxigenasas y reducen prostaglandinas; otros analgésicos actúan sobre receptores opioides o vías del dolor neuropático. Revisar selectividad y seguridad por especie.'
    WHEN 'Anestésicos Locales' THEN 'Bloquea reversiblemente la conducción nerviosa en el sitio de aplicación, produciendo analgesia regional sin pérdida de conciencia.'
    WHEN 'Antibióticos / Antimicrobianos' THEN 'Inhibe procesos bacterianos esenciales según la clase: síntesis de pared celular, síntesis proteica, ácidos nucleicos o metabolismo bacteriano.'
    WHEN 'Anticonvulsivantes' THEN 'Reduce la excitabilidad neuronal o potencia la inhibición GABAérgica para prevenir o controlar convulsiones.'
    WHEN 'Antídotos / Emergencias' THEN 'Revierte, antagoniza o mitiga efectos tóxicos o farmacológicos en situaciones de urgencia; debe aplicarse con criterio clínico inmediato.'
    WHEN 'Antifúngicos' THEN 'Inhibe la síntesis de ergosterol u otra estructura de membrana fúngica, alterando la integridad celular del hongo.'
    WHEN 'Antihistamínicos / Alérgicos / Dermatológicos' THEN 'Reduce la respuesta mediada por histamina o modula inflamación y prurito; los antifúngicos tópicos actúan directamente sobre la membrana fúngica.'
    WHEN 'Antineoplásicos / Quimioterapia' THEN 'Interfiere con proliferación, señalización o replicación de células neoplásicas; requiere manejo oncológico estricto.'
    WHEN 'Antiparasitarios' THEN 'Interfiere con transmisión neuromuscular, metabolismo energético, desarrollo o funciones vitales del parásito.'
    WHEN 'Antivirales' THEN 'Interfiere con replicación viral o síntesis de ácidos nucleicos virales; la utilidad depende del virus y del momento de tratamiento.'
    WHEN 'Cardiovasculares' THEN 'Modifica contractilidad, frecuencia, presión arterial, resistencia vascular, volumen circulante o remodelado cardíaco según la clase.'
    WHEN 'Conducta / Psicotrópicos' THEN 'Modula neurotransmisión serotoninérgica, dopaminérgica, GABAérgica u otra vía conductual relevante.'
    WHEN 'Endocrinos' THEN 'Modula ejes hormonales o reemplaza/inhibe hormonas para corregir alteraciones endocrinas.'
    WHEN 'Gastrointestinales' THEN 'Actúa sobre secreción ácida, motilidad, náusea, vómito, protección de mucosa o microbiota según la clase farmacológica.'
    WHEN 'Oftálmicos' THEN 'Actúa localmente en estructuras oculares: presión intraocular, inflamación, infección o lubricación.'
    WHEN 'Respiratorios / Broncodilatadores' THEN 'Relaja musculatura lisa de vías respiratorias o reduce inflamación de vías respiratorias.'
    WHEN 'Sedantes y Anestésicos' THEN 'Produce sedación, analgesia, anestesia o relajación mediante modulación del sistema nervioso central o bloqueo de conducción nerviosa.'
    WHEN 'Urológicos' THEN 'Actúa sobre tono de vejiga/esfínteres, presión prostática, flujo urinario o volumen urinario según la clase.'
    WHEN 'Vitaminas y Suplementos' THEN 'Aporta nutrientes, cofactores o soporte metabólico/articular; no reemplaza diagnóstico ni tratamiento específico cuando corresponde.'
    ELSE mecanismo_accion
  END,
  contraindicaciones = CASE
    WHEN especies_contraindicadas IS NOT NULL AND array_length(especies_contraindicadas, 1) > 0
      THEN 'Contraindicado en: ' || array_to_string(especies_contraindicadas, ', ') || '. Ver alertas clínicas específicas.'
    WHEN nivel_riesgo IN ('alto', 'critico')
      THEN 'Uso solo con criterio veterinario estricto. Revisar especie, estado clínico, comorbilidades y medicación concomitante.'
    ELSE 'No usar sin indicación veterinaria. Verificar alergias, gestación/lactancia, edad, función hepática/renal y especie antes de administrar.'
  END,
  interacciones = CASE familia_terapeutica
    WHEN 'Analgésicos / Antiinflamatorios' THEN 'Evitar combinar AINEs entre sí o con corticoides salvo indicación veterinaria expresa; revisar anticoagulantes, nefrotóxicos y enfermedad renal/hepática.'
    WHEN 'Antibióticos / Antimicrobianos' THEN 'Revisar interacciones por clase: antiácidos/minerales, hepatotoxicidad, nefrotoxicidad, fármacos que prolongan QT o modifican metabolismo hepático.'
    WHEN 'Antiparasitarios' THEN 'Revisar sensibilidad racial/especie, lactonas macrocíclicas, otros antiparasitarios y fármacos que alteren barrera hematoencefálica.'
    WHEN 'Cardiovasculares' THEN 'Revisar combinación con diuréticos, IECA/ARA, beta-bloqueantes, calcioantagonistas, antiarrítmicos y fármacos que modifiquen electrolitos.'
    WHEN 'Sedantes y Anestésicos' THEN 'Potencian depresión con otros sedantes, opioides, anestésicos o depresores del SNC; ajustar por paciente y monitoreo.'
    WHEN 'Endocrinos' THEN 'Revisar interacciones con corticoides, hormonas, fármacos que alteran metabolismo hepático y tratamientos crónicos concomitantes.'
    WHEN 'Gastrointestinales' THEN 'Puede modificar absorción, pH gástrico o motilidad; separar de fármacos sensibles a pH o quelación cuando corresponda.'
    WHEN 'Antifúngicos' THEN 'Alta relevancia de interacciones por metabolismo hepático; revisar antes de combinar con sedantes, cardiovasculares, anticonvulsivantes u oncológicos.'
    WHEN 'Antineoplásicos / Quimioterapia' THEN 'Requiere revisión oncológica de interacciones, mielosupresión acumulativa, vacunas vivas, hepatotoxicidad y nefrotoxicidad.'
    WHEN 'Conducta / Psicotrópicos' THEN 'Revisar otros psicofármacos, depresores del SNC, IMAO y fármacos serotoninérgicos antes de combinar.'
    WHEN 'Anticonvulsivantes' THEN 'Revisar otros depresores del SNC, fármacos que modifican metabolismo hepático y cambios de eficacia anticonvulsivante.'
    WHEN 'Antihistamínicos / Alérgicos / Dermatológicos' THEN 'Revisar depresores del SNC, anticolinérgicos y otros fármacos sedantes; los antifúngicos sistémicos tienen interacciones hepáticas.'
    WHEN 'Oftálmicos' THEN 'Revisar otros fármacos oftálmicos, fármacos sistémicos relevantes y suspensión de lentes de contacto según producto.'
    ELSE interacciones
  END;
