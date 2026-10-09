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

export default function MedicamentoDetallePage() {
  const { id } = useParams()
  const [medicamento, setMedicamento] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

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
  const dosageRange = useMemo(() => {
    if (!medicamento) return null
    const min = medicamento.dosis_minima_mg_kg
    const max = medicamento.dosis_maxima_mg_kg
    if (min === null || min === undefined || max === null || max === undefined) return null
    return min === max ? `${min} mg/kg` : `${min} - ${max} mg/kg`
  }, [medicamento])

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

        <section className="detail-section">
          <h2>Identificación</h2>
          <div className="detail-grid">
            <Field label="Principio activo" value={medicamento.principio_activo || EMPTY_VALUE} />
            <Field label="Familia terapéutica" value={medicamento.familia_terapeutica || EMPTY_VALUE} />
            <Field label="Presentación" value={medicamento.presentacion || EMPTY_VALUE} />
            <Field label="Concentración" value={medicamento.concentracion || EMPTY_VALUE} />
            <Field label="Laboratorio / marca de referencia" value={medicamento.laboratorio || EMPTY_VALUE} />
            <Field label="Clasificación" value={medicamento.clasificacion || EMPTY_VALUE} />
          </div>
        </section>

        <section className="detail-section">
          <h2>Dosis y uso clínico</h2>
          <div className="detail-grid">
            <Field label="Dosis recomendada" value={medicamento.dosis_recomendada || EMPTY_VALUE} />
            <Field label="Rango mg/kg" value={dosageRange || EMPTY_VALUE} />
            <Field label="Frecuencia" value={medicamento.frecuencia_horas ? `Cada ${medicamento.frecuencia_horas} horas` : EMPTY_VALUE} />
            <Field label="Conservación" value={medicamento.conservacion || EMPTY_VALUE} />
          </div>
        </section>

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

        <section className="detail-section">
          <h2>Registros y fuente</h2>
          <div className="detail-grid">
            <Field label="Registro SAG Chile" value={medicamento.registro_sag || 'Pendiente de verificación'} />
            <Field label="Registro SENASA Argentina" value={medicamento.registro_senasa || 'Pendiente de verificación'} />
            <Field label="Fuente de dosis" value={medicamento.fuente || EMPTY_VALUE} />
          </div>
        </section>

        <div className="detail-actions">
          <Link to={`/calculadora?medicamento=${medicamento.id}`} className="btn btn-primary">Calcular dosis</Link>
          <Link to="/medicamentos" className="btn btn-secondary">Ver catálogo</Link>
        </div>
      </article>
    </div>
  )
}
