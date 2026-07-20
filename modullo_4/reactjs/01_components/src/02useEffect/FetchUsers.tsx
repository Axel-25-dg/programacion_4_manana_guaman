// src/components/FetchUser.tsx

import { useState, useEffect } from 'react'

interface Company {
    name: string;
    catchPhrase: string
    bs: string
  }

interface User {
  id:       number
  name:     string
  email:    string
  username: string
  company: Company
}

export default function FetchUser() {
  const [users,    setUsers]    = useState<User[]>([])
  const [loading, setLoading] = useState(false)
  const [error,   setError]   = useState<string | null>(null)

  useEffect(() => {
    // Flag de cancelación — evita race conditions y
    // actualizaciones de estado en componentes desmontados
    let cancelled = false

    async function fetchUsers() {
      setLoading(true)
      setError(null)

      try {
        const res = await fetch(
          `https://jsonplaceholder.typicode.com/users`
        )
        if (!res.ok) throw new Error(`Error HTTP ${res.status}`)

        const data: User[] = await res.json()

        // Solo actualiza si el componente sigue montado
        if (!cancelled) setUsers(data)
      } catch (err) {
        if (!cancelled) {
          setError(err instanceof Error ? err.message : 'Error desconocido')
        }
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    fetchUsers()

    return () => { cancelled = true }
  }, [])

  return (
    <div style={{ maxWidth: 360 }}>
      {loading && (
        <p style={{ color: '#6b7280', fontSize: 14 }}>Cargando...</p>
      )}
      {error && (
        <p style={{ color: '#991b1b', fontSize: 14 }}>Error: {error}</p>
      )}
      {users && !loading && (
        users.map((user) => (
        <div style={{ padding: 14, border: '1px solid #e5e7eb', borderRadius: 8 }}>
          <p style={{ margin: '0 0 4px', fontWeight: 600 }}>{user.name}</p>
          <p style={{ margin: '0 0 4px', fontSize: 13, color: '#6b7280' }}>
            @{user.username}
          </p>
          <p style={{ margin: 0, fontSize: 13, color: '#6b7280' }}>
            {user.email}
          </p>
          <p style={{ margin: 0, fontSize: 13, color: '#6b7280' }}>
            Compañía: {user.company.name}
          </p>
        </div>
        ))
      )}
    </div>
  )
}