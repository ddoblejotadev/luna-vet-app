import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import medicamentosService from '../services/medicamentosService'
import './pages.css'

export default function MedicamentosPage() {
  const { user } = useAuth()
  const [medicamentos, setMedicamentos] = useState([])
  const [familias, setFamilias] = useState([])
  const [selectedFamilia, setSelectedFamilia] = useState('')
  const [selectedEspecie, setSelectedEspecie] = useState('')
  const [selectedNivelRiesgo, setSelectedNivelRiesgo] = useState('')
  const [search, setSearch] = useState('')
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

  useEffect(() => {
    loadData()
  }, [selectedEspecie, selectedFamilia, selectedNivelRiesgo])

  const loadData = async () => {
    setLoading(true)
    try {
      const [meds, fams] = await Promise.all([
        medicamentosService.getAllMedicamentos({
          especie: selectedEspecie,
          familia: selectedFamilia,
          search,
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
  }

  const handleSearch = async (e) => {
    const query = e.target.value
    setSearch(query)

    try {
      const meds = await medicamentosService.getAllMedicamentos({
        especie: selectedEspecie,
        familia: selectedFamilia,
        search: query,
        nivelRiesgo: selectedNivelRiesgo,
      })
      setMedicamentos(meds)
    } catch (error) {
      console.error('Error searching:', error)
    }
  }

  const handleCreate = async (e) => {
    e.preventDefault()
    if (!user) return
    setSubmitting(true)
    setFormError(null)
    try {
      const nuevo = {
        ...form,
        especies_permitidas: form.especies_permitidas
          ? form.especies_permitidas.split(',').map((s) => s.trim()).filter(Boolean)
          : [],
        activo: true,
        creado_por: user.id,
      }
      await medicamentosService.createMedicamento(nuevo)
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
      loadData()
    } catch (error) {
      console.error('Error creating medicamento:', error)
      setFormError(error.message || 'No se pudo crear el medicamento')
    } finally {
      setSubmitting(false)
    }
  }

  const handleDelete = async (id, nombre) => {
    if (!user) return
    if (!window.confirm(`¿Eliminar "${nombre}"? Esta acción no se puede deshacer.`)) return
    try {
      await medicamentosService.deleteMedicamento(id)
      loadData()
    } catch (error) {
      console.error('Error deleting medicamento:', error)
      alert('No se pudo eliminar el medicamento')
    }
  }

  return (
    <div className="page medicamentos-page">
      <h1>Catálogo de Medicamentos</h1>

      <div className="filters-section" style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap', marginBottom: '2rem' }}>
        <input
          type="text"
          placeholder="Buscar por nombre, principio activo, familia..."
          value={search}
          onChange={handleSearch}
          className="search-input"
          style={{ flex: '1', minWidth: '220px', padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
        />

        <select
          value={selectedEspecie}
          onChange={(e) => setSelectedEspecie(e.target.value)}
          className="filter-select"
          style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
        >
          <option value="">Todas las especies</option>
          <option value="Perro">Perro</option>
          <option value="Gato">Gato</option>
        </select>

        <select
          value={selectedFamilia}
          onChange={(e) => setSelectedFamilia(e.target.value)}
          className="filter-select"
          style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
        >
          <option value="">Todas las familias</option>
          {familias.map((familia) => (
            <option key={familia} value={familia}>
              {familia}
            </option>
          ))}
        </select>

        <select
          value={selectedNivelRiesgo}
          onChange={(e) => setSelectedNivelRiesgo(e.target.value)}
          className="filter-select"
          style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
        >
          <option value="">Todos los niveles de riesgo</option>
          <option value="normal">Normal</option>
          <option value="precaucion">Precaución</option>
          <option value="alto">Alto</option>
          <option value="critico">Crítico</option>
        </select>
      </div>

      {user && (
        <div style={{ marginBottom: '2rem' }}>
          <button
            onClick={() => setShowForm(!showForm)}
            style={{ padding: '0.75rem 1.5rem', borderRadius: 'var(--radius)', border: 'none', background: 'var(--primary)', color: 'white', cursor: 'pointer', fontWeight: 600 }}
          >
            {showForm ? 'Cancelar' : '+ Agregar medicamento'}
          </button>

          {showForm && (
            <form onSubmit={handleCreate} style={{ marginTop: '1rem', padding: '1.5rem', border: '1px solid var(--gray-300)', borderRadius: 'var(--radius)', display: 'grid', gap: '1rem' }}>
              <h3 style={{ margin: 0 }}>Nuevo medicamento</h3>
              {formError && <p style={{ color: 'var(--danger, red)' }}>{formError}</p>}
              <input
                required
                placeholder="Nombre *"
                value={form.nombre}
                onChange={(e) => setForm({ ...form, nombre: e.target.value })}
                style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
              />
              <input
                placeholder="Principio activo"
                value={form.principio_activo}
                onChange={(e) => setForm({ ...form, principio_activo: e.target.value })}
                style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
              />
              <input
                required
                placeholder="Familia terapéutica *"
                value={form.familia_terapeutica}
                onChange={(e) => setForm({ ...form, familia_terapeutica: e.target.value })}
                style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
              />
              <input
                placeholder="Presentación"
                value={form.presentacion}
                onChange={(e) => setForm({ ...form, presentacion: e.target.value })}
                style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
              />
              <input
                placeholder="Concentración"
                value={form.concentracion}
                onChange={(e) => setForm({ ...form, concentracion: e.target.value })}
                style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
              />
              <input
                placeholder="Dosis recomendada"
                value={form.dosis_recomendada}
                onChange={(e) => setForm({ ...form, dosis_recomendada: e.target.value })}
                style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
              />
              <input
                placeholder="Especies permitidas (separadas por coma)"
                value={form.especies_permitidas}
                onChange={(e) => setForm({ ...form, especies_permitidas: e.target.value })}
                style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
              />
              <select
                value={form.nivel_riesgo}
                onChange={(e) => setForm({ ...form, nivel_riesgo: e.target.value })}
                style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: '1px solid var(--gray-300)' }}
              >
                <option value="normal">Normal</option>
                <option value="precaucion">Precaución</option>
                <option value="alto">Alto</option>
                <option value="critico">Crítico</option>
              </select>
              <button
                type="submit"
                disabled={submitting}
                style={{ padding: '0.75rem', borderRadius: 'var(--radius)', border: 'none', background: 'var(--primary)', color: 'white', cursor: submitting ? 'wait' : 'pointer', fontWeight: 600, opacity: submitting ? 0.6 : 1 }}
              >
                {submitting ? 'Creando...' : 'Crear medicamento'}
              </button>
            </form>
          )}
        </div>
      )}

      {loading ? (
        <p>Cargando medicamentos...</p>
      ) : medicamentos.length === 0 ? (
        <p>No se encontraron medicamentos con los filtros seleccionados.</p>
      ) : (
        <div className="medicamentos-grid" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: '1.5rem' }}>
          {medicamentos.map((med) => (
            <div key={med.id} className="medicamento-card">
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '0.5rem' }}>
                <Link to={`/medicamentos/${med.id}`} style={{ margin: 0, fontSize: '1.2rem', color: 'var(--primary)', textDecoration: 'none', fontWeight: 600 }}>
                  {med.nombre}
                </Link>
                <span className={`badge risk-${med.nivel_riesgo || 'normal'}`}>
                  {med.nivel_riesgo || 'normal'}
                </span>
                {user && med.creado_por === user.id && (
                  <button
                    onClick={() => handleDelete(med.id, med.nombre)}
                    style={{ margin: 0, marginLeft: '0.5rem', color: 'var(--danger, red)', fontSize: '0.9rem', background: 'none', border: 'none', cursor: 'pointer' }}
                  >
                    Eliminar
                  </button>
                )}
              </div>

              {med.principio_activo && (
                <p style={{ color: 'var(--gray-600)', fontSize: '0.9rem', marginBottom: '0.5rem' }}>
                  <strong>Principio activo:</strong> {med.principio_activo}
                </p>
              )}

              <p style={{ color: 'var(--gray-600)', fontSize: '0.9rem', marginBottom: '0.5rem' }}>
                <strong>Familia:</strong> {med.familia_terapeutica || 'General'}
              </p>

              {med.dosis_recomendada && (
                <p style={{ color: 'var(--gray-700)', fontSize: '0.9rem', marginBottom: '0.75rem' }}>
                  <strong>Dosis:</strong> {med.dosis_recomendada}
                </p>
              )}

              <div style={{ marginTop: '0.75rem', borderTop: '1px solid var(--gray-100)', paddingTop: '0.75rem' }}>
                <div style={{ marginBottom: '0.5rem' }}>
                  <strong>Especies permitidas:</strong>{' '}
                  {med.especies_permitidas && med.especies_permitidas.length > 0 ? (
                    med.especies_permitidas.map((esp) => (
                      <span key={esp} className="badge badge-especie">{esp}</span>
                    ))
                  ) : (
                    <span>General</span>
                  )}
                </div>

                {med.especies_contraindicadas && med.especies_contraindicadas.length > 0 && (
                  <div style={{ marginBottom: '0.5rem' }}>
                    <strong>Contraindicadas:</strong>{' '}
                    {med.especies_contraindicadas.map((esp) => (
                      <span key={esp} className="badge badge-contraindicada">{esp}</span>
                    ))}
                  </div>
                )}

                {med.alertas_clinicas && med.alertas_clinicas.length > 0 && (
                  <div className="clinical-alert-box">
                    <strong>Alertas clínicas:</strong>
                    <ul style={{ margin: '0.25rem 0 0 1rem', padding: 0 }}>
                      {med.alertas_clinicas.map((alerta, index) => (
                        <li key={index}>{alerta}</li>
                      ))}
                    </ul>
                  </div>
                )}
                <Link to={`/medicamentos/${med.id}`} className="btn btn-secondary" style={{ marginTop: '0.75rem', display: 'inline-block', fontSize: '0.85rem', padding: '0.5rem 1rem' }}>
                  Ver ficha
                </Link>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
