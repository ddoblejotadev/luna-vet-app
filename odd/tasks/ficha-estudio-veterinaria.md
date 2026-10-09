# Ficha de estudio veterinario

**Objetivo:** convertir la ficha del medicamento en un recurso educativo útil para una alumna de veterinaria, manteniendo la seguridad clínica.

**Estado:** done
**Inicio:** 2026-10-09
**Branch:** feature/auth-history

## Alcance

- Agregar composición derivada de principio activo y concentración.
- Agregar mecanismo de acción y uso para estudio por familia terapéutica.
- Mostrar contraindicaciones, efectos secundarios, interacciones y notas educativas.
- Mantener registros SAG/SENASA como "Pendiente de verificación".

## No alcance

- No inventar registros oficiales.
- No reemplazar bibliografía veterinaria.
- No agregar funciones de receta ni firma digital.

## Tareas

- [x] Definir campos educativos.
- [x] Crear migraciones 0006 y 0007.
- [x] Actualizar UI de ficha.
- [x] Verificar build y REST.
- [x] Commit/push.

## Evidencia

- Migraciones `supabase/migrations/202610080006_ficha_estudio_medicamentos.sql` y `202610080007_ficha_estudio_refinada.sql`.
- `MedicamentoDetallePage.jsx` muestra composición, mecanismo, uso de estudio, contraindicaciones, efectos, interacciones y notas.
- REST devuelve campos educativos; Paracetamol muestra composición y mecanismo.
- `npm run build` OK.
- App responde HTTP 200.
