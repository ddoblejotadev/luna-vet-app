import { useEffect, useMemo, useState } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import ReporteDosis from '../components/ReporteDosis'
import { useDosisCalculator } from '../hooks/useDosisCalculator'
import medicamentosService from '../services/medicamentosService'
import historialService from '../services/historialService'
import './pages.css'

// ---------- Utilidades ----------

// Normaliza texto para búsqueda insensible a acentos (café = cafe)
const normalizar = (texto) =>
  (texto || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')

// ---------- Protocolos predefinidos de anestesia ----------

const PROTOCOLOS = [
  {
    nombre: 'Sedación ligera — Perro',
    especie: 'Perro',
    pasos: [
      { medicamento: 'Acepromazina', dosis: '0.03', unidad: 'mg/kg', via: 'IM' },
      { medicamento: 'Butorfanol (analgesia)', dosis: '0.2', unidad: 'mg/kg', via: 'IM' },
    ],
  },
  {
    nombre: 'Sedación moderada — Perro',
    especie: 'Perro',
    pasos: [
      { medicamento: 'Dexmedetomidina', dosis: '0.005', unidad: 'mg/kg', via: 'IM' },
      { medicamento: 'Metadona (analgesia)', dosis: '0.2', unidad: 'mg/kg', via: 'IM' },
    ],
  },
  {
    nombre: 'Anestesia general — Perro',
    especie: 'Perro',
    pasos: [
      { medicamento: 'Dexmedetomidina', dosis: '0.005', unidad: 'mg/kg', via: 'IM' },
      { medicamento: 'Metadona (analgesia)', dosis: '0.2', unidad: 'mg/kg', via: 'IM' },
      { medicamento: 'Propofol', dosis: '4', unidad: 'mg/kg', via: 'IV hasta efecto' },
      { medicamento: 'Isoflurano', dosis: '1.5–2.5', unidad: '% mantenimiento', via: 'Inhalatorio' },
    ],
  },
  {
    nombre: 'Anestesia general — Gato',
    especie: 'Gato',
    pasos: [
      { medicamento: 'Medetomidina', dosis: '0.004', unidad: 'mg/kg', via: 'IM' },
      { medicamento: 'Metadona (analgesia)', dosis: '0.2', unidad: 'mg/kg', via: 'IM' },
      { medicamento: 'Alfaxalona (IV)', dosis: '3', unidad: 'mg/kg', via: 'IV hasta efecto' },
      { medicamento: 'Sevoflurano', dosis: '2.5–3.5', unidad: '% mantenimiento', via: 'Inhalatorio' },
    ],
  },
  {
    nombre: 'Sedación campo — Equino',
    especie: 'Equino',
    pasos: [
      { medicamento: 'Xilacina', dosis: '1', unidad: 'mg/kg', via: 'IV' },
      { medicamento: 'Butorfanol (analgesia)', dosis: '0.02', unidad: 'mg/kg', via: 'IV' },
    ],
  },
]

// ---------- Datos MAC para inhalatorios (Lumb & Jones / Plumb's) ----------

const MAC_BASE = {
  isoflurano: { nombre: 'Isoflurano', perro: 1.3, gato: 1.6 },
  sevoflurano: { nombre: 'Sevoflurano', perro: 2.4, gato: 2.6 },
  desflurano: { nombre: 'Desflurano', perro: 7.2, gato: 10.3 },
}

const AJUSTES_MAC = [
  { id: 'opioides', label: 'Opioides preoperatorios', factor: 0.20 },
  { id: 'alpha2', label: 'Alpha-2 agonistas (dexmedetomidina/xilacina)', factor: 0.30 },
  { id: 'ketamina', label: 'Ketamina', factor: 0.20 },
  { id: 'benzo', label: 'Benzodiacepinas (midazolam)', factor: 0.10 },
  { id: 'geriatrico', label: 'Paciente geriátrico (>8 años)', factor: 0.15 },
]

// ---------- Componente ----------

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
  const [medicamentoSearch, setMedicamentoSearch] = useState('')
  const [showSuggestions, setShowSuggestions] = useState(false)
  const [peso, setPeso] = useState('')
  const [dosisPorKg, setDosisPorKg] = useState('')
  const [dosisMinPorKg, setDosisMinPorKg] = useState('')
  const [dosisMaxPorKg, setDosisMaxPorKg] = useState('')
  const [frecuencia, setFrecuencia] = useState('12')
  const [concentracionMgMl, setConcentracionMgMl] = useState('')
  const [metodo, setMetodo] = useState('peso')
  const [margen, setMargen] = useState('10')
  const [saving, setSaving] = useState(false)
  const [saved, setSaved] = useState(false)
  const [saveError, setSaveError] = useState(null)
  const [pestana, setPestana] = useState('calculadora')

  // Estado para la calculadora MAC
  const [macAgente, setMacAgente] = useState('isoflurano')
  const [macEspecie, setMacEspecie] = useState('perro')
  const [macAjustes, setMacAjustes] = useState({})
  const [macHipotermia, setMacHipotermia] = useState('37')

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

        if (!isMounted) return
        setMedicamentos(meds || [])
        setEspecies(esps || [])

        const medicamentoParam = searchParams.get('medicamento')
        if (medicamentoParam) {
          const encontrado = (meds || []).find(
            (med) =>
              med.nombre?.toLowerCase() === medicamentoParam.toLowerCase() ||
              normalizar(med.nombre) === normalizar(medicamentoParam)
          )
          if (encontrado) {
            setMedicamentoId(encontrado.id)
            setMedicamentoSearch(encontrado.nombre)
          }
        }
      } catch (err) {
        if (!isMounted) return
        console.error('Error loading data:', err)
        setMedicamentosError('No se pudieron cargar los medicamentos')
      } finally {
        if (isMounted) setMedicamentosLoading(false)
      }
    }

    loadData()
    return () => {
      isMounted = false
    }
  }, [searchParams])

  // Búsqueda insensible a acentos con ranking:
  // 1) empiezan con el término, 2) contienen en nombre, 3) principio/familia.
  // Muestra TODOS los matches (sin límite), con scroll en el dropdown.
  const filteredMedicamentos = useMemo(() => {
    const termino = normalizar(medicamentoSearch.trim())

    if (!termino) return medicamentos

    const empiezaNombre = []
    const contieneNombre = []
    const otros = []

    for (const med of medicamentos) {
      const nombre = normalizar(med.nombre)
      const principio = normalizar(med.principio_activo)
      const familia = normalizar(med.familia_terapeutica)

      if (nombre.startsWith(termino)) empiezaNombre.push(med)
      else if (nombre.includes(termino)) contieneNombre.push(med)
      else if (principio.includes(termino) || familia.includes(termino)) otros.push(med)
    }

    return [...empiezaNombre, ...contieneNombre, ...otros]
  }, [medicamentos, medicamentoSearch])

  const handleSelectMedicamento = (med) => {
    setMedicamentoId(med.id)
    setMedicamentoSearch(med.nombre)
    setShowSuggestions(false)
    handleMedicamentoSelect(med)
  }

  const handleSearchChange = (e) => {
    setMedicamentoSearch(e.target.value)
    setShowSuggestions(true)
    if (!e.target.value) setMedicamentoId('')
  }

  const handleMedicamentoSelect = (medicamento) => {
    resetear()
    setSaved(false)
    setSaveError(null)

    if (!medicamento) {
      setMetodo('peso')
      setDosisMinPorKg('')
      setDosisMaxPorKg('')
      setConcentracionMgMl('')
      return
    }

    if (medicamento.concentracion_mg_ml) {
      setConcentracionMgMl(medicamento.concentracion_mg_ml.toString())
    } else {
      setConcentracionMgMl('')
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
        setMedicamentoSearch('')
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
      setSaveError(null)
    } catch (err) {
      console.error('Error saving to historial:', err)
      setSaveError(err.message || 'No se pudo guardar en el historial')
    } finally {
      setSaving(false)
    }
  }

  const handleCalcular = (e) => {
    e.preventDefault()

    try {
      const pesoNum = parseFloat(peso)
      const concMgMl = concentracionMgMl !== '' ? parseFloat(concentracionMgMl) : null

      if (isNaN(pesoNum) || pesoNum <= 0) {
        alert('Ingresá un peso válido mayor a 0')
        return
      }

      if (!medicamentoId && !dosisPorKg) {
        alert('Seleccioná un medicamento o ingresá una dosis')
        return
      }

      const frecuenciaNum = parseInt(frecuencia, 10) || 12
      let resultObj = null;

      switch (metodo) {
        case 'peso': {
          const dosisNum = parseFloat(dosisPorKg)

          if (isNaN(dosisNum)) {
            alert('La dosis debe ser un número válido')
            return
          }

          resultObj = calcularPorPeso(pesoNum, dosisNum, frecuenciaNum, concMgMl)
          break
        }
        case 'catalogo': {
          const minNum = parseFloat(dosisMinPorKg)
          const maxNum = parseFloat(dosisMaxPorKg)

          if (isNaN(minNum) || isNaN(maxNum)) {
            alert('Las dosis mínima y máxima deben ser números válidos')
            return
          }

          resultObj = calcularRangoPorPeso(pesoNum, minNum, maxNum, frecuenciaNum, concMgMl)
          break
        }
        case 'bsa': {
          const dosisNum = parseFloat(dosisPorKg)

          if (isNaN(dosisNum)) {
            alert('La dosis por m² debe ser un número válido')
            return
          }

          resultObj = calcularPorBSA(pesoNum, dosisNum, concMgMl)
          break
        }
        case 'margen': {
          const dosisNum = parseFloat(dosisPorKg)

          if (isNaN(dosisNum)) {
            alert('La dosis debe ser un número válido')
            return
          }

          resultObj = calcularConMargen(pesoNum, dosisNum, parseInt(margen), concMgMl)
          break
        }
        default:
          break
      }

      // Validar techos absolutos (mg/kg) para fármacos críticos (lidocaína, bupivacaína, etc.)
      if (resultObj && selectedMedicamento?.nombre) {
        const checkDosisMaxima = (maxPermitido, medRegex) => {
          if (medRegex.test(normalizar(selectedMedicamento.nombre))) {
            const dosisDada = resultObj.dosisMaxSingle 
              ? (resultObj.dosisMaxSingle / pesoNum) 
              : (resultObj.dosisSingle ? (resultObj.dosisSingle / pesoNum) : null);
              
            if (dosisDada !== null && dosisDada > maxPermitido) {
              return `¡Atención! La dosis calculada (${dosisDada.toFixed(2)} mg/kg) supera el máximo de seguridad general para este fármaco (${maxPermitido} mg/kg).`;
            }
          }
          return null;
        }

        const max_warnings = [
          checkDosisMaxima(8, /lidocaina/),     // Límite aprox lidocaína perro (8 mg/kg total dia)
          checkDosisMaxima(2, /bupivacaina/)      // Límite aprox bupi perro (2 mg/kg total)
        ].filter(Boolean);

        if (max_warnings.length > 0) {
           setResultado(prev => ({...prev, maxWarning: max_warnings[0]}))
        }
      }

    } catch (err) {
      console.error('Calculation error:', err)
    }
  }

  // Carga un paso de protocolo en la calculadora
  const handleUsarPasoProtocolo = (paso) => {
    const med = medicamentos.find(
      (m) => normalizar(m.nombre) === normalizar(paso.medicamento)
    )
    if (med) {
      setMedicamentoId(med.id)
      setMedicamentoSearch(med.nombre)
      handleMedicamentoSelect(med)
    }
    setPestana('calculadora')
  }

  // ---------- Cálculo MAC ----------

  const macResultado = useMemo(() => {
    const agente = MAC_BASE[macAgente]
    if (!agente) return null

    const base = agente[macEspecie] || agente.perro
    let reduccion = 0

    for (const ajuste of AJUSTES_MAC) {
      if (macAjustes[ajuste.id]) reduccion += ajuste.factor
    }

    // Hipotermia: -5% del MAC por cada °C bajo 37
    const temp = parseFloat(macHipotermia)
    if (!isNaN(temp) && temp < 37) {
      reduccion += 0.05 * (37 - temp)
    }

    // Tope de reducción segura (no bajar de 30% del MAC base)
    const reduccionLimitada = Math.min(reduccion, 0.7)
    const macAjustado = base * (1 - reduccionLimitada)

    return {
      base,
      ajustado: Number(macAjustado.toFixed(2)),
      reduccion: Math.round(reduccionLimitada * 100),
    }
  }, [macAgente, macEspecie, macAjustes, macHipotermia])

  const toggleAjusteMac = (id) => {
    setMacAjustes((prev) => ({ ...prev, [id]: !prev[id] }))
  }

  // ---------- Render ----------

  return (
    <div className="page calculadora-page">
      <h1>Calculadora de Dosis Clínicas</h1>

      <div className="calc-tabs" role="tablist">
        <button
          type="button"
          role="tab"
          aria-selected={pestana === 'calculadora'}
          className={`calc-tab ${pestana === 'calculadora' ? 'active' : ''}`}
          onClick={() => setPestana('calculadora')}
        >
          Calculadora de dosis
        </button>
        <button
          type="button"
          role="tab"
          aria-selected={pestana === 'mac'}
          className={`calc-tab ${pestana === 'mac' ? 'active' : ''}`}
          onClick={() => setPestana('mac')}
        >
          MAC inhalatorios
        </button>
      </div>

      {pestana === 'mac' ? (
        <div className="calculadora-container">
          <div className="calculadora-form">
            <div className="calc-step">
              <h3 className="calc-step-title"><span>1</span>Agente inhalatorio</h3>
              <div className="form-group">
                <label htmlFor="mac-agente">Agente</label>
                <select
                  id="mac-agente"
                  value={macAgente}
                  onChange={(e) => setMacAgente(e.target.value)}
                  className="form-control"
                >
                  {Object.values(MAC_BASE).map((a) => (
                    <option key={a.nombre} value={Object.keys(MAC_BASE).find((k) => MAC_BASE[k] === a)}>
                      {a.nombre}
                    </option>
                  ))}
                </select>
              </div>
              <div className="form-group">
                <label htmlFor="mac-especie">Especie</label>
                <select
                  id="mac-especie"
                  value={macEspecie}
                  onChange={(e) => setMacEspecie(e.target.value)}
                  className="form-control"
                >
                  <option value="perro">Perro</option>
                  <option value="gato">Gato</option>
                </select>
              </div>
            </div>

            <div className="calc-step">
              <h3 className="calc-step-title"><span>2</span>Condiciones del paciente</h3>
              <p className="calc-hint">Cada factor reduce el MAC requerido (menor necesidad de agente).</p>
              <div className="mac-ajustes">
                {AJUSTES_MAC.map((ajuste) => (
                  <label key={ajuste.id} className="mac-ajuste">
                    <input
                      type="checkbox"
                      checked={!!macAjustes[ajuste.id]}
                      onChange={() => toggleAjusteMac(ajuste.id)}
                    />
                    <span>{ajuste.label} <em>(−{Math.round(ajuste.factor * 100)}%)</em></span>
                  </label>
                ))}
                <div className="form-group" style={{ marginTop: '0.75rem' }}>
                  <label htmlFor="mac-hipotermia">Temperatura corporal (°C)</label>
                  <input
                    id="mac-hipotermia"
                    type="number"
                    step="0.1"
                    value={macHipotermia}
                    onChange={(e) => setMacHipotermia(e.target.value)}
                    className="form-control"
                  />
                  <p className="calc-hint">Hipotermia: −5% del MAC por cada °C bajo 37 °C.</p>
                </div>
              </div>
            </div>
          </div>

          <div className="calculadora-resultado">
            <h2>Resultado MAC</h2>
            {macResultado && (
              <div className="resultado-content">
                <div className="resultado-card mac-resultado screen-only">
                  <p className="mac-agente-nombre">{MAC_BASE[macAgente].nombre} — {macEspecie}</p>
                  <div className="mac-valores">
                    <div className="mac-valor">
                      <span className="mac-valor-label">MAC base</span>
                      <span className="mac-valor-numero">{macResultado.base}%</span>
                    </div>
                    <div className="mac-valor destacado">
                      <span className="mac-valor-label">MAC ajustado</span>
                      <span className="mac-valor-numero">{macResultado.ajustado}%</span>
                    </div>
                  </div>
                  <p className="notas-clinicas">
                    Reducción total aplicada: <strong>{macResultado.reduccion}%</strong>
                  </p>
                  <p className="calc-hint">
                    El MAC ajustado es la concentración alveolar mínima esperada. Siempre confirmá
                    la profundidad anestésica con signos clínicos (reflejos, tono mandibular, parámetros
                    vitales) y ajustá según respuesta del paciente.
                  </p>
                </div>
              </div>
            )}
          </div>
        </div>
      ) : (
        <div className="calculadora-container">
          {/* Protocolos predefinidos */}
          <section className="calc-protocolos">
            <h2 className="calc-section-title">Protocolos predefinidos</h2>
            <p className="calc-hint">
              Pautas de referencia por especie. Tocá un paso para cargarlo en la calculadora y
              ajustar al peso del paciente.
            </p>
            <div className="protocolos-grid">
              {PROTOCOLOS.map((protocolo) => (
                <article key={protocolo.nombre} className="protocolo-card">
                  <header className="protocolo-header">
                    <h3>{protocolo.nombre}</h3>
                    <span className="badge badge-especie">{protocolo.especie}</span>
                  </header>
                  <ol className="protocolo-pasos">
                    {protocolo.pasos.map((paso, idx) => (
                      <li key={idx} className="protocolo-paso">
                        <button
                          type="button"
                          className="protocolo-paso-btn"
                          onClick={() => handleUsarPasoProtocolo(paso)}
                          title="Cargar en la calculadora"
                        >
                          <span className="protocolo-paso-num">{idx + 1}</span>
                          <span className="protocolo-paso-info">
                            <strong>{paso.medicamento}</strong>
                            <span>
                              {paso.dosis} {paso.unidad} · {paso.via}
                            </span>
                          </span>
                        </button>
                      </li>
                    ))}
                  </ol>
                </article>
              ))}
            </div>
          </section>

          <div className="calculadora-container-dos-columnas">
            <div className="calculadora-form">
              <form onSubmit={handleCalcular}>
                <div className="calc-step">
                  <h3 className="calc-step-title"><span>1</span>Paciente y medicamento</h3>

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

                  <div className="form-group" style={{ position: 'relative' }}>
                    <label htmlFor="medicamento-search">Buscar medicamento</label>
                    <input
                      id="medicamento-search"
                      type="text"
                      value={medicamentoSearch}
                      onChange={handleSearchChange}
                      onFocus={() => setShowSuggestions(true)}
                      onBlur={() => setTimeout(() => setShowSuggestions(false), 150)}
                      placeholder="Escribe el nombre (sin tildes también funciona)..."
                      className="form-control"
                      autoComplete="off"
                    />
                    {showSuggestions && filteredMedicamentos.length > 0 && (
                      <ul className="suggestions-list">
                        {filteredMedicamentos.map((med) => (
                          <li
                            key={med.id}
                            onMouseDown={() => handleSelectMedicamento(med)}
                            className={`suggestion-item ${med.id === medicamentoId ? 'selected' : ''}`}
                          >
                            <span className="suggestion-nombre">{med.nombre}</span>
                            {med.principio_activo && (
                              <span className="suggestion-sub">{med.principio_activo}</span>
                            )}
                            {med.familia_terapeutica && (
                              <span className="suggestion-familia">{med.familia_terapeutica}</span>
                            )}
                          </li>
                        ))}
                      </ul>
                    )}
                    {showSuggestions && medicamentoSearch && filteredMedicamentos.length === 0 && (
                      <ul className="suggestions-list">
                        <li className="suggestion-empty">Sin resultados para "{medicamentoSearch}"</li>
                      </ul>
                    )}
                  </div>

                  {selectedMedicamento && (
                    <div className="med-card">
                      <div className="med-card-header">
                        <h4>{selectedMedicamento.nombre}</h4>
                        <span className={`badge risk-${selectedMedicamento.nivel_riesgo || 'normal'}`}>
                          Riesgo: {selectedMedicamento.nivel_riesgo || 'normal'}
                        </span>
                      </div>
                      {selectedMedicamento.principio_activo && (
                        <p><strong>Principio activo:</strong> {selectedMedicamento.principio_activo}</p>
                      )}
                      {selectedMedicamento.familia_terapeutica && (
                        <p><strong>Familia:</strong> {selectedMedicamento.familia_terapeutica}</p>
                      )}
                      {selectedMedicamento.dosis_recomendada && (
                        <p className="med-card-dosis"><strong>Dosis recomendada:</strong> {selectedMedicamento.dosis_recomendada}</p>
                      )}
                      {selectedMedicamento.via_administracion && (
                        <p><strong>Vía:</strong> {selectedMedicamento.via_administracion}</p>
                      )}
                      {selectedMedicamento.especies_permitidas && selectedMedicamento.especies_permitidas.length > 0 && (
                        <div className="med-card-especies">
                          {selectedMedicamento.especies_permitidas.map((esp) => (
                            <span key={esp} className="badge badge-especie">{esp}</span>
                          ))}
                        </div>
                      )}
                      {selectedMedicamento.indicaciones && (
                        <p className="med-card-indicaciones"><strong>Indicaciones:</strong> {selectedMedicamento.indicaciones}</p>
                      )}
                      <p className="med-card-disclaimer" style={{ marginTop: '0.75rem', fontSize: '0.82rem', color: 'var(--text-muted, #6b7280)', fontStyle: 'italic', borderTop: '1px dashed var(--border, #e5e7eb)', paddingTop: '0.5rem' }}>
                        Nota: Las dosis sugeridas son bibliográficas. Confirmá siempre con el veterinario responsable antes de usarlas clínicamente.
                      </p>
                    </div>
                  )}

                  {isContraindicated && (
                    <p className="error-text">
                      ⚠️ Contraindicado para {selectedEspecie}. El cálculo está bloqueado.
                    </p>
                  )}
                </div>

                <div className="calc-step">
                  <h3 className="calc-step-title"><span>2</span>Peso y dosis</h3>

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
                      className="form-control"
                    />
                  </div>

                  <div className="form-group">
                    <label htmlFor="metodo">Método de cálculo</label>
                    <select
                      id="metodo"
                      value={metodo}
                      onChange={(e) => {
                        setMetodo(e.target.value)
                        resetear()
                        setSaved(false)
                      }}
                      className="form-control"
                    >
                      <option value="peso">Dosis fija por kg</option>
                      <option value="catalogo">Rango de dosis del catálogo</option>
                      <option value="bsa">Superficie corporal (BSA)</option>
                      <option value="margen">Cálculo con margen de seguridad</option>
                    </select>
                  </div>

                  {metodo === 'peso' && (
                    <div className="form-group">
                      <label htmlFor="dosisPorKg">Dosis por kg (mg/kg)</label>
                      <input
                        id="dosisPorKg"
                        type="number"
                        step="0.01"
                        placeholder="Ej. 0.5"
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
                          placeholder="Ej. 2"
                          value={dosisPorKg}
                          onChange={(e) => setDosisPorKg(e.target.value)}
                          className="form-control"
                        />
                      </div>
                      <div className="form-group">
                        <label htmlFor="margen">Margen de seguridad (%)</label>
                        <select
                          id="margen"
                          value={margen}
                          onChange={(e) => setMargen(e.target.value)}
                          className="form-control"
                        >
                          <option value="5">±5%</option>
                          <option value="10">±10%</option>
                          <option value="15">±15%</option>
                          <option value="20">±20%</option>
                        </select>
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
                  
                  <div className="form-group calc-concentracion-input">
                    <label htmlFor="concentracion-input">Concentración (mg/mL) - opcional, para calcular mL</label>
                    <input
                      id="concentracion-input"
                      className="form-control"
                      type="number"
                      min="0"
                      step="0.01"
                      placeholder="Ej: 10"
                      value={concentracionMgMl}
                      onChange={(e) => setConcentracionMgMl(e.target.value)}
                    />
                  </div>

                  <div className="form-actions">
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
                </div>
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
                    {resultado.maxWarning && (
                      <div style={{ marginTop: '1rem', padding: '0.75rem', backgroundColor: '#fffbeb', borderLeft: '4px solid var(--warning, #f59e0b)', borderRadius: '4px' }}>
                        <strong style={{color: '#92400e'}}>{resultado.maxWarning}</strong>
                      </div>
                    )}
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
      )}
    </div>
  )
}
