# Tests de regresión para datos clínicos

**Motivación**: el bug de la migración 0014 (nunca aplicada + formato JSON incompatible) pasó desapercibido y dejó la calculadora de dosis por especie sin funcionar en 233/240 fármacos. Estos tests detectan ese class de fallas antes del deploy.

**Objetivo**: verificar, sin tocar la DB, que los datasets canónicos y los formateadores cumplen el contrato que el frontend espera.

## Alcance
- Formateadores (`formatearFrecuencia`, `formatearConcentracion`) — extraídos a `src/utils/formatos.js` para testeo puro.
- `dosis_especie.json`: estructura canónica `[nombre, {Especie: [min,max]}, permitidas, contraindicadas]`.
- Contrato de dosis: la transformación a `{Especie: {min, max}}` produce objetos válidos (min ≤ max, numéricos).
- `curacion_clinica.js` / `curacion_complementaria.js`: campos requeridos por fármaco.
- `interacciones.js`: estructura de pares.

## No alcance
- Tests E2E contra la DB viva (requieren token admin en CI secrets; queda como follow-up).
- Validación clínica de contenido (sección de auditoría clínica).

## Tareas
1. Configurar Vitest + npm test
2. Extraer formateadores a utils y testearlos
3. Validar datasets canónicos
4. Test de contrato de formato dosis_por_especie
5. Integrar tests en CI
6. Build limpio + commit

## Evidencia
- (pendiente) commits
