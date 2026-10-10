# Task: Contraste, coherencia rosa y calculadora sin protocolos

## Contexto (feedback real de la usuaria)
- Letras muy pálidas, casi no se ven (contraste bajo).
- La calculadora tenía "Protocolos predefinidos" innecesarios.
- La calculadora tenía bugs visuales (restos del tema azul mezclados con el rosa).
- Datos "Sin dato" aún incompletos en ciertos medicamentos.

## Cambios (commit 0890b6a)
1. **Contraste** (src/index.css): oscurecer `--gray-400` #B89BB4→#8A6A86, `--gray-500` #8A6F85→#6E556A, `--gray-600` #6B5567→#56424E, `--ink-soft` #7A6480→#5C4558.
2. **Quitar protocolos** (CalculadoraPage.jsx): eliminar `PROTOCOLOS`, `handleUsarPasoProtocolo`, JSX `calc-protocolos`; CSS muerto en pages.css.
3. **Coherencia rosa** (pages.css): 30 reemplazos de azules (#f0f7ff, #bfdbfe, #dbeafe, #eff6ff, #f8fafc, rgba(37,99,235)…) por pasteles del tema (var(--primary-soft), var(--gray-*), rgba(244,114,182)).
4. **Resultado destaca** (pages.css): nueva `.resultado-card` hero (gradiente rosa, borde izquierdo rosa, shadow-pink).

## Verificación
- `npm run build` limpio (sin errores).
- Cero referencias a protocolos en src/.
- Net +80/−229 líneas.

## Pendiente conocido
- "Sin dato" en Precauciones/Embarazo/Alertas de algunos fármacos: presentación discreta; completar con datos veterinarios reales cuando estén disponibles (no inventar).
