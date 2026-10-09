import supabase from './supabase'

/**
 * Servicio para gestionar medicamentos en Supabase
 */

class MedicamentosService {
  applyMedicamentosFilters(queryBuilder, filters = {}) {
    const { familia, especie, search, nivelRiesgo } = filters

    let builder = queryBuilder

    if (familia) {
      builder = builder.eq('familia_terapeutica', familia)
    }

    if (especie) {
      builder = builder.contains('especies_permitidas', [especie])
    }

    if (nivelRiesgo && nivelRiesgo !== 'todos') {
      builder = builder.eq('nivel_riesgo', nivelRiesgo)
    }

    if (search && search.trim().length > 0) {
      // Evita romper la sintaxis de or() de Supabase con caracteres especiales.
      const cleanSearch = search
        .trim()
        .replace(/[(),\\"%*]/g, '')

      if (cleanSearch.length > 0) {
        builder = builder.or(
          `nombre.ilike.%${cleanSearch}%,principio_activo.ilike.%${cleanSearch}%,familia_terapeutica.ilike.%${cleanSearch}%,dosis_recomendada.ilike.%${cleanSearch}%`
        )
      }
    }

    return builder
  }

  /**
   * Obtener todos los medicamentos
   */
  async getAllMedicamentos(filters = {}) {
    try {
      const query = supabase
        .from('medicamentos')
        .select('*')
        .order('nombre', { ascending: true })

      const { data, error } = await this.applyMedicamentosFilters(query, filters)

      if (error) throw error
      return data || []
    } catch (error) {
      console.error('Error fetching medicamentos:', error)
      return []
    }
  }

  /**
   * Obtener medicamentos por familia terapéutica
   */
  async getMedicamentosByFamilia(familia, filters = {}) {
    try {
      return await this.getAllMedicamentos({ ...filters, familia })
    } catch (error) {
      console.error('Error fetching medicamentos by familia:', error)
      return []
    }
  }

  /**
   * Buscar medicamentos por nombre, principio activo, familia o indicación
   */
  async searchMedicamentos(query, filters = {}) {
    try {
      return await this.getAllMedicamentos({ ...filters, search: query })
    } catch (error) {
      console.error('Error searching medicamentos:', error)
      return []
    }
  }

  /**
   * Obtener especies disponibles
   */
  async getEspecies() {
    try {
      const { data, error } = await supabase
        .from('especies')
        .select('id, nombre')
        .in('nombre', ['Perro', 'Gato'])
        .order('nombre', { ascending: true })

      if (error) throw error
      return data || []
    } catch (error) {
      console.error('Error fetching especies:', error)
      return []
    }
  }

  /**
   * Obtener medicamento por ID
   */
  async getMedicamento(id) {
    try {
      const { data, error } = await supabase
        .from('medicamentos')
        .select('*')
        .eq('id', id)
        .single()

      if (error) throw error
      return data
    } catch (error) {
      console.error('Error fetching medicamento:', error)
      return null
    }
  }

  /**
   * Crear nuevo medicamento (admin)
   */
  async createMedicamento(medicamento) {
    try {
      const { data, error } = await supabase
        .from('medicamentos')
        .insert([medicamento])
        .select()
        .single()

      if (error) throw error
      return data
    } catch (error) {
      console.error('Error creating medicamento:', error)
      throw error
    }
  }

  /**
   * Actualizar medicamento (admin)
   */
  async updateMedicamento(id, updates) {
    try {
      const { data, error } = await supabase
        .from('medicamentos')
        .update(updates)
        .eq('id', id)
        .select()
        .single()

      if (error) throw error
      return data
    } catch (error) {
      console.error('Error updating medicamento:', error)
      throw error
    }
  }

  /**
   * Obtener todas las familias terapéuticas únicas
   */
  async getAllFamiliasTerapeuticas() {
    try {
      const { data, error } = await supabase
        .from('medicamentos')
        .select('familia_terapeutica')
        .not('familia_terapeutica', 'is', null)
        .order('familia_terapeutica', { ascending: true })

      if (error) throw error
      return [...new Set((data || []).map((item) => item.familia_terapeutica))]
    } catch (error) {
      console.error('Error fetching therapeutic families:', error)
      return []
    }
  }

  async getFamiliasTerapeuticas() {
    return this.getAllFamiliasTerapeuticas()
  }

  /**
   * Obtener todas las alertas clínicas únicas
   */
  async getAllAlertasClinicas() {
    try {
      const { data, error } = await supabase
        .from('medicamentos')
        .select('alertas_clinicas')
        .not('alertas_clinicas', 'is', null)

      if (error) throw error
      const allAlerts = (data || []).flatMap(
        (item) => item.alertas_clinicas || []
      )
      return [...new Set(allAlerts)].sort()
    } catch (error) {
      console.error('Error fetching clinical alerts:', error)
      return []
    }
  }

  /**
   * Obtener todos los niveles de riesgo
   */
  async getAllNivelesRiesgo() {
    // These are predefined values from the database constraint
    return ['normal', 'precaucion', 'alto', 'critico']
  }
}

export default new MedicamentosService()
