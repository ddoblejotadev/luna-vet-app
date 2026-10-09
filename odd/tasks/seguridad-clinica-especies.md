# Seguridad clínica por especie y alertas críticas

**Objetivo:** Hacer que LunaVet distinga especie en la calculadora/catálogo y muestre advertencias clínicas fuertes para fármacos peligrosos o de uso restringido.

**Estado:** done
**Inicio:** 2026-10-09
**Branch:** feature/auth-history

## Alcance

- Agregar metadatos clínicos al catálogo: especies permitidas, especies contraindicadas y alertas/etiquetas de seguridad.
- Filtrar medicamentos por especie en calculadora y catálogo.
- Mostrar alertas fuertes para casos críticos (ej. paracetamol/permethrina en gatos, quimioterapia, uso hospitalario).
- Guardar especie en historial usando la columna existente `historial_calculos.especie_id`.

## No alcance

- No cambiar RLS.
- No agregar roles admin.
- No hacer deploy.
- No generar PDF en esta tarea.
- No cambiar dosis sin una migración explícita y verificable.

## Tareas

- [x] Crear migración con columnas/metadatos clínicos de medicamentos.
- [x] Actualizar servicios para especies y búsqueda/filtros por especie.
- [x] Actualizar Calculadora para seleccionar especie, filtrar opciones y mostrar advertencias.
- [x] Actualizar Catálogo para filtros/badges/alertas.
- [x] Actualizar Historial para mostrar especie.
- [x] Verificar migración, build y consultas representativas.

## Evidencia

- Migración: `supabase/migrations/202610080004_seguridad_clinica_especies.sql` aplicada en local.
- API REST: filtro `especies_permitidas` excluye Paracetamol y Permetrina para Gato; `nivel_riesgo=critico` los devuelve con alertas completas para Perro.
- Búsqueda multicampo verificada con `or(...)` sobre nombre/principio activo/familia/dosis.
- `npm run build` OK (426.83 kB JS).
- Sanitización de búsqueda para evitar romper `or()` de Supabase.
- Historial guarda `especie_id` y muestra la especie en la lista.
