import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import medicamentosService from '../services/medicamentosService'
import './pages.css'

const QUESTION_TYPES = [
  {
    key: 'principio',
    label: 'Principio activo',
    question: (med) => `¿Cuál es el principio activo de ${med.nombre}?`,
    answer: (med) => med.principio_activo || 'No informado',
  },
  {
    key: 'familia',
    label: 'Familia terapéutica',
    question: (med) => `¿A qué familia terapéutica pertenece ${med.nombre}?`,
    answer: (med) => med.familia_terapeutica || 'No informado',
  },
  {
    key: 'composicion',
    label: 'Composición',
    question: (med) => `¿Qué composición o concentración tiene ${med.nombre}?`,
    answer: (med) => med.composicion || med.concentracion || 'No informado',
  },
  {
    key: 'mecanismo',
    label: 'Mecanismo',
    question: (med) => `¿Cuál es el mecanismo de acción de ${med.nombre}?`,
    answer: (med) => med.mecanismo_accion || 'No informado',
  },
  {
    key: 'dosis',
    label: 'Dosis',
    question: (med) => `¿Qué dosis recomendada figura para ${med.nombre}?`,
    answer: (med) => med.dosis_recomendada || 'No informado',
  },
  {
    key: 'seguridad',
    label: 'Seguridad por especie',
    question: (med) => `¿Qué especies están permitidas o contraindicadas para ${med.nombre}?`,
    answer: (med) => {
      const permitidas = med.especies_permitidas?.length ? med.especies_permitidas.join(', ') : 'No informado'
      const contraindicadas = med.especies_contraindicadas?.length ? med.especies_contraindicadas.join(', ') : 'Ninguna cargada'
      return `Permitidas: ${permitidas}. Contraindicadas: ${contraindicadas}.`
    },
  },
  {
    key: 'interacciones',
    label: 'Interacciones',
    question: (med) => `¿Qué interacciones conviene revisar en ${med.nombre}?`,
    answer: (med) => med.interacciones || 'No informado',
  },
]

function getCard(medicamentos, cardIndex) {
  if (!medicamentos.length) return null
  const med = medicamentos[cardIndex % medicamentos.length]
  const questionType = QUESTION_TYPES[Math.floor(cardIndex / medicamentos.length) % QUESTION_TYPES.length]
  return { med, questionType }
}

export default function EstudioPage() {
  const [medicamentos, setMedicamentos] = useState([])
  const [familias, setFamilias] = useState([])
  const [selectedFamilia, setSelectedFamilia] = useState('')
  const [selectedRiesgo, setSelectedRiesgo] = useState('')
  const [search, setSearch] = useState('')
  const [cardIndex, setCardIndex] = useState(0)
  const [showAnswer, setShowAnswer] = useState(false)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    let isMounted = true

    async function loadData() {
      try {
        setLoading(true)
        setError(null)
        const [meds, fams] = await Promise.all([
          medicamentosService.getAllMedicamentos({
            familia: selectedFamilia,
            nivelRiesgo: selectedRiesgo,
            search,
          }),
          medicamentosService.getAllFamiliasTerapeuticas(),
        ])
        if (isMounted) {
          setMedicamentos(meds)
          setFamilias(fams)
          setCardIndex(0)
          setShowAnswer(false)
        }
      } catch (err) {
        console.error('Error loading study cards:', err)
        if (isMounted) setError('No se pudo cargar el modo estudio')
      } finally {
        if (isMounted) setLoading(false)
      }
    }

    loadData()

    return () => {
      isMounted = false
    }
  }, [selectedFamilia, selectedRiesgo, search])

  const currentCard = useMemo(() => getCard(medicamentos, cardIndex), [medicamentos, cardIndex])
  const totalCards = medicamentos.length * QUESTION_TYPES.length

  const goNext = () => {
    if (!totalCards) return
    setCardIndex((prev) => (prev + 1) % totalCards)
    setShowAnswer(false)
  }

  const goPrevious = () => {
    if (!totalCards) return
    setCardIndex((prev) => (prev - 1 + totalCards) % totalCards)
    setShowAnswer(false)
  }

  return (
    <div className="page estudio-page">
      <div className="page-header-with-action">
        <div>
          <h1>Modo estudio</h1>
          <p className="lead-small">
            Repasá medicamentos como flashcards: principio activo, composición, mecanismo, dosis, seguridad e interacciones.
          </p>
        </div>
        <Link to="/medicamentos" className="btn btn-secondary">Ver catálogo</Link>
      </div>

      <section className="study-controls">
        <input
          type="text"
          placeholder="Buscar medicamento o principio activo..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="form-control"
        />

        <select
          value={selectedFamilia}
          onChange={(e) => setSelectedFamilia(e.target.value)}
          className="form-control"
        >
          <option value="">Todas las familias</option>
          {familias.map((familia) => (
            <option key={familia} value={familia}>{familia}</option>
          ))}
        </select>

        <select
          value={selectedRiesgo}
          onChange={(e) => setSelectedRiesgo(e.target.value)}
          className="form-control"
        >
          <option value="">Todos los riesgos</option>
          <option value="normal">Normal</option>
          <option value="precaucion">Precaución</option>
          <option value="alto">Alto</option>
          <option value="critico">Crítico</option>
        </select>
      </section>

      {loading && <p>Cargando tarjetas...</p>}
      {error && <p className="error-text">{error}</p>}

      {!loading && !error && currentCard && (
        <section className="study-card">
          <div className="study-card-topline">
            <span>{currentCard.questionType.label}</span>
            <span>{cardIndex + 1} / {totalCards}</span>
          </div>

          <h2>{currentCard.questionType.question(currentCard.med)}</h2>

          <div className={`study-answer ${showAnswer ? 'visible' : ''}`}>
            {showAnswer ? (
              <p>{currentCard.questionType.answer(currentCard.med)}</p>
            ) : (
              <p>Intentá responder antes de revelar la respuesta.</p>
            )}
          </div>

          {showAnswer && currentCard.med.alertas_clinicas?.length > 0 && (
            <div className="study-alerts">
              <strong>Alertas clínicas:</strong>
              <ul>
                {currentCard.med.alertas_clinicas.map((alerta) => (
                  <li key={alerta}>{alerta}</li>
                ))}
              </ul>
            </div>
          )}

          <div className="study-card-actions">
            <button type="button" className="btn btn-secondary" onClick={goPrevious}>Anterior</button>
            <button type="button" className="btn btn-primary" onClick={() => setShowAnswer((prev) => !prev)}>
              {showAnswer ? 'Ocultar respuesta' : 'Mostrar respuesta'}
            </button>
            <button type="button" className="btn btn-secondary" onClick={goNext}>Siguiente</button>
          </div>

          <div className="study-links">
            <Link to={`/medicamentos/${currentCard.med.id}`}>Ver ficha completa</Link>
            <Link to={`/calculadora?medicamento=${currentCard.med.id}`}>Calcular dosis</Link>
          </div>
        </section>
      )}

      {!loading && !error && !currentCard && (
        <div className="empty-state">
          <p>No hay medicamentos para estudiar con esos filtros.</p>
        </div>
      )}
    </div>
  )
}
