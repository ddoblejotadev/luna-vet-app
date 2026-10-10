import { useState, useEffect, useMemo, useCallback } from 'react'
import { Link, useSearchParams, useLocation } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import medicamentosService from '../services/medicamentosService'
import './pages.css'

const PAGE_SIZE = 12

export default function MedicamentosPage() {
  const { user } = useAuth()
  const [searchParams, setSearchParams] = useSearchParams()
  const location = useLocation()

  // Filtros persistidos en la URL: al volver atrás el navegador restaura el estado
  const selectedFamilia = searchParams.get('familia') || ''
  const selectedEspecie = searchParams.get('especie') || ''
  const selectedNivelRiesgo = searchParams.get('riesgo') || 'todos'
  const searchFromUrl = searchParams.get('q') || ''
  const pageFromUrl = Math.max(1, parseInt(searchParams.get('page') || '1', 10) || 1)

  const [medicamentos, setMedicamentos] = useState([])
  const [familias, setFamilias] = useState([])
  const [searchInput, setSearchInput] = useState(searchFromUrl)
  const [loading, setLoading] = useState(true)
  const [showForm, setShowForm] = useState(false)
  const [submitting, setSubmitting] = useState(false)
  const [formError, setFormError] = useState(null)
  const [form, setForm] = useState({
    nombre: '',
    principio_activo: '',
    familia_terapeutica: '',
    presentacion: '',
    concentracion: '',
    dosis_recomendada: '',
    especies_permitidas: '',
    nivel_riesgo: 'normal',
  })

  const updateParams = useCallback((changes, replace = false) => {
    const next = new URLSearchParams(searchParams)
    Object.entries(changes).forEach(([key, value]) => {
      if (value === null || value === undefined || value === '') {
        next.delete(key)
      } else {
        next.set(key, String(value))
      }
    })
    setSearchParams(next, { replace })
  }, [searchParams, setSearchParams])

  // Sincroniza el input de búsqueda con lo que viene de la URL (ej. al volver atrás)
  useEffect(() => {
    setSearchInput(searchFromUrl)
  }, [searchFromUrl])

  // Debounce: escribe la búsqueda en la URL y vuelve a la página 1
  useEffect(() => {
    const timer = setTimeout(() => {
      if (searchInput !== searchFromUrl) {
        updateParams({ q: searchInput.trim() || null, page: null })
      }
    }, 300)
    return () => clearTimeout(timer)
  }, [searchInput, searchFromUrl, updateParams])

  const loadData = useCallback(async () => {
    setLoading(true)
    try {
      const [meds, fams] = await Promise.all([
        medicamentosService.getAllMedicamentos({
          especie: selectedEspecie,
          familia: selectedFamilia,
          search: searchFromUrl,
          nivelRiesgo: selectedNivelRiesgo,
        }),
        medicamentosService.getAllFamiliasTerapeuticas(),
      ])
      setMedicamentos(meds)
      setFamilias(fams)
    } catch (error) {
      console.error('Error loading data:', error)
    } finally {
      setLoading(false)
    }
  }, [selectedEspecie, selectedFamilia, selectedNivelRiesgo, searchFromUrl])

  useEffect(() => {
    loadData()
  }, [loadData])

  const handleFamiliaChange = (e) => {
    updateParams({ familia: e.target.value || null, page: null })
  }

  const handleEspecieChange = (e) => {
    updateParams({ especie: e.target.value || null, page: null })
  }

  const handleNivelRiesgoChange = (e) => {
    updateParams({ riesgo: e.target.value === 'todos' ? null : e.target.value, page: null })
  }

  const handlePageChange = (page) => {
    updateParams({ page: page > 1 ? String(page) : null })
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

  const handleSearchChange = (e) => {
    setSearchInput(e.target.value)
  }

  // Paginación derivada
  const totalPages = Math.max(1, Math.ceil(medicamentos.length / PAGE_SIZE))
  const currentPage = Math.min(pageFromUrl, totalPages)

  // Si la página de la URL quedó fuera de rango (ej. cambió el filtro), corregirla
  useEffect(() => {
    if (pageFromUrl > totalPages) {
      updateParams({ page: totalPages > 1 ? String(totalPages) : null }, true)
    }
  }, [pageFromUrl, totalPages, updateParams])

  const paginatedMedicamentos = useMemo(() => {
    const start = (currentPage - 1) * PAGE_SIZE
    return medicamentos.slice(start, start + PAGE_SIZE)
  }, [medicamentos, currentPage])

  const pageNumbers = useMemo(() => {
    if (totalPages <= 7) {
      return Array.from({ length: totalPages }, (_, i) => i + 1)
    }
    const pages = [1]
    const left = Math.max(2, currentPage - 1)
    const right = Math.min(totalPages - 1, currentPage + 1)
    if (left > 2) pages.push('…')
    for (let i = left; i <= right; i++) pages.push(i)
    if (right < totalPages - 1) pages.push('…')
    pages.push(totalPages)
    return pages
  }, [currentPage, totalPages])

  const handleCreateMedicamento = async (e) => {
    e.preventDefault()
    setSubmitting(true)
    setFormError(null)

    try {
      const especiesArray = form.especies_permitidas
        ? form.especies_permitidas.split(',').map(s => s.trim()).filter(Boolean)
        : []

      const { data, error } = await medicamentosService.createMedicamento({
        nombre: form.nombre.trim(),
        principio_activo: form.principio_activo.trim(),
        familia_terapeutica: form.familia_terapeutica.trim(),
        presentacion: form.presentacion.trim(),
        concentracion: form.concentracion.trim(),
        dosis_recomendada: form.dosis_recomendada.trim(),
        especies_permitidas: especiesArray,
        nivel_riesgo: form.nivel_riesgo,
        creador_id: user?.id,
      })

      if (error) throw error

      // Si el filtro de familia activa no coincide con el nuevo medicamento,
      // limpiamos los filtros para que el usuario lo vea en la lista
      const mismoFamilia = !selectedFamilia || selectedFamilia === form.familia_terapeutica.trim()
      if (!mismoFamilia) {
        setSearchParams(new URLSearchParams())
      }

      await loadData()
      setShowForm(false)
      setForm({
        nombre: '',
        principio_activo: '',
        familia_terapeutica: '',
        presentacion: '',
        concentracion: '',
        dosis_recomendada: '',
        especies_permitidas: '',
        nivel_riesgo: 'normal',
      })
    } catch (error) {
      console.error('Error creating medicamento:', error)
      setFormError(error.message || 'Error al crear el medicamento')
    } finally {
      setSubmitting(false)
    }
  }

  const handleFormChange = (e) => {
    const { name, value } = e.target
    setForm(prev => ({ ...prev, [name]: value }))
  }

  const startIndex = (currentPage - 1) * PAGE_SIZE
  const endIndex = Math.min(startIndex + PAGE_SIZE, medicamentos.length)

  return (
    <div className="page medicamentos-page">
      <header className="page-header">
        <div>
          <p className="eyebrow">Catálogo</p>
          <h1>Medicamentos Veterinarios</h1>
          <p className="lead-small">
            Base de datos clínica para estudio y consulta rápida.
          </p>
        </div>
        {user && (
          <button
            className="btn btn-primary"
            onClick={() => setShowForm(!showForm)}
          >
            {showForm ? 'Cancelar' : '+ Nuevo medicamento'}
          </button>
        )}
      </header>

      {/* Filtros */}
      <div className="filters-bar">
        <div className="search-box">
          <input
            type="text"
            placeholder="Buscar por nombre, principio activo, familia, uso..."
            value={searchInput}
            onChange={handleSearchChange}
            className="search-input"
          />
          {searchInput && (
            <button
              className="search-clear"
              onClick={() => {
                setSearchInput('')
                updateParams({ q: null, page: null })
              }}
              aria-label="Limpiar búsqueda"
            >
              ×
            </button>
          )}
        </div>

        <select
          value={selectedFamilia}
          onChange={handleFamiliaChange}
          className="filter-select"
        >
          <option value="">Todas las familias</option>
          {familias.map(fam => (
            <option key={fam} value={fam}>{fam}</option>
          ))}
        </select>

        <select
          value={selectedEspecie}
          onChange={handleEspecieChange}
          className="filter-select"
        >
          <option value="">Todas las especies</option>
          <option value="Perro">Perro</option>
          <option value="Gato">Gato</option>
          <option value="Equino">Equino</option>
          <option value="Bovino">Bovino</option>
          <option value="Ovino">Ovino</option>
          <option value="Porcino">Porcino</option>
          <option value="Aves">Aves</option>
        </select>

        <select
          value={selectedNivelRiesgo}
          onChange={handleNivelRiesgoChange}
          className="filter-select"
        >
          <option value="todos">Todos los niveles</option>
          <option value="normal">Normal</option>
          <option value="precaucion">Precaución</option>
          <option value="alto">Alto</option>
          <option value="critico">Crítico</option>
        </select>
      </div>

      {showForm && (
        <div className="modal-overlay">
          <div className="modal">
            <div className="modal-header">
              <h3>Nuevo medicamento</h3>
              <button
                className="modal-close"
                onClick={() => setShowForm(false)}
              >
                ×
              </button>
            </div>
            <form onSubmit={handleCreateMedicamento}>
              <div className="form-group">
                <label>Nombre comercial *</label>
                <input
                  name="nombre"
                  value={form.nombre}
                  onChange={handleFormChange}
                  required
                  placeholder="Ej: Ketamina"
                />
              </div>

              <div className="form-group">
                <label>Principio activo *</label>
                <input
                  name="principio_activo"
                  value={form.principio_activo}
                  onChange={handleFormChange}
                  required
                  placeholder="Ej: Ketamina HCl"
                />
              </div>

              <div className="form-group">
                <label>Familia terapéutica *</label>
                <input
                  name="familia_terapeutica"
                  value={form.familia_terapeutica}
                  onChange={handleFormChange}
                  required
                  placeholder="Ej: Anestésicos"
                />
              </div>

              <div className="form-group">
                <label>Presentación</label>
                <input
                  name="presentacion"
                  value={form.presentacion}
                  onChange={handleFormChange}
                  placeholder="Ej: Frasco 10 mL"
                />
              </div>

              <div className="form-group">
                <label>Concentración</label>
                <input
                  name="concentracion"
                  value={form.concentracion}
                  onChange={handleFormChange}
                  placeholder="Ej: 50 mg/mL"
                />
              </div>

              <div className="form-group">
                <label>Dosis recomendada</label>
                <input
                  name="dosis_recomendada"
                  value={form.dosis_recomendada}
                  onChange={handleFormChange}
                  placeholder="Ej: 5-10 mg/kg IV"
                />
              </div>

              <div className="form-group">
                <label>Epecies permitidas (separadas por coma)</label>
                <input
                  name="especies_permitidas"
                  value={form.especies_permitidas}
                  onChange={handleFormChange}
                  placeholder="Ej: Perro, Gato"
                />
              </div>

              <div className="form-group">
                <label>Nivel de riesgo</label>
                <select
                  name="nivel_riesgo"
                  value={form.nivel_riesgo}
                  onChange={handleFormChange}
                >
                  <option value="normal">Normal</option>
                  <option value="precaucion">Precaución</option>
                  <option value="alto">Alto</option>
                  <option value="critico">Crítico</option>
                </select>
              </div>

              {formError && (
                <div className="form-error">{formError}</div>
              )}

              <div className="modal-actions">
                <button
                  type="button"
                  className="btn btn-secondary"
                  onClick={() => setShowForm(false)}
                >
                  Cancelar
                </button>
                <button
                  type="submit"
                  className="btn btn-primary"
                  disabled={submitting}
                >
                  {submitting ? 'Creando...' : 'Crear medicamento'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Resultados */}
      <div className="results-summary">
        <span>
          {medicamentos.length === 0
            ? 'Sin resultados'
            : `Mostrando ${startIndex + 1}–${endIndex} de ${medicamentos.length} medicamentos`}
        </span>
        {(selectedFamilia || selectedEspecie || selectedNivelRiesgo !== 'todos' || searchFromUrl) && (
          <button
            className="btn btn-secondary btn-sm"
            onClick={() => setSearchParams(new URLSearchParams())}
          >
            Limpiar filtros
          </button>
        )}
      </div>

      {loading ? (
        <div className="loading-state">
          <p>Cargando catálogo...</p>
        </div>
      ) : medicamentos.length === 0 ? (
        <div className="empty-state">
          <p>No se encontraron medicamentos con esos filtros.</p>
          <button
            className="btn btn-secondary"
            onClick={() => setSearchParams(new URLSearchParams())}
          >
            Limpiar filtros
          </button>
        </div>
      ) : (
        <>
          <div className="medicamentos-grid">
            {paginatedMedicamentos.map((medicamento) => {
              const riskLevel = medicamento.nivel_riesgo || 'normal'
              return (
                <Link
                  key={medicamento.id}
                  to={`/medicamentos/${medicamento.id}`}
                  state={{ from: `${location.pathname}${location.search}` }}
                  className={`medicamento-card risk-border-${riskLevel}`}
                >
                  <div className="medicamento-card-header">
                    <h3>{medicamento.nombre}</h3>
                    <span className={`badge risk-${riskLevel}`}>
                      {riskLevel === 'normal' && 'Normal'}
                      {riskLevel === 'precaucion' && 'Precaución'}
                      {riskLevel === 'alto' && 'Alto'}
                      {riskLevel === 'critico' && 'Crítico'}
                    </span>
                  </div>
                  <p className="medicamento-card-principio">{medicamento.principio_activo}</p>
                  <p className="medicamento-card-dosis">{medicamento.dosis_recomendada}</p>
                  {medicamento.concentracion && (
                    <p className="medicamento-card-concentracion">{medicamento.concentracion}</p>
                  )}
                  <div className="medicamento-card-footer">
                    <span className="medicamento-card-familia">{medicamento.familia_terapeutica}</span>
                  </div>
                </Link>
              )
            })}
          </div>

          {/* Paginación */}
          {totalPages > 1 && (
            <nav className="pagination" aria-label="Paginación del catálogo">
              <button
                className="pagination-btn"
                onClick={() => handlePageChange(currentPage - 1)}
                disabled={currentPage === 1}
              >
                ← Anterior
              </button>
              <div className="pagination-pages">
                {pageNumbers.map((p, idx) => (
                  p === '…' ? (
                    <span key={`ellipsis-${idx}`} className="pagination-ellipsis">…</span>
                  ) : (
                    <button
                      key={p}
                      className={`pagination-page ${p === currentPage ? 'active' : ''}`}
                      onClick={() => handlePageChange(p)}
                      aria-current={p === currentPage ? 'page' : undefined}
                    >
                      {p}
                    </button>
                  )
                ))}
              </div>
              <button
                className="pagination-btn"
                onClick={() => handlePageChange(currentPage + 1)}
                disabled={currentPage === totalPages}
              >
                Siguiente →
              </button>
            </nav>
          )}
        </>
      )}
    </div>
  )
}
