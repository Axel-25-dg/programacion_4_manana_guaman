// app/index.tsx
import { useState } from 'react'
import { Alert, Image, Pressable, StyleSheet, Text, View } from 'react-native'

// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos. │
// │  1  Paso 1  Texto y vistas básicas                               │
// │  2  Paso 2  Imágenes y botones                                   │
// │  3  Paso 3  Tarjeta de perfil (ejercicio 1)                      │
// │  4  Paso 4  Selector de tema  (ejercicio 2)                      │
// │  5  Paso 5  Grid de íconos    (ejercicio 3)                      │
// └──────────────────────────────────────────────────────────────────┘
const PASO: number = 1

export default function Index() {
  switch (PASO) {
    case 1:
      return <Paso1 />
    case 2:
      return <Paso2 />
    case 3:
      return <Paso3 />
    case 4:
      return <Paso4 />
    case 5:
      return <Paso5 />
    default:
      return (
        <View style={styles.contenedor}>
          <Text>Paso {PASO}: crea la pantalla primero</Text>
        </View>
      )
  }
}

// ─── Paso 1 — Texto y vistas básicas ───────────────────────────────
function Paso1() {
  return (
    <View style={styles.contenedor}>
      <Text style={styles.titulo}>Sistema de Monitoreo</Text>
      <Text style={styles.subtitulo}>Servidor web-01</Text>
      <Text style={styles.detalle}>10.0.2.10 · Ubuntu 24.04</Text>
    </View>
  )
}

// ─── Paso 2 — Imágenes y botones ───────────────────────────────────
function Paso2() {
  return (
    <View style={styles.contenedor}>
      <Image
        source={{ uri: 'https://reactnative.dev/img/tiny_logo.png' }}
        style={{ width: 80, height: 80 }}
      />
      <Text style={styles.titulo}>Conectar servidor</Text>
      <Pressable
        style={({ pressed }) => [
          styles.boton,
          pressed && styles.botonPresionado,
        ]}
        onPress={() => Alert.alert('Conectando', 'Estableciendo conexión SSH...')}
      >
        <Text style={styles.textoBoton}>Conectar SSH</Text>
      </Pressable>
    </View>
  )
}

// ─── Paso 3 — Tarjeta de perfil ────────────────────────────────────
// Ejercicio 1: <Image> circular + nombre + botón "Seguir"/"Siguiendo"
// que alterna su texto con useState al presionarlo.
function Paso3() {
  const [siguiendo, setSiguiendo] = useState(false)

  return (
    <View style={styles.contenedor}>
      {/* Imagen circular: borderRadius grande sobre tamaño fijo */}
      <Image
        source={{ uri: 'https://i.pravatar.cc/150?img=12' }}
        style={estilosPaso3.avatar}
      />
      <Text style={styles.titulo}>Ada Lovelace</Text>
      <Text style={styles.detalle}>Ingeniera de Software · Madrid</Text>

      <Pressable
        style={({ pressed }) => [
          estilosPaso3.boton,
          siguiendo && estilosPaso3.botonSiguiendo,
          pressed && { opacity: 0.75 },
        ]}
        onPress={() => setSiguiendo(prev => !prev)}
      >
        <Text style={estilosPaso3.textoBoton}>
          {siguiendo ? 'Siguiendo ✓' : 'Seguir'}
        </Text>
      </Pressable>
    </View>
  )
}

const estilosPaso3 = StyleSheet.create({
  avatar: {
    width: 100,
    height: 100,
    borderRadius: 999,   // círculo perfecto sobre dimensiones fijas
    borderWidth: 3,
    borderColor: '#1565c0',
  },
  boton: {
    backgroundColor: '#1565c0',
    paddingVertical: 10,
    paddingHorizontal: 32,
    borderRadius: 24,
    marginTop: 8,
  },
  botonSiguiendo: {
    backgroundColor: '#4caf50',
  },
  textoBoton: {
    color: '#fff',
    fontWeight: '600',
    fontSize: 15,
  },
})

// ─── Paso 4 — Selector de tema ─────────────────────────────────────
// Ejercicio 2: dos Pressable ("Claro" / "Oscuro") que cambian el
// backgroundColor del contenedor guardando el color en useState.
const TEMAS = {
  claro: { fondo: '#f5f5f5', texto: '#1a1a1a', acento: '#1565c0' },
  oscuro: { fondo: '#0d1b2a', texto: '#e0e0e0', acento: '#90caf9' },
}

function Paso4() {
  const [tema, setTema] = useState<'claro' | 'oscuro'>('claro')
  const colores = TEMAS[tema]

  return (
    <View style={[estilosPaso4.contenedor, { backgroundColor: colores.fondo }]}>
      <Text style={[estilosPaso4.titulo, { color: colores.texto }]}>
        Selector de Tema
      </Text>
      <Text style={[estilosPaso4.subtitulo, { color: colores.texto }]}>
        Tema activo: <Text style={{ fontWeight: 'bold' }}>{tema}</Text>
      </Text>

      <View style={estilosPaso4.fila}>
        {(['claro', 'oscuro'] as const).map(opcion => (
          <Pressable
            key={opcion}
            style={({ pressed }) => [
              estilosPaso4.boton,
              { borderColor: colores.acento },
              tema === opcion && { backgroundColor: colores.acento },
              pressed && { opacity: 0.7 },
            ]}
            onPress={() => setTema(opcion)}
          >
            <Text
              style={[
                estilosPaso4.textoBoton,
                { color: tema === opcion ? '#fff' : colores.acento },
              ]}
            >
              {opcion.charAt(0).toUpperCase() + opcion.slice(1)}
            </Text>
          </Pressable>
        ))}
      </View>
    </View>
  )
}

const estilosPaso4 = StyleSheet.create({
  contenedor: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    gap: 20,
  },
  titulo: { fontSize: 22, fontWeight: 'bold' },
  subtitulo: { fontSize: 15 },
  fila: { flexDirection: 'row', gap: 16 },
  boton: {
    paddingVertical: 12,
    paddingHorizontal: 28,
    borderRadius: 8,
    borderWidth: 2,
  },
  textoBoton: { fontWeight: '600', fontSize: 15 },
})

// ─── Paso 5 — Grid de íconos ───────────────────────────────────────
// Ejercicio 3: 6 cuadrados de color en 3 columnas usando solo
// View + Flexbox (flexWrap: 'wrap'). Sin <Image>.
const CUADRADOS = [
  '#ef5350', '#42a5f5', '#66bb6a',
  '#ffa726', '#ab47bc', '#26c6da',
]

function Paso5() {
  return (
    <View style={estilosPaso5.contenedor}>
      <Text style={styles.titulo}>Grid de íconos</Text>
      <Text style={styles.detalle}>3 columnas · solo View + Flexbox</Text>

      {/* flexWrap: 'wrap' distribuye automáticamente en filas de 3 */}
      <View style={estilosPaso5.grid}>
        {CUADRADOS.map((color, i) => (
          <View key={i} style={[estilosPaso5.cuadrado, { backgroundColor: color }]}>
            <Text style={estilosPaso5.numeroCuadrado}>{i + 1}</Text>
          </View>
        ))}
      </View>
    </View>
  )
}

const estilosPaso5 = StyleSheet.create({
  contenedor: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    gap: 20,
  },
  grid: {
    flexDirection: 'row',
    flexWrap: 'wrap',       // permite saltar a la siguiente fila
    width: 264,             // 3 × (80 cuadrado + 8 gap) = 264
    gap: 12,
  },
  cuadrado: {
    width: 80,
    height: 80,
    borderRadius: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  numeroCuadrado: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 22,
  },
})

// ─── Estilos compartidos ────────────────────────────────────────────
const styles = StyleSheet.create({
  contenedor: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    gap: 16,
  },
  titulo: { fontSize: 20, fontWeight: '600' },
  subtitulo: { fontSize: 16, color: '#333' },
  detalle: { fontSize: 13, color: '#777' },
  boton: {
    backgroundColor: '#1565c0',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
  },
  botonPresionado: { backgroundColor: '#0d47a1' },
  textoBoton: { color: '#fff', fontWeight: '600', fontSize: 16 },
})
