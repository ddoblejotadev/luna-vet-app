# Ficha del medicamento y campos veterinarios

**Objetivo:** ficha detallada del medicamento con principio activo y más campos veterinarios.

**Estado:** done
**Inicio:** 2026-10-09
**Fin:** 2026-10-09
**Branch:** feature/auth-history

## Alcance

- Agregar `indicaciones`, `laboratorio`, `conservacion`, `clasificacion`, `registro_sag` y `registro_senasa` al catálogo.
- Crear la ruta `/medicamentos/:id` con identificación, dosis/uso clínico, especies, alertas, registros y fuente.
- Enlazar el catálogo con la ficha y la ficha con la calculadora preseleccionando el fármaco.
- Ampliar la búsqueda multicampo a `indicaciones`.

## No alcance

- No cambiar RLS.
- No completar números de registro SAG/SENASA sin verificación oficial: quedan `null` como "Pendiente de verificación".
- No hacer deploy.

## Tareas

- [x] Crear migración de campos veterinarios para ficha.
- [x] Crear ruta y página de ficha de medicamento.
- [x] Enlazar catálogo con ficha y búsqueda ampliada.
- [x] Verificar build y consultas representativas.
- [x] Actualizar ODD/memoria y commit/push.

## Evidencia

- Migración: `supabase/migrations/202610080005_ficha_medicamento_campos_veterinarios.sql` aplicada en local.
- Ruta nueva `/medicamentos/:id` (`src/pages/MedicamentoDetallePage.jsx`) con identificación, dosis/uso clínico, especies, alertas, registros y fuente.
- Catálogo enlaza nombre y botón "Ver ficha"; la ficha tiene botón "Calcular dosis" con preselect del fármaco (`/calculadora?medicamento=<id>`).
- Búsqueda ampliada a `indicaciones`.
- REST verificado: Paracetamol/Grapiprant/Atropina/Vitamina K1 con `indicaciones`, `laboratorio`, `clasificacion`, `conservacion` y `registro_sag`/`registro_senasa` pendientes de verificación oficial.
- `npm run build` OK (433.19 kB JS).
