import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import { useDosisCalculator } from '../hooks/useDosisCalculator'
import medicamentosService from '../services/medicamentosService'
import historialService from '../services/historialService'
import './pages.css'

export default function CalculadoraPage() {
  const { user } = useAuth()
  const {
    resultado,
    error,
    calcularPorPeso,
    calcularRangoPorPeso,
    calcularPorBSA,
    calcularConMargen,
    resetear,
  } = useDosisCalculator()

  const [medicamentos, setMedicamentos] = useState([])
  const [medicamentosLoading, setMedicamentosLoading] = useState(true)
  const [medicamentosError, setMedicamentosError] = useState(null)
  const [medicamentoId, setMedicamentoId] = useState('')
  const [peso, setPeso] = useState('')
  const [dosisPorKg, setDosisPorKg] = useState('')
  const [dosisMinPorKg, setDosisMinPorKg] = useState('')
  const [dosisMaxPorKg, setDosisMaxPorKg] = useState('')
  const [frecuencia, setFrecuencia] = useState('12')
  const [metodo, setMetodo] = useState('peso')
  const [margen, setMargen] = useState('10')
  const [saving, setSaving] = useState(false)
  const [saved, setSaved] = useState(false)
  const [saveError, setSaveError] = useState(null)

  useEffect(() => {
    let isMounted = true

    async function loadMedicamentos() {
      try {
        setMedicamentosLoading(true)
        setMedicamentosError(null)
        const data = await medicamentosService.getAllMedicamentos()
        if (isMounted) {
          setMedicamentos(data)
        }
      } catch (err) {
        if (isMounted) {
          setMedicamentosError('No se pudo cargar el catálogo de medicamentos')
        }
      } finally {
        if (isMounted) {
          setMedicamentosLoading(false)
        }
      }
    }

    loadMedicamentos()

    return () => {
      isMounted = false
    }
  }, [])

  const selectedMedicamento = useMemo(
    () => medicamentos.find((medicamento) => medicamento.id === medicamentoId) || null,
    [medicamentos, medicamentoId]
  )

  const handleMedicamentoChange = (e) => {
    const nextId = e.target.value
    setMedicamentoId(nextId)
    resetear()
    setSaved(false)
    setSaveError(null)

    const medicamento = medicamentos.find((item) => item.id === nextId)

    if (!medicamento) {
      setMetodo('peso')
      setDosisMinPorKg('')
      setDosisMaxPorKg('')
      return
    }

    const min = medicamento.dosis_minima_mg_kg
    const max = medicamento.dosis_maxima_mg_kg

    if (min && max) {
      setMetodo('catalogo')
      setDosisMinPorKg(String(Number(min)))
      setDosisMaxPorKg(String(Number(max)))
      setDosisPorKg(String(Number(min)))
    }

    if (medicamento.frecuencia_horas) {
      setFrecuencia(String(medicamento.frecuencia_horas))
    }
  }

  const handleReset = () => {
    resetear()
    setSaved(false)
    setSaveError(null)
  }

  const handleGuardarHistorial = async () => {
    if (!user || saving || saved) return

    setSaving(true)
    setSaveError(null)

    try {
      const pesoNum = parseFloat(peso)
      if (isNaN(pesoNum) || pesoNum <= 0) {
        throw new Error('Peso inválido para guardar')
      }

      let payload = {
        usuario_id: user.id,
        medicamento_id: medicamentoId || null,
        peso_kg: pesoNum,
        metodo_calculo: metodo,
        frecuencia_horas: frecuencia ? parseInt(frecuencia, 10) : null,
        notas: resultado?.notas || null,
      }

      if (metodo === 'catalogo') {
        payload.dosis_minima_calculada = resultado?.dosisMinSingle !== undefined ? resultado.dosisMinSingle : null
        payload.dosis_maxima_calculada = resultado?.dosisMaxSingle !== undefined ? resultado.dosisMaxSingle : null
        payload.dosis_minima_mg_kg = dosisMinPorKg ? parseFloat(dosisMinPorKg) : (selectedMedicamento?.dosis_minima_mg_kg || null)
        payload.dosis_maxima_mg_kg = dosisMaxPorKg ? parseFloat(dosisMaxPorKg) : (selectedMedicamento?.dosis_maxima_mg_kg || null)
        payload.dosis_calculada = null
      } else if (metodo === 'peso') {
        payload.dosis_calculada = resultado?.dosisSingle !== undefined ? resultado.dosisSingle : null
      } else if (metodo === 'bsa') {
        payload.dosis_calculada = resultado?.dosisSingle !== undefined ? resultado.dosisSingle : null
      } else if (metodo === 'margen') {
        payload.dosis_calculada = resultado?.dosisBase !== undefined ? resultado.dosisBase : (resultado?.dosisSingle !== undefined ? resultado.dosisSingle : null)
      } else {
        payload.dosis_calculada = resultado?.dosisSingle !== undefined ? resultado.dosisSingle : null
      }

      await historialService.createHistorial(payload)
      setSaved(true)
    } catch (err) {
      console.error('Error saving historial:', err)
      setSaveError(err.message || 'No se pudo guardar el cálculo en el historial')
    } finally {
      setSaving(false)
    }
  }

  const handleCalcular = (e) => {
    e.preventDefault()
    setSaved(false)
    setSaveError(null)

    if (!peso) {
      alert('Por favor ingresá el peso del animal')
      return
    }

    const pesoNum = parseFloat(peso)

    if (isNaN(pesoNum)) {
      alert('El peso debe ser un número válido')
      return
    }

    try {
      switch (metodo) {
        case 'catalogo': {
          if (!dosisMinPorKg || !dosisMaxPorKg) {
            alert('El medicamento seleccionado no tiene rango de dosis configurado')
            return
          }

          const dosisMinNum = parseFloat(dosisMinPorKg)
          const dosisMaxNum = parseFloat(dosisMaxPorKg)

          if (isNaN(dosisMinNum) || isNaN(dosisMaxNum)) {
            alert('Las dosis del catálogo deben ser números válidos')
            return
          }

          calcularRangoPorPeso(pesoNum, dosisMinNum, dosisMaxNum, parseInt(frecuencia))
          break
        }
        case 'peso': {
          if (!dosisPorKg) {
            alert('Por favor ingresá la dosis por kg')
            return
          }

          const dosisNum = parseFloat(dosisPorKg)

          if (isNaN(dosisNum)) {
            alert('La dosis debe ser un número válido')
            return
          }

          calcularPorPeso(pesoNum, dosisNum, parseInt(frecuencia))
          break
        }
        case 'bsa': {
          if (!dosisPorKg) {
            alert('Por favor ingresá la dosis por m²')
            return
          }

          const dosisNum = parseFloat(dosisPorKg)

          if (isNaN(dosisNum)) {
            alert('La dosis debe ser un número válido')
            return
          }

          calcularPorBSA(pesoNum, dosisNum)
          break
        }
        case 'margen': {
          if (!dosisPorKg) {
            alert('Por favor ingresá la dosis por kg')
            return
          }

          const dosisNum = parseFloat(dosisPorKg)

          if (isNaN(dosisNum)) {
            alert('La dosis debe ser un número válido')
            return
          }

          calcularConMargen(pesoNum, dosisNum, parseInt(margen))
          break
        }
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
            <div className="form-group">
              <label htmlFor="medicamento">Medicamento del catálogo</label>
              <select
                id="medicamento"
                value={medicamentoId}
                onChange={handleMedicamentoChange}
                disabled={medicamentosLoading}
              >
                <option value="">
                  {medicamentosLoading ? 'Cargando medicamentos...' : 'Seleccionar medicamento opcional'}
                </option>
                {medicamentos.map((medicamento) => (
                  <option key={medicamento.id} value={medicamento.id}>
                    {medicamento.nombre} — {medicamento.familia_terapeutica}
                  </option>
                ))}
              </select>
              {medicamentosError && <p className="form-help error-text">{medicamentosError}</p>}
              {!medicamentosError && (
                <p className="form-help">Podés usar el catálogo o hacer un cálculo manual.</p>
              )}
            </div>

            {selectedMedicamento && (
              <aside className="selected-medicamento">
                <h2>{selectedMedicamento.nombre}</h2>
                <p>{selectedMedicamento.familia_terapeutica}</p>
                {selectedMedicamento.dosis_recomendada && (
                  <p><strong>Dosis de referencia:</strong> {selectedMedicamento.dosis_recomendada}</p>
                )}
                {selectedMedicamento.via_administracion && (
                  <p><strong>Vía:</strong> {selectedMedicamento.via_administracion}</p>
                )}
              </aside>
            )}

            <fieldset>
              <legend>Método de Cálculo</legend>
              <div className="radio-group">
                <label>
                  <input
                    type="radio"
                    value="catalogo"
                    checked={metodo === 'catalogo'}
                    onChange={(e) => setMetodo(e.target.value)}
                    disabled={!selectedMedicamento}
                  />
                  Rango del catálogo (mg/kg)
                </label>
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

            {metodo === 'catalogo' ? (
              <div className="dose-range-inputs">
                <div className="form-group">
                  <label htmlFor="dosisMinPorKg">Dosis mínima (mg/kg)</label>
                  <input
                    id="dosisMinPorKg"
                    type="number"
                    step="0.01"
                    min="0"
                    value={dosisMinPorKg}
                    onChange={(e) => setDosisMinPorKg(e.target.value)}
                    placeholder="Ej: 5"
                  />
                </div>

                <div className="form-group">
                  <label htmlFor="dosisMaxPorKg">Dosis máxima (mg/kg)</label>
                  <input
                    id="dosisMaxPorKg"
                    type="number"
                    step="0.01"
                    min="0"
                    value={dosisMaxPorKg}
                    onChange={(e) => setDosisMaxPorKg(e.target.value)}
                    placeholder="Ej: 10"
                  />
                </div>
              </div>
            ) : (
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
            )}

            {(metodo === 'peso' || metodo === 'catalogo') && (
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
                  <option value="168">Cada 7 días</option>
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
              <button type="button" onClick={handleReset} className="btn btn-secondary">
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

              {selectedMedicamento && (
                <div className="resultado-item">
                  <span className="label">Medicamento:</span>
                  <span className="value">{selectedMedicamento.nombre}</span>
                </div>
              )}

              {resultado.dosisMinSingle && resultado.dosisMaxSingle && (
                <div className="resultado-item">
                  <span className="label">Dosis por administración:</span>
                  <span className="value">{resultado.dosisMinSingle} - {resultado.dosisMaxSingle} mg</span>
                </div>
              )}

              {resultado.dosisMinDaily && resultado.dosisMaxDaily && (
                <div className="resultado-item">
                  <span className="label">Dosis diaria total:</span>
                  <span className="value">{resultado.dosisMinDaily} - {resultado.dosisMaxDaily} mg</span>
                </div>
              )}

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

              <div className="historial-action-section">
                {user ? (
                  <div className="historial-save-box">
                    <button
                      type="button"
                      className="btn btn-primary btn-save-historial"
                      onClick={handleGuardarHistorial}
                      disabled={saving || saved}
                    >
                      {saving ? 'Guardando...' : saved ? 'Guardado en historial' : 'Guardar en historial'}
                    </button>
                    {saved && <p className="success-text">¡Cálculo guardado en tu historial exitosamente!</p>}
                    {saveError && <p className="error-text">{saveError}</p>}
                  </div>
                ) : (
                  <div className="auth-guidance-box">
                    <p>
                      ¿Querés guardar este cálculo en tu historial?{' '}
                      <Link to="/login" className="auth-link">Iniciá sesión</Link> o registrate.
                    </p>
                  </div>
                )}
              </div>
            </div>
          )}

          {!resultado && !error && (
            <div className="empty-state">
              <p>Seleccioná un medicamento o completá el formulario para calcular una dosis</p>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
