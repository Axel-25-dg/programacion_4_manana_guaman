// app/index.tsx
import { View, Text } from 'react-native'
import { Paso1 } from './components/Paso1'

// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos. │
// │  1  Paso 1  useState — contador de reintentos                    │
// │  2  Paso 2  useEffect — ping periódico con setInterval           │
// │  3  Paso 3  useRef — foco en TextInput y contador sin re-render  │
// │  4  Paso 4  Hooks nativos de RN — dimensiones, esquema de color  │
// │  5  Paso 5  Custom hook — useConexionSimulada                    │
// │  6  Paso 6  Ejemplo combinado — pantalla de estado del servidor  │
// └──────────────────────────────────────────────────────────────────┘
const PASO = 1

export default function Index() {
  switch (PASO) {
    case 1:
      return <Paso1 />
    default:
      return (
        <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
          <Text>Paso {PASO}: crea la pantalla primero</Text>
        </View>
      )
  }
}
