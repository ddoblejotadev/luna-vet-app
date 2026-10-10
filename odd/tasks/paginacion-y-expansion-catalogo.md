# Task: Paginación, filtros persistentes y expansión del catálogo

## Contexto
La usuaria pidió:
1. Buscar más medicamentos para el catálogo
2. Verificar que la información de la ficha sea correcta
3. Mejorar la ficha (MedicamentoDetallePage)
4. Paginación en MedicamentosPage en vez de renderizado único largo ("scroll infinito")
5. Persistencia del filtro de familia (y demás filtros) al volver atrás desde una ficha

## Diagnóstico
- `MedicamentosPage.jsx`: trae todos los activos (`getAllMedicamentos`) y los renderiza en un solo grid; los filtros viven en `useState` local → se pierden al desmontar.
- `MedicamentoDetallePage.jsx`: ficha con selector de presentaciones y calculadora embebida; falta pulido y verificación de datos.

## Tareas
1. [ ] Paginación en MedicamentosPage (12 por página, controles prev/next + números)
2. [ ] Filtros + búsqueda + página persistidos en URL search params (back del browser restaura familia/especie/riesgo/búsqueda)
3. [ ] Mejoras visuales y de estructura en la ficha (MedicamentoDetallePage)
4. [ ] Verificación cruzada de dosis de fármacos clave (muestra representativa)
5. [ ] Investigar y cargar fármacos veterinarios comunes faltantes (seed SQL)
6. [ ] Build + commit + push

## Evidencia de cierre
- Build limpio (`npm run build`)
- Paginación funcional con URLs `?page=N&familia=...`
- Volver atrás restaura filtros
- Seed SQL aplicado y verificado en DB
- Commits en master
