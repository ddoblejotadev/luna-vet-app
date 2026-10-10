-- Consolidacion de duplicados exactos por nombre normalizado.
-- Conserva la fila MAS COMPLETA (mas campos no nulos); desempata por id menor.
-- Seguro: los unicos nombres exactamente repetidos son Atropina x3 y Sucralfato x2.

WITH ranked AS (
  SELECT id,
    ROW_NUMBER() OVER (
      PARTITION BY lower(trim(nombre))
      ORDER BY (
        (dosis_recomendada IS NOT NULL)::int
        + (indicaciones IS NOT NULL)::int
        + (efectos_secundarios IS NOT NULL)::int
        + (contraindicaciones IS NOT NULL)::int
        + (notas IS NOT NULL)::int
        + (fuente IS NOT NULL)::int
        + (dosis_minima_mg_kg IS NOT NULL)::int
        + (presentaciones IS NOT NULL)::int
      ) DESC, id ASC
    ) AS rn
  FROM public.medicamentos
)
DELETE FROM public.medicamentos m
USING ranked r
WHERE m.id = r.id AND r.rn > 1;
