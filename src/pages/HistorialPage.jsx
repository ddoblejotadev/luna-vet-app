import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import historialService from '../services/historialService'
import './pages.css'

const METHOD_LABELS = {
  peso: 'Por peso',
  catalogo: 'Catálogo',
  bsa: 'Superficie corporal',
  margen: 'Margen de seguridad',
}

const formatDate = (value) => {
  if (!value) return 'Sin fecha'
  return new Intl.DateTimeFormat('es-AR', {
    dateStyle: 'medium',
    timeStyle: 'short',
  }).format(new Date(value))
}

const formatNumber = (value, suffix = '') => {
  if (value === null || value === undefined || value === '') return '—'
  const number = Number(value)
  if (Number.isNaN(number)) return '—'
  return `${number.toLocaleString('es-AR', { maximumFractionDigits: 2 })}${suffix}`
}

function HistorialRow({ calculo }) {
  const isRange = calculo.dosis_minima_calculada !== null && calculo.dosis_maxima_calculada !== null
  const medicamentoNombre = calculo.medicamentos?.nombre || 'Sin medicamento asociado'
  const especieNombre = calculo.especies?.nombre || 'Sin especie'
  const metodo = METHOD_LABELS[calculo.metodo_calculo] || calculo.metodo_calculo

  return (
    <article className="historial-card">
      <header className="historial-card-header">
        <div>
          <h2>{medicamentoNombre}</h2>
          <p>{formatDate(calculo.created_at)}</p>
        </div>
        <span className="historial-method">{metodo}</span>
      </header>

      <div className="historial-grid">
        <div>
          <span className="label">Peso</span>
          <strong>{formatNumber(calculo.peso_kg, ' kg')}</strong>
        </div>
        <div>
          <span className="label">Especie</span>
          <strong>{especieNombre}</strong>
        </div>
        <div>
          <span className="label">Frecuencia</span>
          <strong>{calculo.frecuencia_horas ? `Cada ${calculo.frecuencia_horas} h` : '—'}</strong>
        </div>
        <div>
          <span className="label">Dosis calculada</span>
          <strong>
            {isRange
              ? `${formatNumber(calculo.dosis_minima_calculada, ' mg')} - ${formatNumber(calculo.dosis_maxima_calculada, ' mg')}`
              : formatNumber(calculo.dosis_calculada, ' mg')}
          </strong>
        </div>
        {isRange && (
          <div>
            <span className="label">Rango catálogo</span>
            <strong>
              {formatNumber(calculo.dosis_minima_mg_kg, ' mg/kg')} - {formatNumber(calculo.dosis_maxima_mg_kg, ' mg/kg')}
            </strong>
          </div>
        )}
      </div>

      {calculo.notas && <p className="historial-notas">{calculo.notas}</p>}
    </article>
  )
}

export default function HistorialPage() {
  const { user, loading: authLoading } = useAuth()
  const [historial, setHistorial] = useState([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)

  useEffect(() => {
    let isMounted = true

    async function loadHistorial() {
      if (!user) return

      try {
        setLoading(true)
        setError(null)
        const data = await historialService.getHistorialForUser(user.id)
        if (isMounted) {
          setHistorial(data)
        }
      } catch (err) {
        console.error('Error loading historial:', err)
        if (isMounted) {
          setError('No se pudo cargar el historial de cálculos')
        }
      } finally {
        if (isMounted) {
          setLoading(false)
        }
      }
    }

    loadHistorial()

    return () => {
      isMounted = false
    }
  }, [user])

  if (authLoading) {
    return (
      <div className="page">
        <h1>Historial</h1>
        <div className="loading">Cargando sesión...</div>
      </div>
    )
  }

  if (!user) {
    return (
      <div className="page">
        <h1>Historial</h1>
        <div className="auth-guidance-box historial-login-box">
          <p>Iniciá sesión para ver y guardar tu historial de cálculos.</p>
          <Link to="/login" className="btn btn-primary">Iniciar sesión</Link>
        </div>
      </div>
    )
  }

  return (
    <div className="page">
      <div className="page-header-row">
        <div>
          <h1>Historial</h1>
          <p className="lead-small">Cálculos guardados para {user.email}</p>
        </div>
        <Link to="/calculadora" className="btn btn-secondary">Nuevo cálculo</Link>
      </div>

      {loading && <div className="loading">Cargando historial...</div>}
      {error && <div className="error-box">{error}</div>}
      {!loading && !error && historial.length === 0 && (
        <div className="empty-state">Todavía no guardaste cálculos.</div>
      )}
      {!loading && !error && historial.length > 0 && (
        <section className="historial-list" aria-label="Historial de cálculos">
          {historial.map((calculo) => (
            <HistorialRow key={calculo.id} calculo={calculo} />
          ))}
        </section>
      )}
    </div>
  )
}
