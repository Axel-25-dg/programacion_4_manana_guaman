// src/components/WelcomeBanner.tsx

export default function WelcomeBanner() {
  return (
    <div style={{ background: '#0070f3', color: '#fff', padding: '16px 24px', borderRadius: 8 }}>
      <h1 style={{ margin: 0, fontSize: 22 }}>Bienvenido al curso de React</h1>
      <p style={{ margin: '6px 0 0', opacity: 0.85 }}>Desde Seminario de Integración</p>
      <p style={{ margin: '6px 0 0', opacity: 0.85 }}>Versión 1.0.0</p>
    </div>
  )
}