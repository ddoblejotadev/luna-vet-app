/**
 * Payment Service with Exponential Backoff Retry Logic
 * Maneja reintentos para evitar "Maximum combo retry limit reached"
 */

const MAX_RETRIES = 3
const BASE_DELAY = 1000 // 1 segundo
const MAX_DELAY = 10000 // 10 segundos
const JITTER_FACTOR = 0.1 // 10% de jitter

class PaymentService {
  /**
   * Calcula el delay exponencial con jitter
   */
  getBackoffDelay(attempt) {
    const exponentialDelay = Math.min(BASE_DELAY * Math.pow(2, attempt), MAX_DELAY)
    const jitter = exponentialDelay * JITTER_FACTOR * Math.random()
    return exponentialDelay + jitter
  }

  /**
   * Reintentar con backoff exponencial
   */
  async retryWithBackoff(fn, context = 'Payment operation') {
    let lastError = null

    for (let attempt = 0; attempt < MAX_RETRIES; attempt++) {
      try {
        console.log(`[PaymentService] ${context} - Intento ${attempt + 1}/${MAX_RETRIES}`)
        return await fn()
      } catch (error) {
        lastError = error
        console.error(`[PaymentService] ${context} falló en intento ${attempt + 1}:`, error.message)

        // No reintentar si es error de cliente (4xx)
        if (error.status >= 400 && error.status < 500) {
          throw error
        }

        // Esperar antes de reintentar
        if (attempt < MAX_RETRIES - 1) {
          const delay = this.getBackoffDelay(attempt)
          console.log(`[PaymentService] Reintentando en ${Math.round(delay)}ms...`)
          await new Promise(resolve => setTimeout(resolve, delay))
        }
      }
    }

    throw new Error(`${context} failed after ${MAX_RETRIES} attempts: ${lastError?.message}`)
  }

  /**
   * Procesar pago con Stripe
   */
  async processStripePayment(amount, token) {
    return this.retryWithBackoff(
      async () => {
        const response = await fetch('/api/payments/stripe', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ amount, token }),
        })

        if (!response.ok) {
          const error = new Error('Stripe payment failed')
          error.status = response.status
          throw error
        }

        return response.json()
      },
      'Stripe payment'
    )
  }

  /**
   * Procesar pago con MercadoPago
   */
  async processMercadoPagoPayment(amount, paymentMethodId) {
    return this.retryWithBackoff(
      async () => {
        const response = await fetch('/api/payments/mercadopago', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ amount, paymentMethodId }),
        })

        if (!response.ok) {
          const error = new Error('MercadoPago payment failed')
          error.status = response.status
          throw error
        }

        return response.json()
      },
      'MercadoPago payment'
    )
  }

  /**
   * Procesar pago con PayPal
   */
  async processPayPalPayment(orderId) {
    return this.retryWithBackoff(
      async () => {
        const response = await fetch('/api/payments/paypal', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ orderId }),
        })

        if (!response.ok) {
          const error = new Error('PayPal payment failed')
          error.status = response.status
          throw error
        }

        return response.json()
      },
      'PayPal payment'
    )
  }

  /**
   * Obtener estado de un pago
   */
  async getPaymentStatus(paymentId) {
    return this.retryWithBackoff(
      async () => {
        const response = await fetch(`/api/payments/status/${paymentId}`)

        if (!response.ok) {
          const error = new Error('Failed to get payment status')
          error.status = response.status
          throw error
        }

        return response.json()
      },
      'Get payment status'
    )
  }

  /**
   * Reembolsar pago
   */
  async refundPayment(paymentId, amount = null) {
    return this.retryWithBackoff(
      async () => {
        const response = await fetch(`/api/payments/refund/${paymentId}`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ amount }),
        })

        if (!response.ok) {
          const error = new Error('Refund failed')
          error.status = response.status
          throw error
        }

        return response.json()
      },
      'Refund payment'
    )
  }
}

export default new PaymentService()
