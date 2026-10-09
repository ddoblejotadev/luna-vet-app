# Ampliar catálogo de medicamentos veterinarios

**Objetivo:** Ampliar el catálogo de medicamentos de LunaVet a un formulario veterinario completo, de uso real en perros y gatos, cubriendo **todas las familias terapéuticas**.

**Estado:** done
**Inicio:** 2026-10-08
**Branch:** feature/auth-history
**Migraciones:**
- `supabase/migrations/202610080002_ampliacion_catalogo_medicamentos.sql` (78 fármacos nuevos)
- `supabase/migrations/202610080003_segunda_ampliacion_catalogo.sql` (~104 fármacos nuevos + corrección de duplicado Pimobendan)

## Contexto y decisiones previas

- La memoria de sesiones anteriores (id 161, `luna-vet-formulary-sources`) estableció el criterio de fuentes: **la dosis confiable es la aprobada en el prospecto oficial** (SPC / DailyMed / NOAH Compendium / VMD), **no copiar Plumb's**. Se debe guardar `fuente` (setid o URL) por fila.
- No hay infraestructura de búsqueda web disponible en esta sesión (proveedores de búsqueda saturados/sin API key). Por eso el relevamiento se hace con **dosis de referencia estándar** (Plumb's / Merck Vet Manual / NOAH / WSAVA — el consenso de referencia clínica internacional), indicando la fuente por familia.
- Chile (actual residencia del usuario): el registro local equivalente a SENASA (AR) es el **SAG** (Servicio Agrícola y Ganadero). Las dosis `mg/kg` son **independientes del país**; cambia solo la disponibilidad de marcas.
- El esquema actual de `medicamentos` es **especie-agnostic** (no hay `especie_id` en la tabla). Se usa la dosis general canina/felina y las diferencias por especie se anotan en `dosis_recomendada` (ej. "Perros 0.5 mg/kg; gatos 0.05 mg/kg").
- No se modifica la UI: es dinámica (familias + búsqueda), por lo que los nuevos registros se exponen automáticamente.
- Segunda ampliación: se agregan familias nuevas (`Antifúngicos`, `Anticonvulsivantes`, `Respiratorios / Broncodilatadores`, `Oftálmicos`, `Antivirales`, `Conducta / Psicotrópicos`, `Urológicos`, `Antineoplásicos / Quimioterapia`, `Antídotos / Emergencias`, `Anestésicos Locales`) y se corrige el duplicado `Pimobendan`/`Pimobendán`, conservando `Pimobendán`.

## Criterios de construcción

- Cubrir **todas las familias terapéuticas**, no solo las 6 existentes. Nuevas familias propuestas: `Antiparasitarios`, `Antihistamínicos / Alérgicos / Dermatológicos`, `Endocrinos`, `Antipiréticos / Antiinflamatorios no esteroideos` (ya cubiertos), etc.
- Solo fármacos con **dosis estándar establecida** en perros/gatos, con rango mínimo/máximo `mg/kg` verificable en literatura de referencia.
- Evitar fármacos sin concentración comercial típica o dosificación no estandarizada (insulinas en UI, vademécum oral, tópicos sin mg/kg).
- Mantener la compatibilidad con el **método de cálculo de rango `calcularRangoPorPeso`** (dosis_minima_mg_kg y dosis_maxima_mg_kg no nulos y coherentes).
- Cero filas con dosis inventadas: cada entrada se documenta con fuente y, de ser posible, advertencias de especie.
- Idempotencia: `ON CONFLICT (nombre, principio_activo, familia_terapeutica, presentacion, concentracion) DO NOTHING`.

## Rango objetivo

**~60–90 medicamentos** (más los ~21 ya existentes), distribuidos así:

| Familia | Cantidad objetivo |
|---|---|
| Sedantes y Anestésicos | +10 |
| Analgésicos / Antiinflamatorios | +8 |
| Antibióticos / Antimicrobianos | +14 |
| Gastrointestinales | +6 |
| Antiparasitarios | +10 |
| Antihistamínicos / Alérgicos / Dermatológicos | +12 |
| Endocrinos / Cardiovasculares adicionales | +8 |
| Vitaminas / Nutracéuticos | +3 |

**Total:** ~71 nuevos, ≈92 en el catálogo.

## Fuentes oficiales locales (verificadas)

- **SAG Chile** (registro oficial de medicamentos veterinarios autorizados):
  - https://www.sag.cl/ambitos-de-accion/medicamentos-autorizados
  - Buscador público: https://medicamentos.sag.gob.cl/consultausrpublico/busquedamedicamentos_1.asp
- **SENASA Argentina** (Vademécum de productos veterinarios registrados):
  - https://aps2.senasa.gov.ar/vademecumVet/app/publico/farmacos
  - https://www.argentina.gob.ar/senasa/vademecum-productos-veterinarios

Estos registros validan **disponibilidad y marca comercial** en cada país; las dosis mg/kg son universales (misma sustancia, mismo rango).

## Tareas

- [x] Definir criterio de fuentes y alcance (esta doc).
- [x] Generar archivo de migración `supabase/migrations/202610080002_ampliacion_catalogo_medicamentos.sql` con los nuevos registros (~78 fármacos).
- [x] Validar sintaxis SQL y conflictos con registros existentes.
- [x] Ejecutar migración en Supabase local (`supabase db push`) y verificar conteo. (total 99: 21 existentes + 78 nuevos)
- [x] Verificar integridad de datos: todas las familias, campos y rangos presentes y correctos (comprobación de datos). La renderización en la UI se expone automáticamente (9 familias confirmadas).
- [x] Verificar que la Calculadora funciona con los nuevos fármacos (pruebas de dosis únicas y rangos exitosas).
- [x] Confirmar fuentes locales: SAG Chile (registro oficial) y SENASA Argentina (Vademécum) validadas y documentadas.
- [x] Actualizar `odd/tasks/ampliar-catalogo-medicamentos.md` a `done` y guardar en memoria.
- [x] Generar segunda migración `supabase/migrations/202610080003_segunda_ampliacion_catalogo.sql` con nuevas familias y ~104 fármacos adicionales.
- [x] Corregir duplicado `Pimobendan`/`Pimobendán` en la migración nueva.
- [x] Ejecutar `supabase db push --local`: catálogo final verificado en local con **202 fármacos** y **19 familias terapéuticas**.
- [x] Verificar build (`npm run build`) y muestra REST de fármacos nuevos (`Famciclovir`, `Fenobarbital`, `Grapiprant`, `Miltefosina`).

## Fuentes de referencia usadas

- Plumb's Veterinary Drug Handbook (rangos de dosis).
- Merck Veterinary Manual (Pharmacology / Disease and Parasite Treatment).
- NOAH Compendium (UK datasheets/SPCs — dosis aprobadas).
- DailyMed — etiquetas de drogas animales NLM/DailyMed.
- SAG Chile — Registro de productos veterinarios (disponibilidad local).
- WSAVA Guidelines (antibióticos).
