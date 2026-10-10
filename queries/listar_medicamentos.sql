SELECT
    nombre,
    familia_terapeutica,
    dosis_recomendada,
    dosis_minima_mg_kg,
    dosis_maxima_mg_kg
FROM medicamentos
WHERE activo = true
ORDER BY familia_terapeutica, nombre;