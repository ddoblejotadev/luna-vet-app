import { useState } from 'react'
import { useDosisCalculator } from '../hooks/useDosisCalculator'
import './pages.css'

export default function CalculadoraPage() {
  const { resultado, error, calcularPorPeso, calcularPorBSA, calcularConMargen, resetear } = useDosisCalculator()

  const [peso, setPeso] = useState('')
  const [dosisPorKg, setDosisPorKg] = useState('')
  const [frecuencia, setFrecuencia] = useState('12')
  const [metodo, setMetodo] = useState('peso')
  const [margen, setMargen] = useState('10')

  const handleCalcular = (e) => {
    e.preventDefault()

    if (!peso || !dosisPorKg) {
      alert('Por favor completa todos los campos')
      return
    }

    const pesoNum = parseFloat(peso)
    const dosisNum = parseFloat(dosisPorKg)

    if (isNaN(pesoNum) || isNaN(dosisNum)) {
      alert('Los valores deben ser números válidos')
      return
    }

    try {
      switch (metodo) {
        case 'peso':
          calcularPorPeso(pesoNum, dosisNum, parseInt(frecuencia))
          break
        case 'bsa':
          calcularPorBSA(pesoNum, dosisNum)
          break
        case 'margen':
          calcularConMargen(pesoNum, dosisNum, parseInt(margen))
          break
        default:
          break
      }
    } catch (err) {
      console.error('Error en cálculo:', err)
    }
  }

  return (
    <div className="page calculadora-page">
      <h1>Calculadora de Dosis</h1>

      <div className="calculadora-container">
        <div className="calculadora-form">
          <form onSubmit={handleCalcular}>
            <fieldset>
              <legend>Método de Cálculo</legend>
              <div className="radio-group">
                <label>
                  <input
                    type="radio"
                    value="peso"
                    checked={metodo === 'peso'}
                    onChange={(e) => setMetodo(e.target.value)}
                  />
                  Por peso (mg/kg)
                </label>
                <label>
                  <input
                    type="radio"
                    value="bsa"
                    checked={metodo === 'bsa'}
                    onChange={(e) => setMetodo(e.target.value)}
                  />
                  Por superficie corporal
                </label>
                <label>
                  <input
                    type="radio"
                    value="margen"
                    checked={metodo === 'margen'}
                    onChange={(e) => setMetodo(e.target.value)}
                  />
                  Con margen de seguridad
                </label>
              </div>
            </fieldset>

            <div className="form-group">
              <label htmlFor="peso">Peso del animal (kg)</label>
              <input
                id="peso"
                type="number"
                step="0.1"
                min="0"
                value={peso}
                onChange={(e) => setPeso(e.target.value)}
                placeholder="Ej: 25.5"
              />
            </div>

            <div className="form-group">
              <label htmlFor="dosisPorKg">
                {metodo === 'bsa' ? 'Dosis por m²' : 'Dosis por kg (mg/kg)'}
              </label>
              <input
                id="dosisPorKg"
                type="number"
                step="0.1"
                min="0"
                value={dosisPorKg}
                onChange={(e) => setDosisPorKg(e.target.value)}
                placeholder="Ej: 10"
              />
            </div>

            {metodo === 'peso' && (
              <div className="form-group">
                <label htmlFor="frecuencia">Frecuencia (cada cuántas horas)</label>
                <select
                  id="frecuencia"
                  value={frecuencia}
                  onChange={(e) => setFrecuencia(e.target.value)}
                >
                  <option value="6">Cada 6 horas</option>
                  <option value="8">Cada 8 horas</option>
                  <option value="12">Cada 12 horas</option>
                  <option value="24">Cada 24 horas</option>
                </select>
              </div>
            )}

            {metodo === 'margen' && (
              <div className="form-group">
                <label htmlFor="margen">Margen de seguridad (%)</label>
                <input
                  id="margen"
                  type="number"
                  step="1"
                  min="0"
                  max="100"
                  value={margen}
                  onChange={(e) => setMargen(e.target.value)}
                  placeholder="Ej: 10"
                />
              </div>
            )}

            <div className="form-buttons">
              <button type="submit" className="btn btn-primary">
                Calcular Dosis
              </button>
              <button type="button" onClick={resetear} className="btn btn-secondary">
                Limpiar
              </button>
            </div>
          </form>
        </div>

        <div className="calculadora-resultado">
          {error && (
            <div className="error-box">
              <strong>Error:</strong> {error}
            </div>
          )}

          {resultado && (
            <div className="resultado-box">
              <h2>Resultado</h2>

              {resultado.dosisSingle && (
                <div className="resultado-item">
                  <span className="label">Dosis por administración:</span>
                  <span className="value">{resultado.dosisSingle} mg</span>
                </div>
              )}

              {resultado.dosisDaily && (
                <div className="resultado-item">
                  <span className="label">Dosis diaria total:</span>
                  <span className="value">{resultado.dosisDaily} mg</span>
                </div>
              )}

              {resultado.bsa && (
                <div className="resultado-item">
                  <span className="label">Superficie corporal (BSA):</span>
                  <span className="value">{resultado.bsa} m²</span>
                </div>
              )}

              {resultado.margenAlto && (
                <div className="resultado-item">
                  <span className="label">Rango recomendado:</span>
                  <span className="value">
                    {resultado.margenAlt} - {resultado.margenAlto} mg
                  </span>
                </div>
              )}

              {resultado.notas && (
                <p className="notas">{resultado.notas}</p>
              )}
            </div>
          )}

          {!resultado && !error && (
            <div className="empty-state">
              <p>Completa el formulario y calcula una dosis</p>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
