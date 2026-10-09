# Modo estudio del catálogo

**Objetivo:** agregar una herramienta simple de repaso para que una alumna de veterinaria estudie medicamentos por flashcards.

**Estado:** done
**Inicio:** 2026-10-09
**Branch:** feature/auth-history

## Alcance

- Página `/estudio` con tarjetas de repaso.
- Usar medicamentos reales del catálogo.
- Preguntas sobre principio activo, familia, composición, mecanismo, dosis, especies y seguridad.
- Permitir mostrar/ocultar respuesta.
- Navegar anterior/siguiente.
- Enlazar ficha completa y calculadora.

## No alcance

- No guardar progreso todavía.
- No ranking ni gamificación.
- No IA generativa.

## Tareas

- [ ] Crear página de modo estudio.
- [ ] Agregar ruta y navegación.
- [ ] Agregar estilos.
- [ ] Verificar build.
- [ ] Commit/push.

## Evidencia

- `src/pages/EstudioPage.jsx` creada con flashcards: principio activo, familia, composición, mecanismo, dosis, seguridad por especie e interacciones.
- Filtros por búsqueda, familia terapéutica y nivel de riesgo.
- Ruta `/estudio` agregada en `src/App.jsx`; enlace en navbar (`src/components/Layout.jsx`).
- Estilos de modo estudio en `src/pages/pages.css`.
- `npm run build` OK (84 módulos, 444.02 kB JS, CSS 18.21 kB).
- Sin nuevas dependencias.
