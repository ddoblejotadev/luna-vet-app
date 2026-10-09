import { useState } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import './pages.css'

export default function AuthPage() {
  const { user, loading, signIn, signUp, signOut } = useAuth()
  const navigate = useNavigate()

  const [isRegister, setIsRegister] = useState(false)
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [fullName, setFullName] = useState('')
  const [error, setError] = useState(null)
  const [submitting, setSubmitting] = useState(false)

  if (loading) {
    return (
      <div className="page auth-page">
        <div className="auth-container">
          <p>Cargando sesión...</p>
        </div>
      </div>
    )
  }

  if (user) {
    return (
      <div className="page auth-page">
        <div className="auth-container card">
          <h1>¡Sesión Activa!</h1>
          <p className="lead-small">
            Ya has iniciado sesión con el correo <strong>{user.email}</strong>.
          </p>
          <div className="cta-buttons">
            <Link to="/calculadora" className="btn btn-primary">Ir a la Calculadora</Link>
            <button 
              onClick={async () => {
                try {
                  await signOut()
                } catch (err) {
                  setError(err.message)
                }
              }} 
              className="btn btn-secondary"
            >
              Cerrar Sesión
            </button>
          </div>
          {error && <div className="auth-error">{error}</div>}
        </div>
      </div>
    )
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError(null)
    setSubmitting(true)

    try {
      if (isRegister) {
        await signUp(email, password, fullName ? { full_name: fullName } : {})
      } else {
        await signIn(email, password)
      }
      navigate('/calculadora')
    } catch (err) {
      console.error('Auth error:', err)
      setError(err.message || 'Ocurrió un error en la autenticación')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="page auth-page">
      <div className="auth-container card">
        <div className="auth-header">
          <h1>{isRegister ? 'Crear Cuenta' : 'Iniciar Sesión'}</h1>
          <p className="subtitle">
            {isRegister 
              ? 'Regístrate para guardar tu historial de cálculos en LunaVet' 
              : 'Accede a tu cuenta de LunaVet'}
          </p>
        </div>

        <div className="auth-tabs">
          <button 
            type="button" 
            className={`auth-tab ${!isRegister ? 'active' : ''}`}
            onClick={() => { setIsRegister(false); setError(null); }}
          >
            Iniciar Sesión
          </button>
          <button 
            type="button" 
            className={`auth-tab ${isRegister ? 'active' : ''}`}
            onClick={() => { setIsRegister(true); setError(null); }}
          >
            Registrarse
          </button>
        </div>

        {error && <div className="auth-error">{error}</div>}

        <form onSubmit={handleSubmit} className="auth-form">
          {isRegister && (
            <div className="form-group">
              <label htmlFor="fullName">Nombre completo (opcional)</label>
              <input 
                id="fullName"
                type="text" 
                value={fullName}
                onChange={(e) => setFullName(e.target.value)}
                placeholder="Dr. Juan Pérez"
              />
            </div>
          )}

          <div className="form-group">
            <label htmlFor="email">Correo electrónico</label>
            <input 
              id="email"
              type="email" 
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="tu@correo.com"
            />
          </div>

          <div className="form-group">
            <label htmlFor="password">Contraseña</label>
            <input 
              id="password"
              type="password" 
              required
              minLength={6}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="••••••••"
            />
          </div>

          <button 
            type="submit" 
            className="btn btn-primary auth-submit"
            disabled={submitting}
          >
            {submitting ? 'Procesando...' : (isRegister ? 'Crear Cuenta' : 'Iniciar Sesión')}
          </button>
        </form>
      </div>
    </div>
  )
}
