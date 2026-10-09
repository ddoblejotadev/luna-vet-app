# Reporte imprimible/PDF de cálculo

**Objetivo:** permitir generar un reporte clínico imprimible del cálculo de dosis, exportable como PDF desde el navegador.

**Estado:** done
**Inicio:** 2026-10-09
**Branch:** feature/auth-history

## Alcance

- Agregar reporte de cálculo en la calculadora después de calcular.
- Incluir medicamento, principio activo, especie, peso, dosis calculada, frecuencia, alertas clínicas, fuente y fecha.
- Botón para imprimir/guardar como PDF usando `window.print()`.
- Estilos `@media print` para imprimir solo el reporte.

## No alcance

- No agregar librerías PDF pesadas.
- No firmar recetas ni reemplazar criterio veterinario.
- No deploy.

## Tareas

- [x] Crear estructura de reporte en Calculadora.
- [x] Agregar botón imprimir/guardar PDF.
- [x] Agregar estilos print-only.
- [x] Verificar build.
- [x] Commit/push.

## Evidencia

- Componente `src/components/ReporteDosis.jsx` creado.
- `CalculadoraPage` muestra botón `Imprimir / guardar PDF` después de calcular.
- `@media print` en `src/pages/pages.css` imprime solo el reporte clínico.
- Reporte incluye paciente, especie, peso, medicamento, principio activo, resultado, frecuencia, alertas, fuente y disclaimer veterinario.
- `npm run build` OK (437.71 kB JS).
- App responde HTTP 200 en `http://localhost:3000`.
