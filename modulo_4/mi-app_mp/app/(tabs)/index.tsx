import { Image } from 'expo-image';
import { Platform, StyleSheet } from 'react-native';

import { HelloWave } from '@/components/hello-wave';
import ParallaxScrollView from '@/components/parallax-scroll-view';
import { ThemedText } from '@/components/themed-text';
import { ThemedView } from '@/components/themed-view';
import { Link } from 'expo-router';

export default function HomeScreen() {
  return (
    <ParallaxScrollView
      headerBackgroundColor={{ light: '#A5D6A7', dark: '#1B5E20' }}
      headerImage={
        <Image
          source={require('@/assets/images/partial-react-logo.png')}
          style={styles.reactLogo}
        />
      }>
      <ThemedView style={styles.titleContainer}>
        <ThemedText type="title">¡Bienvenido a Aprende Idiomas!</ThemedText>
        <HelloWave />
      </ThemedView>
      <ThemedView style={styles.stepContainer}>
        <ThemedText type="subtitle">Paso 1: Personaliza tu perfil</ThemedText>
        <ThemedText>
          Edita <ThemedText type="defaultSemiBold">app/(tabs)/index.tsx</ThemedText> para ver los cambios.
          Pulsa{' '}
          <ThemedText type="defaultSemiBold">
            {Platform.select({
              ios: 'cmd + d',
              android: 'cmd + m',
              web: 'F12',
            })}
          </ThemedText>{' '}
          para abrir las herramientas de desarrollador.
        </ThemedText>
      </ThemedView>
      <ThemedView style={styles.stepContainer}>
        <Link href="/modal">
          <Link.Trigger>
            <ThemedText type="subtitle">Paso 2: Explora lecciones</ThemedText>
          </Link.Trigger>
          <Link.Preview />
          <Link.Menu>
            <Link.MenuAction title="Guardar lección" icon="bookmark" onPress={() => alert('Lección guardada')} />
            <Link.MenuAction
              title="Compartir progreso"
              icon="square.and.arrow.up"
              onPress={() => alert('Progreso compartido')}
            />
            <Link.Menu title="Más opciones" icon="ellipsis">
              <Link.MenuAction
                title="Marcar como completada"
                icon="checkmark.circle"
                onPress={() => alert('Marcada como completada')}
              />
            </Link.Menu>
          </Link.Menu>
        </Link>

        <ThemedText>
          Toca la pestaña Explorar para descubrir más cursos y niveles MCER disponibles.
        </ThemedText>
      </ThemedView>
      <ThemedView style={styles.stepContainer}>
        <ThemedText type="subtitle">Paso 3: Empieza desde cero</ThemedText>
        <ThemedText>
          Cuando estés listo, ejecuta{' '}
          <ThemedText type="defaultSemiBold">npm run reset-project</ThemedText> para obtener un directorio{' '}
          <ThemedText type="defaultSemiBold">app</ThemedText> limpio. Esto moverá el directorio{' '}
          <ThemedText type="defaultSemiBold">app</ThemedText> actual a{' '}
          <ThemedText type="defaultSemiBold">app-example</ThemedText>.
        </ThemedText>
      </ThemedView>
    </ParallaxScrollView>
  );
}

const styles = StyleSheet.create({
  titleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  stepContainer: {
    gap: 8,
    marginBottom: 8,
  },
  reactLogo: {
    height: 178,
    width: 290,
    bottom: 0,
    left: 0,
    position: 'absolute',
  },
});
