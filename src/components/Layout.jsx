import { useState } from 'react'
import { Link, NavLink } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import './Layout.css'

export default function Layout({ children }) {
  const { user, signOut } = useAuth()
  const [menuOpen, setMenuOpen] = useState(false)

  const closeMenu = () => setMenuOpen(false)

  const navLinkClass = ({ isActive }) =>
    isActive ? 'nav-link nav-link--active' : 'nav-link'

  return (
    <div className="app">
      <header className="header">
        <nav className="navbar">
          <Link to="/" className="navbar-brand" onClick={closeMenu}>
            <h1>🐾 LunaVet</h1>
            <span className="subtitle">Calculadora Veterinaria Inteligente</span>
          </Link>

          <button
            type="button"
            className="navbar-toggle"
            aria-label={menuOpen ? 'Cerrar menú' : 'Abrir menú'}
            aria-expanded={menuOpen}
            onClick={() => setMenuOpen((open) => !open)}
          >
            <span aria-hidden="true">{menuOpen ? '✕' : '☰'}</span>
          </button>

          <div className={`navbar-collapse ${menuOpen ? 'is-open' : ''}`}>
            <ul className="nav-links">
              <li><NavLink to="/" className={navLinkClass} onClick={closeMenu}>Inicio</NavLink></li>
              <li><NavLink to="/medicamentos" className={navLinkClass} onClick={closeMenu}>Medicamentos</NavLink></li>
              <li><NavLink to="/estudio" className={navLinkClass} onClick={closeMenu}>Estudio</NavLink></li>
              <li><NavLink to="/calculadora" className={navLinkClass} onClick={closeMenu}>Calculadora</NavLink></li>
            </ul>

            <div className="navbar-auth">
              {user ? (
                <div className="user-session">
                  <span className="navbar-user" title={user.email}>{user.email}</span>
                  <button
                    onClick={() => { closeMenu(); signOut() }}
                    className="btn btn-secondary btn-signout"
                    title="Cerrar sesión"
                  >
                    Salir
                  </button>
                </div>
              ) : (
                <Link to="/login" className="btn btn-primary btn-login-nav" onClick={closeMenu}>
                  Iniciar sesión
                </Link>
              )}
            </div>
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
