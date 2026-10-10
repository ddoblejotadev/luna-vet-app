import { Link, useParams, useLocation } from 'react-router-dom'
import { useEffect, useMemo, useState } from 'react'
import medicamentosService from '../services/medicamentosService'
import { interaccionesPara } from '../data/interacciones'
import './pages.css'

const RISK_LABELS = {
  normal: 'Normal',
  precaucion: 'Precaución',
  alto: 'Alto',
  critico: 'Crítico',
}

const EMPTY_VALUE = 'No informado'

const ESPECIES = ['Perro', 'Gato', 'Equino', 'Bovino', 'Ovino', 'Porcino', 'Aves']

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
    <div className="detail-badges">
      <h3>{label}</h3>
      <div className="badge-list">
        {items.map((item) => (
          <span key={item} className={className}>{item}</span>
        ))}
      </div>
    </div>
  )
}

function TextSection({ title, children }) {
  if (!children) return null

  return (
    <div className="detail-subsection">
      <h3>{title}</h3>
      <p className="detail-text">{children}</p>
    </div>
  )
}

/**
 * Sección colapsable: solo el título es visible hasta que se abre.
 */
function Acordeon({ titulo, children, defaultOpen = false, badge }) {
  const [abierto, setAbierto] = useState(defaultOpen)

  return (
    <section className={`acordeon ${abierto ? 'abierto' : ''}`}>
      <button
        type="button"
        className="acordeon-header"
        onClick={() => setAbierto(!abierto)}
        aria-expanded={abierto}
      >
        <span className="acordeon-titulo">
          {titulo}
          {badge && <span className={`badge risk-${badge}`}>{RISK_LABELS[badge]}</span>}
        </span>
        <span className="acordeon-flecha" aria-hidden="true">{abierto ? '▾' : '▸'}</span>
      </button>
      {abierto && <div className="acordeon-body">{children}</div>}
    </section>
  )
}

/**
 * Botón para copiar la dosis al portapapeles
 */
function CopiarDosis({ texto }) {
  const [copiado, setCopiado] = useState(false)

  if (!texto) return null

  const copiar = async () => {
    try {
      await navigator.clipboard.writeText(texto)
      setCopiado(true)
      setTimeout(() => setCopiado(false), 2000)
    } catch {
      setCopiado(false)
    }
  }

  return (
    <button
      type="button"
      className="btn-copiar"
      onClick={copiar}
      title="Copiar dosis al portapapeles"
    >
      {copiado ? '✓ Copiado' : 'Copiar dosis'}
    </button>
  )
}

/**
 * Calculadora embebida en la ficha
 * Usa la presentación seleccionada (y la especie, si hay datos) para
 * calcular mg y mL a partir del peso
 */
function CalculadoraEmbebida({ medicamento, presentacionActiva }) {
  const [peso, setPeso] = useState('')
  const [especie, setEspecie] = useState('')
  const [resultado, setResultado] = useState(null)

  const dosisPorEspecie = presentacionActiva?.dosis_por_especie?.[especie]
    ?? medicamento?.dosis_por_especie?.[especie]
  const dosisMin = dosisPorEspecie?.min
    ?? presentacionActiva?.dosis_min_mg_kg
    ?? medicamento?.dosis_minima_mg_kg
  const dosisMax = dosisPorEspecie?.max
    ?? presentacionActiva?.dosis_max_mg_kg
    ?? medicamento?.dosis_maxima_mg_kg
  const concMgMl = presentacionActiva?.concentracion_mg_ml ?? medicamento?.concentracion_mg_ml

  const tieneRango = dosisMin !== null && dosisMin !== undefined && dosisMax !== null && dosisMax !== undefined
  const tieneConc = concMgMl !== null && concMgMl !== undefined && concMgMl > 0
  const usaDosisEspecie = Boolean(dosisPorEspecie)

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
      especie,
      usaDosisEspecie,
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
        <div className="calc-input-group">
          <label htmlFor="especie-calc">Especie (ajusta la dosis si hay dato)</label>
          <select
            id="especie-calc"
            value={especie}
            onChange={(e) => setEspecie(e.target.value)}
          >
            <option value="">Sin especie (rango general)</option>
            {ESPECIES.map((esp) => (
              <option key={esp} value={esp}>{esp}</option>
            ))}
          </select>
        </div>
        <button className="btn btn-primary" onClick={calcular}>Calcular</button>
      </div>

      {resultado && !resultado.error && (
        <div className="calc-result">
          <div className="calc-row">
            <span>Peso:</span>
            <strong>{resultado.peso} kg{resultado.especie ? ` · ${resultado.especie}` : ''}</strong>
          </div>
          <div className="calc-row">
            <span>Dosis total:</span>
            <strong>{resultado.minMg} – {resultado.maxMg} mg</strong>
          </div>
          {resultado.tieneConc && (
            <div className="calc-row calc-resultado-mL">
              <span>Volumen:</span>
              <strong>{resultado.minMl} – {resultado.maxMl} mL</strong>
              <span className="calc-note">({concMgMl} mg/mL)</span>
            </div>
          )}
          <p className="calc-note">
            {resultado.usaDosisEspecie
              ? `Rango específico para ${resultado.especie}.`
              : 'Rango general: verificá la dosis según la especie antes de administrar.'}
          </p>
        </div>
      )}

      {resultado && resultado.error && (
        <div className="calc-error">{resultado.error}</div>
      )}
    </section>
  )
}

/**
 * Guarda la ficha vista en "Vistos recientemente" (localStorage)
 */
function registrarVista(med) {
  try {
    const key = 'lunavet:vistos'
    const raw = localStorage.getItem(key)
    const vistos = raw ? JSON.parse(raw) : []
    const filtrados = vistos.filter((v) => v.id !== med.id)
    filtrados.unshift({
      id: med.id,
      nombre: med.nombre,
      principio_activo: med.principio_activo,
      nivel_riesgo: med.nivel_riesgo,
      ts: Date.now(),
    })
    localStorage.setItem(key, JSON.stringify(filtrados.slice(0, 6)))
  } catch {
    // localStorage no disponible: sin historial, sin error
  }
}

export default function MedicamentoDetallePage() {
  const { id } = useParams()
  const location = useLocation()
  const [medicamento, setMedicamento] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)
  const [presentacionSeleccionada, setPresentacionSeleccionada] = useState(null)

  useEffect(() => {
    let isMounted = true

    const loadMedicamento = async () => {
      try {
        const data = await medicamentosService.getMedicamentoById(id)
        if (isMounted) {
          setMedicamento(data)
          registrarVista(data)
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

  // El enlace "volver" regresa al listado con los filtros que estaban activos
  const backTo = location.state?.from || '/medicamentos'

  // Datos de la presentación activa (si hay selector) o del medicamento base
  const presentacionActiva = presentacionSeleccionada || medicamento

  const dosageRange = useMemo(() => {
    if (!presentacionActiva) return null
    const min = presentacionActiva.dosis_min_mg_kg ?? presentacionActiva.dosis_minima_mg_kg
    const max = presentacionActiva.dosis_max_mg_kg ?? presentacionActiva.dosis_maxima_mg_kg
    if (min === null || min === undefined || max === null || max === undefined) return null
    return min === max ? `${min} mg/kg` : `${min} - ${max} mg/kg`
  }, [presentacionActiva])

  const concMgMl = presentacionActiva?.concentracion_mg_ml ?? medicamento?.concentracion_mg_ml

  const interacciones = useMemo(() => interaccionesPara(medicamento), [medicamento])

  if (loading) {
    return (
      <div className="page">
        <div className="skeleton skeleton-line w40" />
        <div className="skeleton skeleton-title" />
        <div className="skeleton skeleton-line" />
        <div className="skeleton skeleton-line w70" />
        <div className="skeleton skeleton-block" />
      </div>
    )
  }

  if (error) {
    return (
      <div className="page">
        <Link to={backTo} className="back-link">← Volver al catálogo</Link>
        <div className="auth-guidance-box">
          <p>{error}</p>
        </div>
      </div>
    )
  }

  return (
    <div className="page medicamento-detail-page">
      <Link to={backTo} className="back-link">← Volver al catálogo</Link>

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

        {/* Resumen destacado de la dosis según la presentación activa */}
        {(presentacionActiva.dosis_texto || presentacionActiva.dosis_recomendada || medicamento.dosis_recomendada) && (
          <section className="dosis-destacada">
            <div className="dosis-destacada-main">
              <span className="dosis-destacada-label">Dosis de referencia</span>
              <strong className="dosis-destacada-valor">
                {presentacionActiva.dosis_texto || presentacionActiva.dosis_recomendada || medicamento.dosis_recomendada}
              </strong>
              {dosageRange && <span className="dosis-destacada-rango">{dosageRange}</span>}
            </div>
            <CopiarDosis texto={`${medicamento.nombre}: ${presentacionActiva.dosis_texto || presentacionActiva.dosis_recomendada || medicamento.dosis_recomendada}${dosageRange ? ` (${dosageRange})` : ''}`} />
          </section>
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
            <p className="pres-hint">Hacé clic en una presentación para actualizar dosis y cálculos.</p>
          </section>
        )}

        {/* Calculadora rápida: peso → mg (y mL si hay concentración) */}
        <CalculadoraEmbebida medicamento={medicamento} presentacionActiva={presentacionActiva} />

        {/* Interacciones críticas conocidas */}
        {interacciones.length > 0 && (
          <section className="detail-section interacciones-alertas">
            <h2>Interacciones a tener en cuenta</h2>
            {interacciones.map((inta, idx) => (
              <div
                key={idx}
                className={`interaccion-alerta ${inta.nivel === 'critico' ? 'critica' : 'alta'}`}
              >
                <strong>
                  {medicamento.nombre} + {inta.otros}:
                </strong>{' '}
                {inta.efecto}
              </div>
            ))}
          </section>
        )}

        {/* Secciones colapsables: solo lo esencial queda visible arriba */}
        <Acordeon titulo="Identificación">
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
        </Acordeon>

        <Acordeon titulo="Dosis y uso clínico">
          <div className="detail-grid">
            <Field label="Dosis recomendada" value={presentacionActiva.dosis_texto || presentacionActiva.dosis_recomendada || medicamento.dosis_recomendada || EMPTY_VALUE} />
            <Field label="Rango (mg/kg)" value={dosageRange || EMPTY_VALUE} />
            <Field label="Frecuencia" value={medicamento.frecuencia || EMPTY_VALUE} />
            <Field label="Vía de administración" value={medicamento.via_administracion || EMPTY_VALUE} />
            <Field label="Conservación" value={medicamento.conservacion || EMPTY_VALUE} />
          </div>
          <div className="detail-badges-row">
            <BadgeList label="Especies permitidas" items={medicamento.especies_permitidas} className="badge-especie" />
            <BadgeList label="Epecies contraindicadas" items={medicamento.especies_contraindicadas} className="badge-contraindicada" />
          </div>
        </Acordeon>

        <Acordeon titulo="Farmacología">
          <TextSection title="Mecanismo de acción">
            {medicamento.mecanismo_accion}
          </TextSection>
          <TextSection title="Uso para estudio">
            {medicamento.uso_estudio}
          </TextSection>
        </Acordeon>

        <Acordeon titulo="Seguridad" badge={riskLevel === 'critico' || riskLevel === 'alto' ? riskLevel : undefined}>
          {medicamento.alertas_clinicas && medicamento.alertas_clinicas.length > 0 && (
            <TextSection title="Alertas clínicas">
              {medicamento.alertas_clinicas.join(' • ')}
            </TextSection>
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
        </Acordeon>

        <Acordeon titulo="Registros y fuente">
          <div className="detail-grid">
            <Field label="Registro SAG Chile" value={medicamento.registro_sag || 'Pendiente de verificación'} />
            <Field label="Registro SENASA Argentina" value={medicamento.registro_senasa || 'Pendiente de verificación'} />
            <Field label="Fuente de dosis" value={medicamento.fuente || EMPTY_VALUE} />
          </div>
        </Acordeon>

        <div className="detail-actions">
          <Link to={`/calculadora?medicamento=${medicamento.id}`} className="btn btn-primary">Calculadora completa</Link>
          <Link to={backTo} className="btn btn-secondary">Ver catálogo</Link>
        </div>
      </article>
    </div>
  )
}
