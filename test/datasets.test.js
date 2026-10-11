import { describe, it, expect } from 'vitest'
import { formatearFrecuencia, formatearConcentracion } from '../src/utils/formatos.js'
import { CURACION_CLINICA } from '../src/data/curacion_clinica.js'
import { CURACION_COMPLEMENTARIA } from '../src/data/curacion_complementaria.js'
import { INTERACCIONES_CRITICAS, interaccionesPara } from '../src/data/interacciones.js'
import dosisEspecie from '../src/data/dosis_especie.json'

describe('Formateadores', () => {
  describe('formatearFrecuencia', () => {
    it('formatea dosis única', () => {
      expect(formatearFrecuencia(0)).toBe('Dosis única')
    })

    it('formatea cada 24 horas', () => {
      expect(formatearFrecuencia(24)).toBe('Cada 24 horas (1 vez/día)')
    })

    it('formatea horas <24', () => {
      expect(formatearFrecuencia(6)).toBe('Cada 6 horas')
      expect(formatearFrecuencia(12)).toBe('Cada 12 horas')
    })

    it('formatea múltiplos de 24 como días', () => {
      expect(formatearFrecuencia(48)).toBe('Cada 48 horas')
      expect(formatearFrecuencia(72)).toBe('Cada 72 horas')
      expect(formatearFrecuencia(96)).toBe('Cada 4 días')
    })

    it('maneja null/undefined', () => {
      expect(formatearFrecuencia(null)).toBe('')
      expect(formatearFrecuencia(undefined)).toBe('')
    })
  })

  describe('formatearConcentracion', () => {
    it('mantiene concentraciones por volumen', () => {
      expect(formatearConcentracion('10 mg/ml')).toBe('10 mg/ml')
      expect(formatearConcentracion('1000 µg/ml')).toBe('1000 µg/ml')
      expect(formatearConcentracion('0.9%')).toBe('0.9%')
      expect(formatearConcentracion('50 mg/vial')).toBe('50 mg/vial')
    })

    it('agrega "por unidad" a dosis sólidas', () => {
      expect(formatearConcentracion('250 mg')).toBe('250 mg por unidad')
      expect(formatearConcentracion('1 g')).toBe('1 g por unidad')
      expect(formatearConcentracion('10-20 mg')).toBe('10-20 mg por unidad')
    })

    it('maneja casos especiales', () => {
      expect(formatearConcentracion('Variable')).toBe('Variable')
      expect(formatearConcentracion('400/80 mg')).toBe('400/80 mg')
    })

    it('maneja null/undefined', () => {
      expect(formatearConcentracion(null)).toBe('')
      expect(formatearConcentracion(undefined)).toBe('')
    })
  })
})

describe('Dataset dosis_especie.json', () => {
  it('tiene la estructura canónica esperada', () => {
    expect(Array.isArray(dosisEspecie)).toBe(true)
    expect(dosisEspecie.length).toBeGreaterThan(200)

    for (const item of dosisEspecie) {
      const [nombre, dosis, permitidas, contraindicadas] = item
      expect(typeof nombre).toBe('string')
      expect(nombre.length).toBeGreaterThan(0)
      expect(typeof dosis).toBe('object')
      expect(Array.isArray(permitidas)).toBe(true)
      // contraindicadas es opcional
      if (contraindicadas !== undefined && contraindicadas !== null) {
        expect(Array.isArray(contraindicadas)).toBe(true)
      }
    }
  })

  it('todas las dosis son arrays [min, max] válidos', () => {
    for (const [nombre, dosis] of dosisEspecie) {
      for (const [especie, [min, max]] of Object.entries(dosis)) {
        expect(typeof min).toBe('number')
        expect(typeof max).toBe('number')
        expect(min).toBeGreaterThan(0)
        expect(max).toBeGreaterThanOrEqual(min)
      }
    }
  })

  it('el formato transformado {Especie: {min, max}} es válido', () => {
    for (const [nombre, dosis] of dosisEspecie) {
      const transformado = {}
      for (const [esp, [min, max]] of Object.entries(dosis)) {
        transformado[esp] = { min, max }
      }
      // Fármacos tópicos/oftálmicos/inhalatorios tienen dosis vacía {} — es válido
      if (Object.keys(dosis).length === 0) {
        expect(Object.keys(transformado).length).toBe(0)
        continue
      }
      // Los que tienen dosis deben producir objetos {min, max} válidos
      for (const [esp, v] of Object.entries(transformado)) {
        expect(typeof v.min, `${nombre} ${esp} min`).toBe('number')
        expect(typeof v.max, `${nombre} ${esp} max`).toBe('number')
        expect(v.max, `${nombre} ${esp} max>=min`).toBeGreaterThanOrEqual(v.min)
      }
    }
  })
})

describe('Dataset curacion_clinica.js', () => {
  it('todos los fármacos tienen nombre y mecanismo', () => {
    for (const fila of CURACION_CLINICA) {
      const [nombre, mecanismo] = fila
      expect(typeof nombre).toBe('string')
      expect(nombre.length).toBeGreaterThan(0)
      expect(typeof mecanismo).toBe('string')
      expect(mecanismo.length).toBeGreaterThan(10) // evita textos genéricos
    }
  })

  it('frecuencia_horas es null o numérica ≥0', () => {
    for (const fila of CURACION_CLINICA) {
      const frecuencia = fila[3]
      if (frecuencia !== null) {
        expect(typeof frecuencia).toBe('number')
        expect(frecuencia).toBeGreaterThanOrEqual(0)
      }
    }
  })

  it('dosis min ≤ max cuando ambas existen', () => {
    for (const fila of CURACION_CLINICA) {
      const [nombre, , , , , dosisMin, dosisMax] = fila
      if (dosisMin !== null && dosisMax !== null) {
        expect(dosisMax).toBeGreaterThanOrEqual(dosisMin)
      }
    }
  })
})

describe('Dataset curacion_complementaria.js', () => {
  it('tiene la misma estructura que curacion_clinica (7 campos, sin duracion)', () => {
    for (const fila of CURACION_COMPLEMENTARIA) {
      expect(Array.isArray(fila)).toBe(true)
      expect(fila.length).toBe(7)
      const [nombre] = fila
      expect(typeof nombre).toBe('string')
      expect(nombre.length).toBeGreaterThan(0)
    }
  })
})

describe('Dataset interacciones.js', () => {
  it('todas las interacciones tienen nivel crítico o alto', () => {
    for (const int of INTERACCIONES_CRITICAS) {
      expect(['critico', 'alto']).toContain(int.nivel)
      expect(typeof int.a).toBe('string')
      expect(typeof int.b).toBe('string')
      expect(typeof int.efecto).toBe('string')
      expect(int.efecto.length).toBeGreaterThan(10)
    }
  })

  it('interaccionesPara devuelve array', () => {
    const result = interaccionesPara('acepromazina')
    expect(Array.isArray(result)).toBe(true)
  })
})
