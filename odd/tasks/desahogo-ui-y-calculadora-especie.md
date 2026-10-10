# Task: Desahogo de UI, calculadora por especie y Home accionable

## Contexto (feedback real de la usuaria)
- La ficha del medicamento tiene ~10 secciones en scroll largo → sobrecarga.
- La calculadora no pregunta especie (perro vs gato): las dosis suelen diferir.
- El Home no es interactivo: cuesta encontrar dónde buscar medicamentos y muestra cosas innecesarias primero.

## Decisiones tomadas
- Ficha en **acordeón**: visibles por defecto solo Dosis destacada + Presentaciones + Calculadora rápida.
- Integraciones livianas: conversor de unidades, alertas de interacción, vistos recientemente.

## Tareas
1. [ ] Ficha en acordeón + quitar caja "Resumen para estudio"
2. [ ] Selector de especie en calculadoras (embebida y página) + modelo `dosis_por_especie` + seed de fármacos clave
3. [ ] Home interactivo: buscador prominente, familias clicables, vistos recientemente
4. [ ] Vistos recientemente (localStorage)
5. [ ] Conversor de unidades (tab Infusión: mcg/kg/min ↔ mL/h)
6. [ ] Alertas de interacción (data estática + banner en ficha y calculadora)
7. [ ] Build + commit + push

## Criterios de cierre
- Build limpio
- Ficha con acordeón funcional
- Calculadora usa rango por especie cuando existe dato (si no, rango general + aviso)
- Home con buscador que lleva a /medicamentos?q=...
- Deploy en Netlify
