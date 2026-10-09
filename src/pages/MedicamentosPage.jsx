import { useState, useEffect } from 'react'
import medicamentosService from '../services/medicamentosService'
import './pages.css'

export default function MedicamentosPage() {
  const [medicamentos, setMedicamentos] = useState([])
  const [familias, setFamilias] = useState([])
  const [selectedFamilia, setSelectedFamilia] = useState('')
  const [selectedEspecie, setSelectedEspecie] = useState('')
  const [selectedNivelRiesgo, setSelectedNivelRiesgo] = useState('')
  const [search, setSearch] = useState('')
  const [loading, setLoading] = useState(true)

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

      {loading ? (
        <p>Cargando medicamentos...</p>
      ) : medicamentos.length === 0 ? (
        <p>No se encontraron medicamentos con los filtros seleccionados.</p>
      ) : (
        <div className="medicamentos-grid" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: '1.5rem' }}>
          {medicamentos.map((med) => (
            <div key={med.id} className="medicamento-card">
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '0.5rem' }}>
                <h3 style={{ margin: 0, fontSize: '1.2rem', color: 'var(--gray-900)' }}>{med.nombre}</h3>
                <span className={`badge risk-${med.nivel_riesgo || 'normal'}`}>
                  {med.nivel_riesgo || 'normal'}
                </span>
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
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
