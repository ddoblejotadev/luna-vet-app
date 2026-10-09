import { useEffect, useMemo, useState } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import ReporteDosis from '../components/ReporteDosis'
import { useDosisCalculator } from '../hooks/useDosisCalculator'
import medicamentosService from '../services/medicamentosService'
import historialService from '../services/historialService'
import './pages.css'

export default function CalculadoraPage() {
  const { user } = useAuth()
  const [searchParams] = useSearchParams()
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
  const [especies, setEspecies] = useState([])
  const [selectedEspecie, setSelectedEspecie] = useState('Perro')
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

    async function loadData() {
      try {
        setMedicamentosLoading(true)
        setMedicamentosError(null)
        const [meds, esps] = await Promise.all([
          medicamentosService.getAllMedicamentos(),
          medicamentosService.getEspecies(),
        ])
        if (isMounted) {
          setMedicamentos(meds)
          if (esps && esps.length > 0) {
            setEspecies(esps)
          } else {
            setEspecies([
              { id: null, nombre: 'Perro' },
              { id: null, nombre: 'Gato' },
            ])
          }
        }
      } catch (err) {
        if (isMounted) {
          setMedicamentosError('No se pudo cargar el catálogo de medicamentos o especies')
        }
      } finally {
        if (isMounted) {
          setMedicamentosLoading(false)
        }
      }
    }

    loadData()

    return () => {
      isMounted = false
    }
  }, [])

  useEffect(() => {
    const medicamentoParam = searchParams.get('medicamento')
    if (!medicamentoParam || medicamentos.length === 0) return

    const med = medicamentos.find((item) => item.id === medicamentoParam)
    if (!med) return

    setMedicamentoId(med.id)
    if (med.especies_permitidas?.length > 0) {
      setSelectedEspecie(med.especies_permitidas[0])
    }
    if (med.dosis_minima_mg_kg && med.dosis_maxima_mg_kg) {
      setMetodo('catalogo')
      setDosisMinPorKg(String(med.dosis_minima_mg_kg))
      setDosisMaxPorKg(String(med.dosis_maxima_mg_kg))
    }
  }, [searchParams, medicamentos])

  const filteredMedicamentos = useMemo(() => {
    if (!selectedEspecie) return medicamentos
    return medicamentos.filter(
      (med) => med.especies_permitidas && med.especies_permitidas.includes(selectedEspecie)
    )
  }, [medicamentos, selectedEspecie])

  const selectedMedicamento = useMemo(
    () => medicamentos.find((medicamento) => medicamento.id === medicamentoId) || null,
    [medicamentos, medicamentoId]
  )

  const isContraindicated = useMemo(() => {
    if (!selectedMedicamento || !selectedEspecie) return false
    return (
      selectedMedicamento.especies_contraindicadas &&
      selectedMedicamento.especies_contraindicadas.includes(selectedEspecie)
    )
  }, [selectedMedicamento, selectedEspecie])

  const handleEspecieChange = (e) => {
    const nextEspecie = e.target.value
    setSelectedEspecie(nextEspecie)
    resetear()
    setSaved(false)
    setSaveError(null)

    if (medicamentoId) {
      const med = medicamentos.find((m) => m.id === medicamentoId)
      if (med && (!med.especies_permitidas || !med.especies_permitidas.includes(nextEspecie))) {
        setMedicamentoId('')
        setMetodo('peso')
        setDosisMinPorKg('')
        setDosisMaxPorKg('')
      }
    }
  }

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

  const handlePrintReport = () => {
    window.print()
  }

  const handleGuardarHistorial = async () => {
    if (!user || saving || saved || isContraindicated) return

    setSaving(true)
    setSaveError(null)

    try {
      const pesoNum = parseFloat(peso)
      if (isNaN(pesoNum) || pesoNum <= 0) {
        throw new Error('Peso inválido para guardar')
      }

      const currentEspecieObj = especies.find((e) => e.nombre === selectedEspecie)

      let payload = {
        usuario_id: user.id,
        medicamento_id: medicamentoId || null,
        especie_id: currentEspecieObj ? currentEspecieObj.id : null,
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
      setSaveError(err.message || 'Error al guardar en el historial')
    } finally {
      setSaving(false)
    }
  }

  const handleCalcular = (e) => {
    e.preventDefault()

    if (isContraindicated) {
      alert('Este medicamento está contraindicado para la especie seleccionada. No se puede calcular la dosis.')
      return
    }

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
      console.error('Calculation error:', err)
    }
  }

  return (
    <div className="page calculadora-page">
      <h1>Calculadora de Dosis Clínicas</h1>

      <div className="calculadora-container">
        <div className="calculadora-form">
          <form onSubmit={handleCalcular}>
            <div className="form-group species-selector-container">
              <label htmlFor="especie">Especie de Paciente</label>
              <select
                id="especie"
                value={selectedEspecie}
                onChange={handleEspecieChange}
                className="form-control"
              >
                {especies.map((esp) => (
                  <option key={esp.id || esp.nombre} value={esp.nombre}>
                    {esp.nombre}
                  </option>
                ))}
              </select>
            </div>

            <div className="form-group">
              <label htmlFor="medicamento">Medicamento (Catálogo)</label>
              {medicamentosLoading ? (
                <p>Cargando medicamentos...</p>
              ) : medicamentosError ? (
                <p className="error-text">{medicamentosError}</p>
              ) : (
                <select
                  id="medicamento"
                  value={medicamentoId}
                  onChange={handleMedicamentoChange}
                  className="form-control"
                >
                  <option value="">-- Seleccionar medicamento (Opcional) --</option>
                  {filteredMedicamentos.map((med) => (
                    <option key={med.id} value={med.id}>
                      {med.nombre} {med.principio_activo ? `(${med.principio_activo})` : ''}
                    </option>
                  ))}
                </select>
              )}
            </div>

            {selectedMedicamento && (
              <div className={`selected-medicamento ${isContraindicated ? 'contraindicated' : ''}`}>
                {isContraindicated && (
                  <div className="contraindicated-banner">
                    ¡ATENCIÓN! Este medicamento está contraindicado para {selectedEspecie}.
                  </div>
                )}
                <h2>{selectedMedicamento.nombre}</h2>
                {selectedMedicamento.principio_activo && (
                  <p><strong>Principio activo:</strong> {selectedMedicamento.principio_activo}</p>
                )}
                {selectedMedicamento.familia_terapeutica && (
                  <p><strong>Familia:</strong> {selectedMedicamento.familia_terapeutica}</p>
                )}
                {selectedMedicamento.dosis_recomendada && (
                  <p><strong>Dosis recomendada:</strong> {selectedMedicamento.dosis_recomendada}</p>
                )}
                <div style={{ marginTop: '0.5rem' }}>
                  <span className={`badge risk-${selectedMedicamento.nivel_riesgo || 'normal'}`}>
                    Riesgo: {selectedMedicamento.nivel_riesgo || 'normal'}
                  </span>
                  {selectedMedicamento.especies_permitidas && selectedMedicamento.especies_permitidas.map((esp) => (
                    <span key={esp} className="badge badge-especie">{esp}</span>
                  ))}
                </div>
                {selectedMedicamento.alertas_clinicas && selectedMedicamento.alertas_clinicas.length > 0 && (
                  <div className="clinical-alert-box">
                    <strong>Alertas clínicas:</strong>
                    <ul style={{ margin: '0.25rem 0 0 1rem', padding: 0 }}>
                      {selectedMedicamento.alertas_clinicas.map((alerta, idx) => (
                        <li key={idx}>{alerta}</li>
                      ))}
                    </ul>
                  </div>
                )}
              </div>
            )}

            <div className="form-group">
              <label htmlFor="peso">Peso del Paciente (kg) *</label>
              <input
                id="peso"
                type="number"
                step="0.01"
                min="0.1"
                placeholder="Ej. 10.5"
                value={peso}
                onChange={(e) => setPeso(e.target.value)}
                required
                className="form-control"
              />
            </div>

            <fieldset>
              <legend>Método de Cálculo</legend>
              <div className="radio-group">
                <label>
                  <input
                    type="radio"
                    name="metodo"
                    value="peso"
                    checked={metodo === 'peso'}
                    onChange={(e) => setMetodo(e.target.value)}
                  />
                  Dosis fija por kg
                </label>
                <label>
                  <input
                    type="radio"
                    name="metodo"
                    value="catalogo"
                    checked={metodo === 'catalogo'}
                    onChange={(e) => setMetodo(e.target.value)}
                    disabled={!selectedMedicamento || !selectedMedicamento.dosis_minima_mg_kg}
                  />
                  Rango de dosis del medicamento seleccionado
                </label>
                <label>
                  <input
                    type="radio"
                    name="metodo"
                    value="bsa"
                    checked={metodo === 'bsa'}
                    onChange={(e) => setMetodo(e.target.value)}
                  />
                  Superficie Corporal (BSA - m²)
                </label>
                <label>
                  <input
                    type="radio"
                    name="metodo"
                    value="margen"
                    checked={metodo === 'margen'}
                    onChange={(e) => setMetodo(e.target.value)}
                  />
                  Cálculo con Margen de Seguridad (%)
                </label>
              </div>
            </fieldset>

            {metodo === 'peso' && (
              <div className="form-group">
                <label htmlFor="dosisPorKg">Dosis por kg (mg/kg)</label>
                <input
                  id="dosisPorKg"
                  type="number"
                  step="0.01"
                  min="0.01"
                  placeholder="Ej. 5"
                  value={dosisPorKg}
                  onChange={(e) => setDosisPorKg(e.target.value)}
                  className="form-control"
                />
              </div>
            )}

            {metodo === 'catalogo' && (
              <div className="dose-range-inputs">
                <div className="form-group">
                  <label htmlFor="dosisMinPorKg">Dosis Mínima (mg/kg)</label>
                  <input
                    id="dosisMinPorKg"
                    type="number"
                    step="0.01"
                    value={dosisMinPorKg}
                    onChange={(e) => setDosisMinPorKg(e.target.value)}
                    className="form-control"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="dosisMaxPorKg">Dosis Máxima (mg/kg)</label>
                  <input
                    id="dosisMaxPorKg"
                    type="number"
                    step="0.01"
                    value={dosisMaxPorKg}
                    onChange={(e) => setDosisMaxPorKg(e.target.value)}
                    className="form-control"
                  />
                </div>
              </div>
            )}

            {metodo === 'bsa' && (
              <div className="form-group">
                <label htmlFor="dosisBSA">Dosis por m² (mg/m²)</label>
                <input
                  id="dosisBSA"
                  type="number"
                  step="0.01"
                  placeholder="Ej. 50"
                  value={dosisPorKg}
                  onChange={(e) => setDosisPorKg(e.target.value)}
                  className="form-control"
                />
              </div>
            )}

            {metodo === 'margen' && (
              <>
                <div className="form-group">
                  <label htmlFor="dosisMargen">Dosis base por kg (mg/kg)</label>
                  <input
                    id="dosisMargen"
                    type="number"
                    step="0.01"
                    placeholder="Ej. 5"
                    value={dosisPorKg}
                    onChange={(e) => setDosisPorKg(e.target.value)}
                    className="form-control"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="margenPorcentaje">Margen de seguridad (%)</label>
                  <input
                    id="margenPorcentaje"
                    type="number"
                    step="1"
                    min="0"
                    max="50"
                    value={margen}
                    onChange={(e) => setMargen(e.target.value)}
                    className="form-control"
                  />
                </div>
              </>
            )}

            <div className="form-group">
              <label htmlFor="frecuencia">Frecuencia (horas)</label>
              <select
                id="frecuencia"
                value={frecuencia}
                onChange={(e) => setFrecuencia(e.target.value)}
                className="form-control"
              >
                <option value="8">Cada 8 horas (3 veces al día)</option>
                <option value="12">Cada 12 horas (2 veces al día)</option>
                <option value="24">Cada 24 horas (1 vez al día)</option>
              </select>
            </div>

            <div className="form-actions" style={{ display: 'flex', gap: '1rem' }}>
              <button
                type="submit"
                className="btn btn-primary"
                disabled={isContraindicated}
              >
                Calcular Dosis
              </button>
              <button
                type="button"
                className="btn btn-secondary"
                onClick={handleReset}
              >
                Reiniciar
              </button>
            </div>

            {isContraindicated && (
              <p className="error-text" style={{ marginTop: '0.75rem' }}>
                Cálculo bloqueado: el medicamento seleccionado está contraindicado para esta especie.
              </p>
            )}
          </form>
        </div>

        <div className="calculadora-resultado">
          <h2>Resultado del Cálculo</h2>

          {error && <p className="error-text">{error}</p>}

          {resultado && (
            <div className="resultado-content">
              <div className="resultado-card screen-only">
                {resultado.dosisMinSingle !== undefined ? (
                  <>
                    <p><strong>Dosis Mínima por Toma:</strong> {resultado.dosisMinSingle} {resultado.unidad}</p>
                    <p><strong>Dosis Máxima por Toma:</strong> {resultado.dosisMaxSingle} {resultado.unidad}</p>
                    <p><strong>Dosis Mínima Diaria:</strong> {resultado.dosisMinDaily} {resultado.unidad}</p>
                    <p><strong>Dosis Máxima Diaria:</strong> {resultado.dosisMaxDaily} {resultado.unidad}</p>
                  </>
                ) : resultado.dosisBase !== undefined ? (
                  <>
                    <p><strong>Dosis Base:</strong> {resultado.dosisBase} {resultado.unidad}</p>
                    <p><strong>Dosis Mínima (-{resultado.margen}%):</strong> {resultado.dosisMin} {resultado.unidad}</p>
                    <p><strong>Dosis Máxima (+{resultado.margen}%):</strong> {resultado.dosisMax} {resultado.unidad}</p>
                  </>
                ) : (
                  <>
                    <p><strong>Dosis por Toma:</strong> {resultado.dosisSingle} {resultado.unidad}</p>
                    <p><strong>Dosis Diaria:</strong> {resultado.dosisDaily} {resultado.unidad}</p>
                  </>
                )}
                <p><strong>Frecuencia:</strong> Cada {resultado.frecuencia} horas</p>
                {resultado.bsa && <p><strong>Superficie Corporal (BSA):</strong> {resultado.bsa} m²</p>}
                {resultado.notas && <p className="notas-clinicas"><strong>Indicación:</strong> {resultado.notas}</p>}
                <div className="resultado-actions">
                  <button type="button" className="btn btn-primary" onClick={handlePrintReport}>
                    Imprimir / guardar PDF
                  </button>
                </div>
              </div>

              <ReporteDosis
                medicamento={selectedMedicamento}
                especie={selectedEspecie}
                peso={peso}
                metodo={metodo}
                resultado={resultado}
                margen={margen}
              />

              {user ? (
                <div className="historial-save-box" style={{ marginTop: '1.5rem' }}>
                  <button
                    type="button"
                    className="btn btn-primary btn-save-historial"
                    onClick={handleGuardarHistorial}
                    disabled={saving || saved || isContraindicated}
                  >
                    {saving ? 'Guardando...' : saved ? 'Guardado en historial' : 'Guardar en historial'}
                  </button>
                  {saved && <p className="success-text" style={{ marginTop: '0.5rem', color: 'var(--success)' }}>¡Cálculo guardado en tu historial exitosamente!</p>}
                  {saveError && <p className="error-text" style={{ marginTop: '0.5rem' }}>{saveError}</p>}
                </div>
              ) : (
                <div className="auth-guidance-box" style={{ marginTop: '1.5rem' }}>
                  <p>
                    ¿Querés guardar este cálculo en tu historial?{' '}
                    <Link to="/login" className="auth-link">Iniciá sesión</Link> o registrate.
                  </p>
                </div>
              )}
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
