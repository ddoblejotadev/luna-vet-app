import { useState, useCallback } from 'react'

/**
 * Hook para calcular dosis de medicamentos
 * Soporta cálculos por peso, superficie corporal, y otros parámetros
 */

export function useDosisCalculator() {
  const [resultado, setResultado] = useState(null)
  const [error, setError] = useState(null)

  /**
   * Calcular dosis por peso (más común)
   * @param {number} peso - Peso del animal en kg
   * @param {number} dosisPorKg - Dosis recomendada por kg
   * @param {number} frecuencia - Cada cuántas horas
   * @returns {object} Resultado del cálculo
   */
  const calcularPorPeso = useCallback((peso, dosisPorKg, frecuencia = 12) => {
    try {
      if (peso <= 0 || dosisPorKg <= 0) {
        throw new Error('El peso y la dosis deben ser positivos')
      }

      const dosisSingle = peso * dosisPorKg
      const dosisDaily = dosisSingle * (24 / frecuencia)

      const resultado = {
        dosisSingle: Number(dosisSingle.toFixed(2)),
        dosisDaily: Number(dosisDaily.toFixed(2)),
        frecuencia,
        unidad: 'mg',
        notas: `Administrar ${dosisSingle.toFixed(2)}mg cada ${frecuencia} horas`,
      }

      setResultado(resultado)
      setError(null)
      return resultado
    } catch (err) {
      const errorMsg = err.message || 'Error al calcular dosis'
      setError(errorMsg)
      setResultado(null)
      throw err
    }
  }, [])

  /**
   * Calcular rango de dosis por peso desde una dosis mínima y máxima del catálogo.
   * @param {number} peso - Peso del animal en kg
   * @param {number} dosisMinPorKg - Dosis mínima recomendada por kg
   * @param {number} dosisMaxPorKg - Dosis máxima recomendada por kg
   * @param {number} frecuencia - Cada cuántas horas
   * @returns {object} Resultado del cálculo
   */
  const calcularRangoPorPeso = useCallback((peso, dosisMinPorKg, dosisMaxPorKg, frecuencia = 12) => {
    try {
      if (peso <= 0 || dosisMinPorKg <= 0 || dosisMaxPorKg <= 0) {
        throw new Error('El peso y las dosis deben ser positivos')
      }

      if (dosisMinPorKg > dosisMaxPorKg) {
        throw new Error('La dosis mínima no puede superar la dosis máxima')
      }

      const dosisMinSingle = peso * dosisMinPorKg
      const dosisMaxSingle = peso * dosisMaxPorKg
      const administracionesDiarias = 24 / frecuencia
      const dosisMinDaily = dosisMinSingle * administracionesDiarias
      const dosisMaxDaily = dosisMaxSingle * administracionesDiarias

      const resultado = {
        tipo: 'rango',
        dosisMinSingle: Number(dosisMinSingle.toFixed(2)),
        dosisMaxSingle: Number(dosisMaxSingle.toFixed(2)),
        dosisMinDaily: Number(dosisMinDaily.toFixed(2)),
        dosisMaxDaily: Number(dosisMaxDaily.toFixed(2)),
        dosisMinPorKg,
        dosisMaxPorKg,
        frecuencia,
        unidad: 'mg',
        notas: `Administrar ${dosisMinSingle.toFixed(2)}-${dosisMaxSingle.toFixed(2)}mg cada ${frecuencia} horas`,
      }

      setResultado(resultado)
      setError(null)
      return resultado
    } catch (err) {
      const errorMsg = err.message || 'Error al calcular rango de dosis'
      setError(errorMsg)
      setResultado(null)
      throw err
    }
  }, [])

  /**
   * Calcular dosis por superficie corporal (BSA)
   * Fórmula: BSA (m²) = (Peso en kg ^ 0.67) × 10.1 / 1000
   */
  const calcularPorBSA = useCallback((peso, dosisPerBSA) => {
    try {
      if (peso <= 0 || dosisPerBSA <= 0) {
        throw new Error('El peso y la dosis deben ser positivos')
      }

      const bsa = (Math.pow(peso, 0.67) * 10.1) / 1000
      const dosisSingle = bsa * dosisPerBSA

      const resultado = {
        bsa: Number(bsa.toFixed(4)),
        dosisSingle: Number(dosisSingle.toFixed(2)),
        unidad: 'mg',
        notas: `BSA: ${bsa.toFixed(4)}m² - Dosis: ${dosisSingle.toFixed(2)}mg`,
      }

      setResultado(resultado)
      setError(null)
      return resultado
    } catch (err) {
      const errorMsg = err.message || 'Error al calcular dosis por BSA'
      setError(errorMsg)
      setResultado(null)
      throw err
    }
  }, [])

  /**
   * Calcular dosis con margen de seguridad
   */
  const calcularConMargen = useCallback((peso, dosisPorKg, margenPorcentaje = 10) => {
    try {
      const base = peso * dosisPorKg
      const margen = base * (margenPorcentaje / 100)

      const resultado = {
        dosisBase: Number(base.toFixed(2)),
        margenAlt: Number((base - margen).toFixed(2)),
        margenAlto: Number((base + margen).toFixed(2)),
        margenPorcentaje,
        unidad: 'mg',
        notas: `Rango: ${(base - margen).toFixed(2)} - ${(base + margen).toFixed(2)}mg (±${margenPorcentaje}%)`,
      }

      setResultado(resultado)
      setError(null)
      return resultado
    } catch (err) {
      const errorMsg = err.message || 'Error al calcular dosis con margen'
      setError(errorMsg)
      setResultado(null)
      throw err
    }
  }, [])

  const resetear = useCallback(() => {
    setResultado(null)
    setError(null)
  }, [])

  return {
    resultado,
    error,
    calcularPorPeso,
    calcularRangoPorPeso,
    calcularPorBSA,
    calcularConMargen,
    resetear,
  }
}
