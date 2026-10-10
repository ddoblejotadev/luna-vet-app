// Interacciones críticas fármaco-fármaco para alerta rápida en la UI.
// Fuentes: Plumb's Veterinary Drug Handbook (10ª ed.); Lumb & Jones' Veterinary
// Anesthesia and Analgesia; BSAVA Small Animal Formulary.
// Niveles: 'critico' (evitar combinar) | 'alto' (precaución + monitoreo).

export const INTERACCIONES_CRITICAS = [
  {
    a: 'acepromazina',
    b: 'epinefrina',
    nivel: 'critico',
    efecto:
      'La acepromazina (alfa-bloqueante) revierte el efecto presor de la epinefrina: riesgo de hipotensión severa. No combinar.',
  },
  {
    a: 'ketamina',
    b: 'acepromazina',
    nivel: 'alto',
    efecto:
      'Posible excitación e hipertermia con la combinación; monitorear temperatura y profundidad de sedación.',
  },
  {
    a: 'isoflurano',
    b: 'morfina',
    nivel: 'alto',
    efecto:
      'Depresión respiratoria aditiva; reducir la dosis de morfina y vigilar la ventilación.',
  },
  {
    a: 'propofol',
    b: 'morfina',
    nivel: 'alto',
    efecto:
      'Depresión respiratoria aditiva en la inducción; titular lentamente y asistir la ventilación si es necesario.',
  },
  {
    a: 'xilacina',
    b: 'butorfanol',
    nivel: 'alto',
    efecto:
      'Depresión cardiopulmonar aditiva; usar dosis bajas y monitoreo cardiorrespiratorio constante.',
  },
  {
    a: 'dexmedetomidina',
    b: 'ketamina',
    nivel: 'alto',
    efecto:
      'Depresión cardiopulmonar aditiva; ajustar dosis y vigilar FC, SpO2 y presión arterial.',
  },
  {
    a: 'dexmedetomidina',
    b: 'morfina',
    nivel: 'alto',
    efecto:
      'Bradicardia y depresión respiratoria aditivas; ajustar dosis y vigilar FC y SpO2.',
  },
]

const normalizar = (texto = '') =>
  texto
    .toLowerCase()
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')

/**
 * Devuelve las interacciones conocidas que involucran a este medicamento,
 * con el nombre del otro fármaco de la pareja.
 */
export function interaccionesPara(medicamento) {
  if (!medicamento) return []
  const nombre = normalizar(medicamento.nombre || '')
  const principio = normalizar(medicamento.principio_activo || '')

  return INTERACCIONES_CRITICAS.map(({ a, b, nivel, efecto }) => {
    const tocaA = nombre.includes(a) || principio.includes(a)
    const tocaB = nombre.includes(b) || principio.includes(b)
    if (!tocaA && !tocaB) return null
    return {
      nivel,
      efecto,
      otros: tocaA ? b : a,
    }
  }).filter(Boolean)
}
