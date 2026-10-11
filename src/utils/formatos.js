// ============================================================================
// Formateadores puros de presentación — compartidos por la ficha y tests.
// ============================================================================

/**
 * Formatea frecuencia en horas a texto legible.
 * 0 = dosis única, 24 = cada 24 horas, múltiplos de 24 = cada N días.
 */
export function formatearFrecuencia(horas) {
  if (horas === null || horas === undefined) return ''
  if (horas === 0) return 'Dosis única'
  if (horas === 24) return 'Cada 24 horas (1 vez/día)'
  if (horas === 48) return 'Cada 48 horas'
  if (horas === 72) return 'Cada 72 horas'
  if (horas < 24) return `Cada ${horas} horas`
  if (horas % 24 === 0) return `Cada ${horas / 24} días`
  return `Cada ${horas} horas`
}

/**
 * Normaliza un número de dosis: "0.0500" | 0.05 -> "0.05", "70.0000" -> "70".
 * Acepta string o number. Devuelve string limpio sin ceros redundantes.
 */
export function formatearDosisNumero(valor) {
  if (valor === null || valor === undefined || valor === '') return ''
  const n = typeof valor === 'number' ? valor : parseFloat(String(valor).replace(',', '.'))
  if (Number.isNaN(n)) return String(valor)
  return String(n)
}

/**
 * Formatea un rango de dosis normalizado: "0.05 – 0.1 mg/kg" o "70 mg/kg" si son iguales.
 */
export function formatearRangoDosis(min, max) {
  const a = formatearDosisNumero(min)
  const b = formatearDosisNumero(max)
  if (!a && !b) return ''
  if (a === b) return `${a} mg/kg`
  if (a && b) return `${a} – ${b} mg/kg`
  return `${a || b} mg/kg`
}

/**
 * Formatea la concentración con claridad pedagógica:
 * - "10 mg/ml" → "10 mg/ml" (ya es concentración por volumen)
 * - "250 mg"   → "250 mg por unidad" (dosis sólida por comprimido/cápsula)
 * - "0.9%"     → "0.9%"
 * - "50 mg/vial" → "50 mg/vial"
 */
export function formatearConcentracion(conc) {
  if (!conc) return ''
  const t = conc.trim()
  // Ya expresa concentración por volumen, peso o tiempo
  if (/mg\/ml|µg\/ml|g\/ml|%|mg\/vial|µg\/h|mg\/h|mg\/g|iu\/ml|u\/ml/i.test(t)) return t
  // Dosis sólida por unidad (comprimido/cápsula/jeringa)
  if (
    /^[0-9]+(?:[.,][0-9]+)?\s*(?:–|-|a|hasta)\s*[0-9]+(?:[.,][0-9]+)?\s*(mg|g|µg|mcg|IU|U)\b/i.test(t)
      || /^[0-9]+(?:[.,][0-9]+)?\s*(mg|g|µg|mcg|IU|U)\b/i.test(t)
  ) {
    return `${t} por unidad`
  }
  return t
}
