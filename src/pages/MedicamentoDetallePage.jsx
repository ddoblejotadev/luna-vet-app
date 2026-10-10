import { Link, useParams } from 'react-router-dom'
import { useEffect, useMemo, useState } from 'react'
import medicamentosService from '../services/medicamentosService'
import './pages.css'

const RISK_LABELS = {
  normal: 'Normal',
  precaucion: 'Precaución',
  alto: 'Alto',
  critico: 'Crítico',
}

const EMPTY_VALUE = 'No informado'

function Field({ label, value }) {
  if (value === null || value === undefined || value === '') return null

  return (
    <div className="detail-field">
      <span>{label}</span>
      <strong>{value}</strong>
    </div>
  )
}

function BadgeList({ label, items, className = 'badge' }) {
  if (!items || items.length === 0) return null

  return (
    <section className="detail-section">
      <h2>{label}</h2>
      <div className="badge-list">
        {items.map((item) => (
          <span key={item} className={className}>{item}</span>
        ))}
      </div>
    </section>
  )
}

function TextSection({ title, children }) {
  if (!children) return null

  return (
    <section className="detail-section">
      <h2>{title}</h2>
      <p className="detail-text">{children}</p>
    </section>
  )
}

/**
 * Calculadora embebida en la ficha
 * Usa la presentación seleccionada para calcular mg y mL a partir del peso
 */
function CalculadoraEmbebida({ medicamento, presentacionActiva }) {
  const [peso, setPeso] = useState('')
  const [resultado, setResultado] = useState(null)

  const dosisMin = presentacionActiva?.dosis_min_mg_kg ?? medicamento?.dosis_minima_mg_kg
  const dosisMax = presentacionActiva?.dosis_max_mg_kg ?? medicamento?.dosis_maxima_mg_kg
  const concMgMl = presentacionActiva?.concentracion_mg_ml ?? medicamento?.concentracion_mg_ml

  const tieneRango = dosisMin !== null && dosisMin !== undefined && dosisMax !== null && dosisMax !== undefined
  const tieneConc = concMgMl !== null && concMgMl !== undefined && concMgMl > 0

  const calcular = () => {
    const p = Number(peso)
    if (!p || p <= 0) {
      setResultado({ error: 'Ingresá un peso válido en kg' })
      return
    }
    if (!tieneRango) {
      setResultado({ error: 'Este medicamento/presentación no tiene rango numérico configurado' })
      return
    }
    const minMg = p * dosisMin
    const maxMg = p * dosisMax
    let minMl = null, maxMl = null
    if (tieneConc) {
      minMl = minMg / concMgMl
      maxMl = maxMg / concMgMl
    }
    setResultado({
      peso: p,
      minMg: Number(minMg.toFixed(2)),
      maxMg: Number(maxMg.toFixed(2)),
      minMl: minMl ? Number(minMl.toFixed(2)) : null,
      maxMl: maxMl ? Number(maxMl.toFixed(2)) : null,
      concMgMl,
      tieneConc
    })
  }

  return (
    <section className="detail-section calculadora-embebida">
      <h2>Calculadora rápida</h2>
      <div className="calc-inline">
        <div className="calc-input-group">
          <label htmlFor="peso-calc">Peso del paciente (kg)</label>
          <input
            id="peso-calc"
            type="number"
            step="0.1"
            min="0.1"
            placeholder="Ej: 15"
            value={peso}
            onChange={(e) => setPeso(e.target.value)}
            onKeyDown={(e) => e.key === 'Enter' && calcular()}
          />
        </div>
        <button className="btn btn-primary" onClick={calcular} style={{marginTop: '0.5rem', alignSelf: 'flex-end'}}>
          Calcular
        </button>
      </div>

      {resultado && resultado.error && (
        <p className="calc-error">{resultado.error}</p>
      )}

      {resultado && !resultado.error && (
        <div className="calc-result">
          <div className="calc-row">
            <span>Dosis total</span>
            <strong>{resultado.minMg.toFixed(2)} – {resultado.maxMg.toFixed(2)} mg</strong>
          </div>
          {resultado.tieneConc && (
            <div className="calc-row">
              <span>Volumen a administrar</span>
              <strong>{resultado.minMl.toFixed(2)} – {resultado.maxMl.toFixed(2)} mL</strong>
              <small>(conc. {resultado.concMgMl} mg/mL)</small>
            </div>
          )}
          {!resultado.tieneConc && (
            <p className="calc-note">Configurá la concentración (mg/mL) en la presentación para ver el volumen en mL.</p>
          )}
        </div>
      )}
    </section>
  )
}

export default function MedicamentoDetallePage() {
  const { id } = useParams()
  const [medicamento, setMedicamento] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)
  const [presentacionSeleccionada, setPresentacionSeleccionada] = useState(null)

  useEffect(() => {
    let isMounted = true

    async function loadMedicamento() {
      try {
        setLoading(true)
        setError(null)
        const data = await medicamentosService.getMedicamentoById(id)
        if (isMounted) {
          if (data) {
            setMedicamento(data)
            // Si hay presentaciones, selecciona la primera por defecto
            if (data.presentaciones && data.presentaciones.length > 0) {
              setPresentacionSeleccionada(data.presentaciones[0])
            }
          } else {
            setError('No se encontró el medicamento solicitado')
          }
        }
      } catch (err) {
        console.error('Error loading medication detail:', err)
        if (isMounted) {
          setError('No se pudo cargar la ficha del medicamento')
        }
      } finally {
        if (isMounted) {
          setLoading(false)
        }
      }
    }

    loadMedicamento()

    return () => {
      isMounted = false
    }
  }, [id])

  const riskLevel = medicamento?.nivel_riesgo || 'normal'
  const tienePresentaciones = medicamento?.presentaciones && medicamento.presentaciones.length > 0

  // Datos de la presentación activa (si hay selector) o del medicamento base
  const presentacionActiva = presentacionSeleccionada || medicamento

  const dosageRange = useMemo(() => {
    if (!presentacionActiva) return null
    const min = presentacionActiva.dosis_min_mg_kg ?? presentacionActiva.dosis_minima_mg_kg
    const max = presentacionActiva.dosis_max_mg_kg ?? presentacionActiva.dosis_maxima_mg_kg
    if (min === null || min === undefined || max === null || max === undefined) return null
    return min === max ? `${min} mg/kg` : `${min} - ${max} mg/kg`
  }, [presentacionActiva])

  const concMgMl = presentacionActiva?.concentracion_mg_ml ?? presentacionActiva?.concentracion_mg_ml

  if (loading) {
    return (
      <div className="page">
        <p>Cargando ficha del medicamento...</p>
      </div>
    )
  }

  if (error) {
    return (
      <div className="page">
        <Link to="/medicamentos" className="back-link">← Volver al catálogo</Link>
        <div className="auth-guidance-box">
          <p>{error}</p>
        </div>
      </div>
    )
  }

  return (
    <div className="page medicamento-detail-page">
      <Link to="/medicamentos" className="back-link">← Volver al catálogo</Link>

      <article className={`medicamento-detail-card risk-border-${riskLevel}`}>
        <header className="medicamento-detail-header">
          <div>
            <p className="eyebrow">Ficha del medicamento</p>
            <h1>{medicamento.nombre}</h1>
            <p className="lead-small">{medicamento.indicaciones || 'Indicaciones clínicas pendientes de completar.'}</p>
          </div>
          <span className={`badge risk-${riskLevel}`}>{RISK_LABELS[riskLevel] || riskLevel}</span>
        </header>

        {riskLevel === 'critico' && (
          <div className="contraindication-warning">
            <strong>Advertencia crítica:</strong> este medicamento requiere verificación veterinaria estricta antes de calcular o administrar dosis.
          </div>
        )}

        {/* Selector de presentaciones */}
        {tienePresentaciones && (
          <section className="detail-section selector-presentaciones">
            <h2>Presentaciones disponibles</h2>
            <div className="presentaciones-grid">
              {medicamento.presentaciones.map((pres, idx) => (
                <button
                  key={idx}
                  className={`presentacion-card ${presentacionSeleccionada === pres ? 'active' : ''}`}
                  onClick={() => setPresentacionSeleccionada(pres)}
                >
                  <div className="pres-etiqueta">{pres.etiqueta}</div>
                  <div className="pres-concentracion">{pres.concentracion}</div>
                  {pres.dosis_texto && <div className="pres-dosis">{pres.dosis_texto}</div>}
                  {pres.dosis_min_mg_kg && pres.dosis_max_mg_kg && (
                    <div className="pres-rango">
                      {pres.dosis_min_mg_kg === pres.dosis_max_mg_kg
                        ? `${pres.dosis_min_mg_kg} mg/kg`
                        : `${pres.dosis_min_mg_kg} – ${pres.dosis_max_mg_kg} mg/kg`}
                    </div>
                  )}
                </button>
              ))}
            </div>
            <p className="pres-hint">Hacé clic en una presentación para cambiar la dosis y concentración mostrada.</p>
          </section>
        )}

        <section className="detail-section">
          <h2>Identificación</h2>
          <div className="detail-grid">
            <Field label="Principio activo" value={medicamento.principio_activo || EMPTY_VALUE} />
            <Field label="Composición" value={medicamento.composicion || EMPTY_VALUE} />
            <Field label="Familia terapéutica" value={medicamento.familia_terapeutica || EMPTY_VALUE} />
            <Field label="Presentación" value={presentacionActiva.presentacion || medicamento.presentacion || EMPTY_VALUE} />
            <Field label="Concentración" value={presentacionActiva.concentracion || medicamento.concentracion || EMPTY_VALUE} />
            <Field label="Concentración (mg/mL)" value={concMgMl ? `${concMgMl} mg/mL` : EMPTY_VALUE} />
            <Field label="Laboratorio / marca de referencia" value={medicamento.laboratorio || EMPTY_VALUE} />
            <Field label="Clasificación" value={medicamento.clasificacion || EMPTY_VALUE} />
          </div>
        </section>

        <section className="detail-section">
          <h2>Resumen para estudio</h2>
          <div className="study-highlight-grid">
            <div>
              <span>Qué mirar primero</span>
              <strong>Principio activo + especie segura + dosis</strong>
            </div>
            <div>
              <span>Antes de usar</span>
              <strong>Contraindicaciones, interacciones y alertas</strong>
            </div>
          </div>
        </section>

        <TextSection title="Mecanismo de acción">
          {medicamento.mecanismo_accion}
        </TextSection>

        <TextSection title="Uso para estudio">
          {medicamento.uso_estudio}
        </TextSection>

        <section className="detail-section">
          <h2>Dosis y uso clínico</h2>
          <div className="detail-grid">
            <Field label="Dosis recomendada" value={presentacionActiva.dosis_texto || presentacionActiva.dosis_recomendada || medicamento.dosis_recomendada || EMPTY_VALUE} />
            <Field label="Rango mg/kg" value={dosageRange || EMPTY_VALUE} />
            <Field label="Frecuencia" value={medicamento.frecuencia_horas ? `Cada ${medicamento.frecuencia_horas} horas` : EMPTY_VALUE} />
            <Field label="Vía de administración" value={medicamento.via_administracion || EMPTY_VALUE} />
            <Field label="Conservación" value={medicamento.conservacion || EMPTY_VALUE} />
          </div>
        </section>

        {/* Calculadora embebida - solo si hay rango numérico */}
        {(presentacionActiva.dosis_min_mg_kg ?? presentacionActiva.dosis_minima_mg_kg) !== null && (presentacionActiva.dosis_max_mg_kg ?? presentacionActiva.dosis_maxima_mg_kg) !== null && (
          <CalculadoraEmbebida medicamento={medicamento} presentacionActiva={presentacionActiva} />
        )}

        <BadgeList label="Especies permitidas" items={medicamento.especies_permitidas} className="badge badge-especie" />
        <BadgeList label="Especies contraindicadas" items={medicamento.especies_contraindicadas} className="badge badge-contraindicada" />

        {medicamento.alertas_clinicas && medicamento.alertas_clinicas.length > 0 && (
          <section className="detail-section">
            <h2>Alertas clínicas</h2>
            <div className="clinical-alert-box">
              <ul>
                {medicamento.alertas_clinicas.map((alerta) => (
                  <li key={alerta}>{alerta}</li>
                ))}
              </ul>
            </div>
          </section>
        )}

        <TextSection title="Contraindicaciones">
          {medicamento.contraindicaciones}
        </TextSection>

        <TextSection title="Efectos secundarios">
          {medicamento.efectos_secundarios}
        </TextSection>

        <TextSection title="Interacciones">
          {medicamento.interacciones}
        </TextSection>

        <TextSection title="Notas educativas">
          {medicamento.notas}
        </TextSection>

        <section className="detail-section">
          <h2>Registros y fuente</h2>
          <div className="detail-grid">
            <Field label="Registro SAG Chile" value={medicamento.registro_sag || 'Pendiente de verificación'} />
            <Field label="Registro SENASA Argentina" value={medicamento.registro_senasa || 'Pendiente de verificación'} />
            <Field label="Fuente de dosis" value={medicamento.fuente || EMPTY_VALUE} />
          </div>
        </section>

        <div className="detail-actions">
          <Link to={`/calculadora?medicamento=${medicamento.id}`} className="btn btn-primary">Calculadora completa</Link>
          <Link to="/medicamentos" className="btn btn-secondary">Ver catálogo</Link>
        </div>
      </article>
    </div>
  )
}