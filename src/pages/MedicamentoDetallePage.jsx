import { Link, useParams, useLocation } from 'react-router-dom'
import { useEffect, useMemo, useState } from 'react'
import medicamentosService from '../services/medicamentosService'
import { interaccionesPara } from '../data/interacciones'
import KawaiiSticker from '../components/KawaiiSticker'
import './pages.css'

const RISK_LABELS = {
  normal: 'Normal',
  precaucion: 'Precaución',
  alto: 'Alto',
  critico: 'Crítico',
}

const RISK_ICONS = {
  normal: '✅',
  precaucion: '⚠️',
  alto: '🔶',
  critico: '🚨',
}

const ESPECIES = ['Perro', 'Gato', 'Equino', 'Bovino', 'Ovino', 'Porcino', 'Aves']

const ICONOS = {
  calculadora: '🧮',
  posologia: '💉',
  farmacologia: '🧪',
  seguridad: '🛡️',
  interacciones: '⚡',
  referencias: '📄',
}

/**
 * Componente para campos sin información: discreto, no grita "No informado".
 */
function SinDato({ children = 'Sin dato' }) {
  return <span className="sin-dato">{children}</span>
}

function Field({ label, value, sinDato = false, guia }) {
  if (value === null || value === undefined || value === '') {
    if (!sinDato) return null
    return (
      <div className="detail-field">
        <span>{label}</span>
        <SinDato />
        {guia && <p className="sin-dato-guia">{guia}</p>}
      </div>
    )
  }

  return (
    <div className="detail-field">
      <span>{label}</span>
      <strong>{value}</strong>
    </div>
  )
}

function formatearFrecuencia(horas) {
  if (horas === null || horas === undefined) return ''
  if (horas === 0) return 'Dosis única'
  if (horas === 24) return 'Cada 24 horas (1 vez/día)'
  if (horas === 48) return 'Cada 48 horas'
  if (horas === 72) return 'Cada 72 horas'
  if (horas < 24) return `Cada ${horas} horas`
  if (horas % 24 === 0) return `Cada ${horas / 24} días`
  return `Cada ${horas} horas`
}

function formatearConcentracion(conc) {
  if (!conc) return ''
  const t = conc.trim()
  // Ya expresa concentración por volumen, peso o tiempo
  if (/mg\/ml|µg\/ml|g\/ml|%|mg\/vial|µg\/h|mg\/h|mg\/g|iu\/ml|u\/ml/i.test(t)) return t
  // Dosis sólida por unidad (comprimido/cápsula/jeringa)
  if (/^[0-9]+(?:[.,][0-9]+)?\s*(?:–|-|a|hasta)\s*[0-9]+(?:[.,][0-9]+)?\s*(mg|g|µg|mcg|IU|U)\b/i.test(t)
      || /^[0-9]+(?:[.,][0-9]+)?\s*(mg|g|µg|mcg|IU|U)\b/i.test(t)) {
    return `${t} por unidad`
  }
  return t
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

function TextSection({ title, children, placeholder, guia }) {
  const vacio = children === null || children === undefined || children === ''

  return (
    <div className="detail-subsection">
      <h3>{title}</h3>
      {vacio ? (
        guia ? (
          <p className="sin-dato-guia">{guia}</p>
        ) : (
          <SinDato>{placeholder || 'Sin dato'}</SinDato>
        )
      ) : (
        <p className="detail-text">{children}</p>
      )}
    </div>
  )
}

/**
 * Sección colapsable con icono: solo el título es visible hasta que se abre.
 */
function Acordeon({ titulo, icono, children, defaultOpen = false, badge }) {
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
          {icono && <span className="acordeon-icono" aria-hidden="true">{icono}</span>}
          <span>{titulo}</span>
          {badge && (
            <span className={`badge risk-${badge}`}>
              {RISK_ICONS[badge]} {RISK_LABELS[badge]}
            </span>
          )}
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
      {copiado ? '✓ Copiado' : '📋 Copiar'}
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
    <section className="calculadora-embebida">
      <div className="calc-inline">
        <div className="calc-input-group">
          <label htmlFor="peso-calc">Peso del paciente (kg)</label>
          <input
            id="peso-calc"
            type="number"
            step="0.1"
            min="0.1"
            inputMode="decimal"
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
              <span>Equivale en mL:</span>
              <strong>{resultado.minMl} – {resultado.maxMl} mL</strong>
              <span className="calc-conc">({resultado.concMgMl} mg/mL)</span>
            </div>
          )}
          {!resultado.tieneConc && presentacionActiva && (
            <div className="calc-row calc-nota-presentacion">
              <span>💊 Presentación:</span>
              <strong>{presentacionActiva.concentracion || presentacionActiva.presentacion || 'Según presentación'}</strong>
            </div>
          )}
          {resultado.usaDosisEspecie && (
            <p className="calc-nota-especie">✨ Dosis ajustada para {resultado.especie}</p>
          )}
        </div>
      )}

      {resultado?.error && (
        <div className="calc-error" role="alert">{resultado.error}</div>
      )}
    </section>
  )
}

/**
 * Campos que consideramos "pendientes" cuando están vacíos.
 */
const CAMPOS_PENDIENTES = [
  ['dosis_recomendada', 'Dosis'],
  ['via_administracion', 'Vía'],
  ['indicaciones', 'Indicaciones'],
  ['mecanismo_accion', 'Mecanismo'],
  ['farmacocinetica', 'Farmacocinética'],
  ['efectos_secundarios', 'Efectos secundarios'],
  ['contraindicaciones', 'Contraindicaciones'],
  ['precauciones', 'Precauciones'],
  ['fuente', 'Fuente'],
]

export default function MedicamentoDetallePage() {
  const { id } = useParams()
  const location = useLocation()

  const [medicamento, setMedicamento] = useState(null)
  const [presentacionSeleccionada, setPresentacionSeleccionada] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    let isMounted = true

    async function loadMedicamento() {
      setLoading(true)
      setError(null)
      setPresentacionSeleccionada(null)
      try {
        const med = await medicamentosService.getMedicamentoById(id)
        if (!isMounted) return

        if (!med) {
          setError('No se encontró el medicamento solicitado.')
          setMedicamento(null)
          return
        }

        setMedicamento(med)

        // Guardar en vistos recientemente (localStorage)
        try {
          const stored = JSON.parse(localStorage.getItem('lunavet_recent_meds') || '[]')
          const updated = [
            { id: med.id, nombre: med.nombre, familia: med.familia_terapeutica, riesgo: med.nivel_riesgo },
            ...stored.filter((item) => item.id !== med.id)
          ].slice(0, 5)
          localStorage.setItem('lunavet_recent_meds', JSON.stringify(updated))
        } catch (e) {
          console.error('Error saving recent meds', e)
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

  const interacciones = useMemo(() => interaccionesPara(medicamento), [medicamento])

  // Campos pendientes de completar (para avisar con elegancia)
  const pendientes = useMemo(() => {
    if (!medicamento) return []
    return CAMPOS_PENDIENTES
      .filter(([campo]) => !medicamento[campo])
      .map(([, label]) => label)
  }, [medicamento])

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

  const textoDosis = presentacionActiva.dosis_texto
    || presentacionActiva.dosis_recomendada
    || medicamento.dosis_recomendada

  return (
    <div className="page medicamento-detail-page">
      <Link to={backTo} className="back-link">← Volver al catálogo</Link>

      <article className={`medicamento-detail-card risk-border-${riskLevel}`}>
        {/* ── Header ─────────────────────────────── */}
        <header className="medicamento-detail-header">
          <div className="detail-header-sticker">
            <KawaiiSticker size={56} alt="" />
          </div>
          <div className="detail-header-text">
            <p className="eyebrow">
              {medicamento.familia_terapeutica || 'Ficha del medicamento'}
            </p>
            <h1>{medicamento.nombre}</h1>
            {medicamento.principio_activo && (
              <p className="lead-small">
                Principio activo: <strong>{medicamento.principio_activo}</strong>
              </p>
            )}
            {medicamento.indicaciones && (
              <p className="lead-small">{medicamento.indicaciones}</p>
            )}
          </div>
          <span className={`badge risk-${riskLevel} risk-badge-lg`}>
            {RISK_ICONS[riskLevel]} {RISK_LABELS[riskLevel] || riskLevel}
          </span>
        </header>

        {medicamento?.especies_permitidas?.length > 0 && (
          <BadgeList label="Especies permitidas" items={medicamento.especies_permitidas} className="badge badge-especie" />
        )}
        {medicamento?.especies_contraindicadas?.length > 0 && (
          <BadgeList label="Especies contraindicadas" items={medicamento.especies_contraindicadas} className="badge badge-contraindicada" />
        )}

        {riskLevel === 'critico' && (
          <div className="contraindication-warning">
            <strong>Advertencia crítica:</strong> este medicamento requiere verificación veterinaria estricta antes de calcular o administrar dosis.
          </div>
        )}

        {/* ── Dosis destacada (hero) ─────────────── */}
        {textoDosis && (
          <section className="dosis-destacada">
            <div className="dosis-destacada-main">
              <span className="dosis-destacada-label">Dosis de referencia</span>
              <strong className="dosis-destacada-valor">{textoDosis}</strong>
              {dosageRange && <span className="dosis-destacada-rango">{dosageRange}</span>}
            </div>
            <CopiarDosis texto={`${medicamento.nombre}: ${textoDosis}${dosageRange ? ` (${dosageRange})` : ''}`} />
          </section>
        )}

        {/* ── Selector de presentaciones ─────────── */}
        {tienePresentaciones && (
          <section className="selector-presentaciones">
            <h2 className="section-title">{ICONOS.presentaciones || '📦'} Presentaciones disponibles</h2>
            <div className="presentaciones-grid">
              {medicamento.presentaciones.map((pres, idx) => (
                <button
                  key={idx}
                  type="button"
                  className={`presentacion-card ${presentacionSeleccionada === pres ? 'active' : ''}`}
                  onClick={() => setPresentacionSeleccionada(pres)}
                >
                  <div className="pres-etiqueta">{pres.etiqueta}</div>
                  <div className="pres-concentracion">{pres.concentracion}</div>
                  {pres.dosis_texto && <div className="pres-dosis">{pres.dosis_texto}</div>}
                  {(pres.dosis_min_mg_kg || pres.dosis_min_mg_kg === 0) && (pres.dosis_max_mg_kg || pres.dosis_max_mg_kg === 0) && (
                    <div className="pres-rango">
                      {pres.dosis_min_mg_kg === pres.dosis_max_mg_kg
                        ? `${pres.dosis_min_mg_kg} mg/kg`
                        : `${pres.dosis_min_mg_kg} – ${pres.dosis_max_mg_kg} mg/kg`}
                    </div>
                  )}
                </button>
              ))}
            </div>
            <p className="pres-hint">Hacé clic en una presentación para actualizar la dosis y la calculadora.</p>
          </section>
        )}

        {/* ── Calculadora rápida ─────────────────── */}
        <Acordeon titulo="Calculadora rápida" icono={ICONOS.calculadora} defaultOpen>
          <CalculadoraEmbebida medicamento={medicamento} presentacionActiva={presentacionActiva} />
        </Acordeon>

        {/* ── Posología ──────────────────────────── */}
        <Acordeon titulo="Posología y uso" icono={ICONOS.posologia}>
          <TextSection title="Indicaciones">{medicamento.indicaciones}</TextSection>
          <div className="detail-grid">
            <Field label="Vía de administración" value={medicamento.via_administracion} sinDato />
            <Field label="Presentación" value={medicamento.presentacion} sinDato />
            <Field label="Concentración" value={formatearConcentracion(medicamento.concentracion)} sinDato guia="La concentración varía según la presentación. Revisá el selector de presentaciones." />
            <Field label="Frecuencia" value={formatearFrecuencia(medicamento.frecuencia_horas)} sinDato />
            <Field label="Duración" value={medicamento.duracion} sinDato guia="La duración depende de la indicación clínica; consultá con tu veterinario." />
          </div>
        </Acordeon>

        {/* ── Farmacología ───────────────────────── */}
        <Acordeon titulo="Farmacología" icono={ICONOS.farmacologia}>
          <TextSection title="Mecanismo de acción">{medicamento.mecanismo_accion}</TextSection>
          <TextSection title="Farmacocinética">{medicamento.farmacocinetica}</TextSection>
        </Acordeon>

        {/* ── Seguridad ──────────────────────────── */}
        <Acordeon titulo="Seguridad" icono={ICONOS.seguridad} badge={riskLevel === 'critico' || riskLevel === 'alto' ? riskLevel : undefined}>
          <TextSection title="Contraindicaciones">{medicamento.contraindicaciones}</TextSection>
          <TextSection title="Efectos secundarios">{medicamento.efectos_secundarios}</TextSection>
          <TextSection title="Precauciones" guia="Usar bajo criterio veterinario. No hay precauciones específicas registradas para este medicamento.">{medicamento.precauciones}</TextSection>
          <TextSection title="Embarazo y lactancia" guia="No hay datos específicos. Consultá al veterinario antes de administrarlo en gestación o lactancia.">{medicamento.embarazo_lactancia}</TextSection>
          <TextSection title="Alertas clínicas">
            {medicamento.alertas_clinicas && medicamento.alertas_clinicas.length > 0
              ? medicamento.alertas_clinicas.join(' • ')
              : ''}
          </TextSection>
          <TextSection title="Interacciones">{medicamento.interacciones}</TextSection>
          <TextSection title="Notas educativas">{medicamento.notas}</TextSection>
        </Acordeon>

        {/* ── Interacciones críticas conocidas ───── */}
        {interacciones.length > 0 && (
          <Acordeon titulo={`Interacciones conocidas (${interacciones.length})`} icono={ICONOS.interacciones} defaultOpen>
            <div className="interacciones-alertas">
              {interacciones.map((inta, idx) => (
                <div key={idx} className="interaccion-alerta">
                  <span className={`badge risk-${inta.nivel === 'critico' ? 'critico' : 'alto'}`}>
                    {inta.nivel === 'critico' ? '🚫 Crítica' : '⚠️ Precaución'}
                  </span>
                  <p className="text-interaccion">
                    <strong>con {inta.otros}:</strong> {inta.efecto}
                  </p>
                </div>
              ))}
            </div>
          </Acordeon>
        )}

        {/* ── Referencias ────────────────────────── */}
        <Acordeon titulo="Registros y fuente" icono={ICONOS.referencias}>
          <div className="detail-grid">
            <Field label="Registro SAG Chile" value={medicamento.registro_sag} sinDato />
            <Field label="Registro SENASA Argentina" value={medicamento.registro_senasa} sinDato />
            <Field label="Fuente de dosis" value={medicamento.fuente} sinDato />
          </div>
          {medicamento.url_referencia && (
            <p className="detail-text">
              <a href={medicamento.url_referencia} target="_blank" rel="noreferrer noopener">
                Ver referencia externa ↗
              </a>
            </p>
          )}
        </Acordeon>

        {/* ── Aviso de datos pendientes ──────────── */}
        {pendientes.length > 0 && (
          <aside className="pendientes-nota">
            <span className="pendientes-icono" aria-hidden="true">📋</span>
            <div>
              <strong>Datos pendientes de completar:</strong> {pendientes.join(', ')}.
              <p>Podés ayudar a la comunidad completando esta ficha desde el catálogo.</p>
            </div>
          </aside>
        )}

        <div className="detail-actions">
          <Link to={`/calculadora?medicamento=${medicamento.id}`} className="btn btn-primary">🧮 Calculadora completa</Link>
          <Link to={backTo} className="btn btn-secondary">Ver catálogo</Link>
        </div>
      </article>
    </div>
  )
}
