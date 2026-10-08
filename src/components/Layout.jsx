import { Link } from 'react-router-dom'
import './Layout.css'

export default function Layout({ children }) {
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
            <li><Link to="/calculadora">Calculadora</Link></li>
          </ul>
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
