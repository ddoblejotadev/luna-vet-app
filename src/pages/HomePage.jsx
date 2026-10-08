import { Link } from 'react-router-dom'
import './pages.css'

export default function HomePage() {
  return (
    <div className="page home-page">
      <section className="hero">
        <h1>Bienvenido a LunaVet</h1>
        <p className="lead">Tu calculadora veterinaria inteligente para gestión de dosis y medicamentos</p>

        <div className="features-grid">
          <article className="feature-card">
            <div className="feature-icon">📊</div>
            <h2>Catálogo Completo</h2>
            <p>Acceso a una base de datos de medicamentos veterinarios clasificados por familia terapéutica</p>
          </article>

          <article className="feature-card">
            <div className="feature-icon">⚡</div>
            <h2>Cálculo Automático</h2>
            <p>Calcula dosis exactas según el peso del animal en segundos</p>
          </article>

          <article className="feature-card">
            <div className="feature-icon">📱</div>
            <h2>Responsive Design</h2>
            <p>Funciona perfectamente en iPhone, iPad y computadoras</p>
          </article>

          <article className="feature-card">
            <div className="feature-icon">🔒</div>
            <h2>Seguridad</h2>
            <p>Tus datos están protegidos con encriptación de nivel empresarial</p>
          </article>
        </div>

        <div className="cta-buttons">
          <Link to="/medicamentos" className="btn btn-primary">
            Ver Medicamentos
          </Link>
          <Link to="/calculadora" className="btn btn-secondary">
            Abrir Calculadora
          </Link>
        </div>
      </section>

      <section className="families">
        <h2>Familias Terapéuticas</h2>
        <div className="families-grid">
          <div className="family-card">
            <span className="icon">💉</span>
            <span className="name">Sedantes y Anestésicos</span>
          </div>
          <div className="family-card">
            <span className="icon">💊</span>
            <span className="name">Analgésicos / Antiinflamatorios</span>
          </div>
          <div className="family-card">
            <span className="icon">🦠</span>
            <span className="name">Antibióticos / Antimicrobianos</span>
          </div>
          <div className="family-card">
            <span className="icon">🧪</span>
            <span className="name">Vitaminas y Suplementos</span>
          </div>
          <div className="family-card">
            <span className="icon">🤢</span>
            <span className="name">Gastrointestinales</span>
          </div>
          <div className="family-card">
            <span className="icon">🫀</span>
            <span className="name">Cardiovasculares</span>
          </div>
        </div>
      </section>

      <section className="sources">
        <h2>Fuentes Confiables</h2>
        <p className="lead-small">Nuestros datos provienen de fuentes oficiales verificadas</p>
        <ul className="sources-list">
          <li><strong>DailyMed:</strong> Etiquetas de aprobación FDA</li>
          <li><strong>NOAH Compendium:</strong> Medicamentos veterinarios UK</li>
          <li><strong>WSAVA:</strong> Asociación Mundial de Veterinarios de Pequeños Animales</li>
          <li><strong>SENASA Argentina:</strong> Registro oficial de productos</li>
        </ul>
      </section>
    </div>
  )
}
