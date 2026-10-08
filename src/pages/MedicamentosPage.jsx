import { useState, useEffect } from 'react'
import medicamentosService from '../services/medicamentosService'
import './pages.css'

export default function MedicamentosPage() {
  const [medicamentos, setMedicamentos] = useState([])
  const [familias, setFamilias] = useState([])
  const [selectedFamilia, setSelectedFamilia] = useState('')
  const [search, setSearch] = useState('')
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    loadData()
  }, [])

  const loadData = async () => {
    setLoading(true)
    try {
      const [meds, fams] = await Promise.all([
        medicamentosService.getAllMedicamentos(),
        medicamentosService.getFamiliasTerapeuticas(),
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

    if (query.length > 2) {
      const results = await medicamentosService.searchMedicamentos(query)
      setMedicamentos(results)
    } else if (selectedFamilia) {
      const results = await medicamentosService.getMedicamentosByFamilia(selectedFamilia)
      setMedicamentos(results)
    } else {
      loadData()
    }
  }

  const handleFamiliaChange = async (familia) => {
    setSelectedFamilia(familia)
    setSearch('')

    if (familia) {
      const results = await medicamentosService.getMedicamentosByFamilia(familia)
      setMedicamentos(results)
    } else {
      loadData()
    }
  }

  return (
    <div className="page medicamentos-page">
      <h1>Catálogo de Medicamentos</h1>

      <div className="filters-section">
        <input
          type="text"
          placeholder="Buscar medicamento..."
          value={search}
          onChange={handleSearch}
          className="search-input"
        />

        <select
          value={selectedFamilia}
          onChange={(e) => handleFamiliaChange(e.target.value)}
          className="filter-select"
        >
          <option value="">Todas las familias</option>
          {familias.map((familia) => (
            <option key={familia} value={familia}>
              {familia}
            </option>
          ))}
        </select>
      </div>

      {loading ? (
        <div className="loading">Cargando medicamentos...</div>
      ) : medicamentos.length === 0 ? (
        <div className="empty-state">
          <p>No se encontraron medicamentos</p>
        </div>
      ) : (
        <div className="medicamentos-grid">
          {medicamentos.map((med) => (
            <article key={med.id} className="medicamento-card">
              <h3>{med.nombre}</h3>
              {med.familia_terapeutica && (
                <p className="familia">{med.familia_terapeutica}</p>
              )}
              {med.presentacion && (
                <p className="presentacion">{med.presentacion}</p>
              )}
              {med.dosis_recomendada && (
                <p className="dosis">
                  <strong>Dosis:</strong> {med.dosis_recomendada}
                </p>
              )}
            </article>
          ))}
        </div>
      )}
    </div>
  )
}
