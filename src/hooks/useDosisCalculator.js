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
   * @param {number|null} concMgMl - Concentración (opcional) para calcular volumen
   * @returns {object} Resultado del cálculo
   */
  const calcularPorPeso = useCallback((peso, dosisPorKg, frecuencia = 12, concMgMl = null) => {
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

      if (concMgMl && concMgMl > 0) {
        resultado.volumenMl = Number((dosisSingle / concMgMl).toFixed(2))
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
   * @param {number|null} concMgMl - Concentración (opcional) para calcular volumen
   * @returns {object} Resultado del cálculo
   */
  const calcularRangoPorPeso = useCallback((peso, dosisMinPorKg, dosisMaxPorKg, frecuencia = 12, concMgMl = null) => {
    try {
      if (peso <= 0 || dosisMinPorKg <= 0 || dosisMaxPorKg <= 0) {
        throw new Error('El peso y las dosis deben ser positivos')
      }

      const minUnica = peso * dosisMinPorKg
      const maxUnica = peso * dosisMaxPorKg

      const minDiaria = minUnica * (24 / frecuencia)
      const maxDiaria = maxUnica * (24 / frecuencia)

      const resultado = {
        rangoUnico: `${minUnica.toFixed(2)} - ${maxUnica.toFixed(2)} mg`,
        minUnica: Number(minUnica.toFixed(2)),
        maxUnica: Number(maxUnica.toFixed(2)),
        minDiaria: Number(minDiaria.toFixed(2)),
        maxDiaria: Number(maxDiaria.toFixed(2)),
        frecuencia,
        unidad: 'mg',
        notas: `Rango para administración cada ${frecuencia} horas`,
      }

      if (concMgMl && concMgMl > 0) {
        resultado.volumenMinMl = Number((minUnica / concMgMl).toFixed(2))
        resultado.volumenMaxMl = Number((maxUnica / concMgMl).toFixed(2))
      }

      setResultado(resultado)
      setError(null)
      return resultado
    } catch (err) {
      const errorMsg = err.message || 'Error al calcular rango'
      setError(errorMsg)
      setResultado(null)
      throw err
    }
  }, [])

  /**
   * Calcular por Superficie Corporal (BSA) - Muy usado en oncología o perros minis
   * Fórmula simplificada: BSA(m2) = (K * (Peso en kg ^ (2/3))) / 10000 
   * Asumimos perro K=101 por defecto
   * @param {number} peso - Peso del animal en kg
   * @param {number} dosisPorM2 - Dosis por metro cuadrado
   * @param {number|null} concMgMl - Concentración (opcional)
   */
  const calcularPorBSA = useCallback((peso, dosisPorM2, concMgMl = null) => {
    try {
      if (peso <= 0) throw new Error('Peso inválido')
      
      const bsa = (101 * Math.pow((peso * 1000), 2/3)) / 10000
      const dosis = bsa * dosisPorM2
      
      const resultado = {
        bsa: Number(bsa.toFixed(3)),
        dosisSingle: Number(dosis.toFixed(2)),
        unidad: 'mg',
        notas: `BSA calculado: ${bsa.toFixed(3)} m2`,
      }
      
      if (concMgMl && concMgMl > 0) {
        resultado.volumenMl = Number((dosis / concMgMl).toFixed(2))
      }

      setResultado(resultado)
      setError(null)
      return resultado
    } catch (err) {
      setError(err.message)
      setResultado(null)
      throw err
    }
  }, [])

  /**
   * Calculo con margen de seguridad (+/- 10%)
   * @param {number} peso - Peso
   * @param {number} dosisBase - Dosis recomendada
   * @param {number} margen - Porcentaje de margen (ej: 10)
   * @param {number|null} concMgMl - Concentración (opcional)
   */
  const calcularConMargen = useCallback((peso, dosisBase, margen = 10, concMgMl = null) => {
    try {
      if (peso <= 0) throw new Error('Peso inválido')
      
      const dosis = peso * dosisBase
      const variacion = dosis * (margen / 100)
      
      const resultado = {
        dosisIdeal: Number(dosis.toFixed(2)),
        minUnica: Number((dosis - variacion).toFixed(2)),
        maxUnica: Number((dosis + variacion).toFixed(2)),
        unidad: 'mg',
        notas: `Margen aplicado: ±${margen}%`,
      }

      if (concMgMl && concMgMl > 0) {
        resultado.volumenIdealMl = Number((dosis / concMgMl).toFixed(2))
        resultado.volumenMinMl = Number(((dosis - variacion) / concMgMl).toFixed(2))
        resultado.volumenMaxMl = Number(((dosis + variacion) / concMgMl).toFixed(2))
      }
      
      setResultado(resultado)
      setError(null)
      return resultado
    } catch (err) {
      setError(err.message)
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
    resetear
  }
}