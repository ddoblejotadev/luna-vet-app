# Task: Desahogo de UI, calculadora por especie y Home accionable

## Contexto (feedback real de la usuaria)
- La ficha del medicamento tiene ~10 secciones en scroll largo → sobrecarga.
- La calculadora no pregunta especie (perro vs gato): las dosis suelen diferir.
- El Home no es interactivo: cuesta encontrar dónde buscar medicamentos y muestra cosas innecesarias primero.

## Decisiones tomadas
- Ficha en **acordeón**: visibles por defecto solo Dosis destacada + Presentaciones + Calculadora rápida.
- Integraciones livianas: conversor de unidades, alertas de interacción, vistos recientemente.

## Tareas
1. [x] Ficha en acordeón + quitar caja "Resumen para estudio" y "Uso para estudio"
2. [x] Selector de especie en calculadoras (embebida y página) + modelo `dosis_por_especie` + seed de fármacos clave
3. [x] Home interactivo: buscador prominente, familias clicables, vistos recientemente
4. [x] Vistos recientemente (localStorage `lunavet_recent_meds`, máx 5)
5. [x] Conversor de unidades (tab Infusión: mcg/kg/min ↔ mL/h)
6. [x] Alertas de interacción (data estática + banner en ficha y calculadora)
7. [x] Build + commit + push

## Evidencia de cierre (commits en master)
- `6d99062` feat(ui): desahogo de interfaz, calculadora CRI e historial de vistos
- `4aa031e` feat(ui): rediseño mobile-first de la ficha de medicamento
- `20aacbc` fix(ficha): quitar caja 'Uso para estudio' y corregir migración de datos
- `5834efe` fix(data): migración correctiva por nombres reales de la DB viva
- `0c709ee` fix(data): envolver migración correctiva en transacción atómica

## Migración DB viva (project ybzojpypjkgitxcawmxe)
- `20261011_completar_datos_medicamentos.sql` aplicada vía `supabase db push`
- `202610110002_completar_datos_correcciones.sql` (Enrofloxacina 10%, Vitamina B12) aplicada
- Resultado verificado: 12 fármacos con farmacocinética, 7 con dosis_por_especie
- Token Supabase guardado en `~/.bashrc` como SUPABASE_ACCESS_TOKEN

## Criterios de cierre
- Build limpio
- Ficha con acordeón funcional
- Calculadora usa rango por especie cuando existe dato (si no, rango general + aviso)
- Home con buscador que lleva a /medicamentos?q=...
- Deploy en Netlify
