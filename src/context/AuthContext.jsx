import { createContext, useContext, useEffect, useState } from 'react'
import { authService } from '../services/authService'

const AuthContext = createContext(null)

export const AuthProvider = ({ children }) => {
  const [session, setSession] = useState(null)
  const [user, setUser] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    let mounted = true

    const initializeAuth = async () => {
      try {
        const initialSession = await authService.getCurrentSession()
        if (mounted) {
          setSession(initialSession)
          setUser(initialSession?.user ?? null)
        }
      } catch (error) {
        console.error('Error fetching initial session:', error)
      } finally {
        if (mounted) {
          setLoading(false)
        }
      }
    }

    initializeAuth()

    const subscription = authService.onAuthStateChange((_event, currentSession) => {
      if (mounted) {
        setSession(currentSession)
        setUser(currentSession?.user ?? null)
        setLoading(false)
      }
    })

    return () => {
      mounted = false
      subscription?.unsubscribe?.()
    }
  }, [])

  const signIn = async (email, password) => {
    return await authService.signInWithPassword(email, password)
  }

  const signUp = async (email, password, metadata = {}) => {
    const options = metadata && Object.keys(metadata).length > 0 ? { data: metadata } : {}
    return await authService.signUp(email, password, options)
  }

  const signOut = async () => {
    return await authService.signOut()
  }

  const value = {
    session,
    user,
    loading,
    signIn,
    signUp,
    signOut
  }

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  )
}

export { AuthContext }
