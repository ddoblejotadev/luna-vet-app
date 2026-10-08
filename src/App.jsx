import { Routes, Route } from 'react-router-dom'
import Layout from './components/Layout'
import HomePage from './pages/HomePage'
import MedicamentosPage from './pages/MedicamentosPage'
import CalculadoraPage from './pages/CalculadoraPage'
import './App.css'

function App() {
  return (
    <Layout>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/medicamentos" element={<MedicamentosPage />} />
        <Route path="/calculadora" element={<CalculadoraPage />} />
      </Routes>
    </Layout>
  )
}

export default App
