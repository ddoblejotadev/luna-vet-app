import supabase from './supabase'

/**
 * Servicio para gestionar medicamentos en Supabase
 */

class MedicamentosService {
  /**
   * Obtener todos los medicamentos
   */
  async getAllMedicamentos() {
    try {
      const { data, error } = await supabase
        .from('medicamentos')
        .select('*')
        .order('nombre', { ascending: true })

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
  async getMedicamentosByFamilia(familia) {
    try {
      const { data, error } = await supabase
        .from('medicamentos')
        .select('*')
        .eq('familia_terapeutica', familia)
        .order('nombre', { ascending: true })

      if (error) throw error
      return data || []
    } catch (error) {
      console.error('Error fetching medicamentos by familia:', error)
      return []
    }
  }

  /**
   * Buscar medicamentos por nombre
   */
  async searchMedicamentos(query) {
    try {
      const { data, error } = await supabase
        .from('medicamentos')
        .select('*')
        .ilike('nombre', `%${query}%`)
        .order('nombre', { ascending: true })

      if (error) throw error
      return data || []
    } catch (error) {
      console.error('Error searching medicamentos:', error)
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
   * Obtener familias terapéuticas únicas
   */
  async getFamiliasTerapeuticas() {
    try {
      const { data, error } = await supabase
        .from('medicamentos')
        .select('familia_terapeutica')
        .distinct()

      if (error) throw error
      return data?.map(d => d.familia_terapeutica).filter(Boolean) || []
    } catch (error) {
      console.error('Error fetching familias terapeuticas:', error)
      return []
    }
  }
}

export default new MedicamentosService()
