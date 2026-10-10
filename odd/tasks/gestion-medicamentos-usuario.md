# Gestión de medicamentos por usuario

**Objetivo:** que la novia pueda agregar, editar y eliminar solo los medicamentos que ella crea, sin tocar los medicamentos verificados del dueño.

**Estado:** in_progress
**Inicio:** 2026-10-10
**Branch:** master

## Alcance

- Formulario para agregar medicamentos (con `creado_por = user.id`).
- Botón de eliminar solo en medicamentos propios (`creado_por === user.id`).
- Servicio `deleteMedicamento` en `medicamentosService`.
- Políticas de RLS por creador (ya aplicadas en la DB).

## No alcance

- No editar medicamentos del dueño (solo admins).
- No cambiar la política de lectura pública.

## Tareas

- [ ] Agregar `deleteMedicamento` al servicio.
- [ ] Formulario de creación en MedicamentosPage.
- [ ] Enviar `creado_por = user.id` al crear.
- [ ] Botón de eliminar solo en propios.
- [ ] Verificar build.
- [ ] Commit/push + redeploy.

## Evidencia

- Migración `202610100001_medicamentos_por_creador.sql` aplicada en Supabase.
- Políticas RLS: INSERT/UPDATE/DELETE por `creado_por = auth.uid()`.
