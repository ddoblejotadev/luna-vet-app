import { Routes, Route } from 'react-router-dom'
import Layout from './components/Layout'
import HomePage from './pages/HomePage'
import MedicamentosPage from './pages/MedicamentosPage'
import MedicamentoDetallePage from './pages/MedicamentoDetallePage'
import CalculadoraPage from './pages/CalculadoraPage'
import AuthPage from './pages/AuthPage'
import { AuthProvider } from './context/AuthContext'
import './App.css'

function App() {
  return (
    <AuthProvider>
      <Layout>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/medicamentos" element={<MedicamentosPage />} />
          <Route path="/medicamentos/:id" element={<MedicamentoDetallePage />} />
          <Route path="/calculadora" element={<CalculadoraPage />} />
          <Route path="/login" element={<AuthPage />} />
        </Routes>
      </Layout>
    </AuthProvider>
  )
}

export default App

