import { Link } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import './Layout.css'

export default function Layout({ children }) {
  const { user, signOut } = useAuth()
  return (
    <div className="app">
      <header className="header">
        <nav className="navbar">
          <div className="navbar-brand">
            <h1>🐾 LunaVet</h1>
            <span className="subtitle">Calculadora Veterinaria Inteligente</span>
          </div>
          <ul className="nav-links">
            <li><Link to="/">Inicio</Link></li>
            <li><Link to="/medicamentos">Medicamentos</Link></li>
            <li><Link to="/estudio">Estudio</Link></li>
            <li><Link to="/calculadora">Calculadora</Link></li>
          </ul>
          <div className="navbar-auth">
            {user ? (
              <div className="user-session">
                <span className="navbar-user" title={user.email}>{user.email}</span>
                <button 
                  onClick={() => signOut()} 
                  className="btn btn-secondary btn-signout"
                  title="Cerrar sesión"
                >
                  Salir
                </button>
              </div>
            ) : (
              <Link to="/login" className="btn btn-primary btn-login-nav">
                Iniciar sesión
              </Link>
            )}
          </div>
        </nav>
      </header>

      <main className="main-content">
        {children}
      </main>

      <footer className="footer">
        <p>&copy; 2026 LunaVet - Calculadora Veterinaria. Todos los derechos reservados.</p>
      </footer>
    </div>
  )
}
