import supabase from './supabase'

/**
 * Servicio para gestionar el historial de cálculos en Supabase
 */
export const historialService = {
  /**
   * Crear un nuevo registro en el historial de cálculos
   * @param {object} data - Datos del cálculo a guardar
   * @returns {object} Registro creado
   */
  async createHistorial(data) {
    const { data: inserted, error } = await supabase
      .from('historial_calculos')
      .insert([data])
      .select()
      .single()

    if (error) throw error
    return inserted
  },

  /**
   * Obtener el historial de cálculos para un usuario específico
   * @param {string} userId - ID del usuario
   * @returns {Array} Lista de cálculos
   */
  async getHistorialForUser(userId) {
    const { data, error } = await supabase
      .from('historial_calculos')
      .select('*, medicamentos(nombre, principio_activo)')
      .eq('usuario_id', userId)
      .order('created_at', { ascending: false })

    if (error) throw error
    return data || []
  }
}

export default historialService
