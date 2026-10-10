import { useState } from 'react'
import { Link, NavLink } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import KawaiiSticker from './KawaiiSticker'
import './Layout.css'

const NAV_ITEMS = [
  { to: '/', label: 'Inicio', icon: '🏠', end: true },
  { to: '/medicamentos', label: 'Medicamentos', icon: '💊' },
  { to: '/calculadora', label: 'Calculadora', icon: '🧮' },
  { to: '/historial', label: 'Historial', icon: '🕒' },
  { to: '/estudio', label: 'Estudio', icon: '📚' },
]

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
            <KawaiiSticker size={42} alt="LunaVet, la gatita veterinaria" />
            <span className="brand-text">
              <h1>LunaVet</h1>
              <span className="subtitle">Calculadora Veterinaria</span>
            </span>
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
              {NAV_ITEMS.map((item) => (
                <li key={item.to}>
                  <NavLink
                    to={item.to}
                    end={item.end}
                    className={navLinkClass}
                    onClick={closeMenu}
                  >
                    {item.label}
                  </NavLink>
                </li>
              ))}
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

      {/* Navegación inferior para móvil: acceso directo a las 5 secciones */}
      <nav className="bottom-nav" aria-label="Navegación principal móvil">
        {NAV_ITEMS.map((item) => (
          <NavLink
            key={item.to}
            to={item.to}
            end={item.end}
            className={({ isActive }) =>
              isActive ? 'bottom-nav-item bottom-nav-item--active' : 'bottom-nav-item'
            }
          >
            <span className="bottom-nav-icon" aria-hidden="true">{item.icon}</span>
            <span className="bottom-nav-label">{item.label}</span>
          </NavLink>
        ))}
      </nav>

      <footer className="footer">
        <KawaiiSticker size={40} alt="" />
        <p>&copy; 2026 LunaVet - Calculadora Veterinaria. Hecha con 💗 para clínicas.</p>
      </footer>
    </div>
  )
}
