import { Image } from 'expo-image';
import { Platform, StyleSheet } from 'react-native';

import { Collapsible } from '@/components/ui/collapsible';
import { ExternalLink } from '@/components/external-link';
import ParallaxScrollView from '@/components/parallax-scroll-view';
import { ThemedText } from '@/components/themed-text';
import { ThemedView } from '@/components/themed-view';
import { IconSymbol } from '@/components/ui/icon-symbol';
import { Fonts } from '@/constants/theme';

export default function TabTwoScreen() {
  return (
    <ParallaxScrollView
      headerBackgroundColor={{ light: '#C8E6C9', dark: '#2E7D32' }}
      headerImage={
        <IconSymbol
          size={310}
          color="#66BB6A"
          name="chevron.left.forwardslash.chevron.right"
          style={styles.headerImage}
        />
      }>
      <ThemedView style={styles.titleContainer}>
        <ThemedText
          type="title"
          style={{
            fontFamily: Fonts.rounded,
          }}>
          Explorar Cursos
        </ThemedText>
      </ThemedView>
      <ThemedText>Descubre cursos de idiomas, niveles MCER y material de estudio.</ThemedText>
      <Collapsible title="Rutas basadas en archivos">
        <ThemedText>
          Esta app tiene dos pantallas:{' '}
          <ThemedText type="defaultSemiBold">app/(tabs)/index.tsx</ThemedText> y{' '}
          <ThemedText type="defaultSemiBold">app/(tabs)/explore.tsx</ThemedText>
        </ThemedText>
        <ThemedText>
          El archivo de layout en <ThemedText type="defaultSemiBold">app/(tabs)/_layout.tsx</ThemedText>{' '}
          configura el navegador de pestañas para Mis Cursos y Explorar.
        </ThemedText>
        <ExternalLink href="https://docs.expo.dev/router/introduction">
          <ThemedText type="link">Saber más</ThemedText>
        </ExternalLink>
      </Collapsible>
      <Collapsible title="Soporte Android, iOS y web">
        <ThemedText>
          Puedes abrir este proyecto en Android, iOS y web. Para abrir la versión web, pulsa{' '}
          <ThemedText type="defaultSemiBold">w</ThemedText> en la terminal que ejecuta este proyecto.
        </ThemedText>
      </Collapsible>
      <Collapsible title="Tarjetas de vocabulario">
        <ThemedText>
          Para imágenes estáticas de vocabulario, puedes usar los sufijos{' '}
          <ThemedText type="defaultSemiBold">@2x</ThemedText> y{' '}
          <ThemedText type="defaultSemiBold">@3x</ThemedText> para proporcionar archivos para
          diferentes densidades de pantalla.
        </ThemedText>
        <Image
          source={require('@/assets/images/react-logo.png')}
          style={{ width: 100, height: 100, alignSelf: 'center' }}
        />
        <ExternalLink href="https://reactnative.dev/docs/images">
          <ThemedText type="link">Saber más</ThemedText>
        </ExternalLink>
      </Collapsible>
      <Collapsible title="Componentes claro y oscuro">
        <ThemedText>
          Esta plantilla soporta modo claro y oscuro. El{' '}
          <ThemedText type="defaultSemiBold">useColorScheme()</ThemedText> hook te permite inspeccionar
          el esquema de color actual del estudiante y ajustar los colores de la UI según corresponda.
        </ThemedText>
        <ExternalLink href="https://docs.expo.dev/develop/user-interface/color-themes/">
          <ThemedText type="link">Saber más</ThemedText>
        </ExternalLink>
      </Collapsible>
      <Collapsible title="Animaciones de lecciones">
        <ThemedText>
          Esta plantilla incluye un ejemplo de componente animado. El componente{' '}
          <ThemedText type="defaultSemiBold">components/HelloWave.tsx</ThemedText> usa
          la potente{' '}
          <ThemedText type="defaultSemiBold" style={{ fontFamily: Fonts.mono }}>
            react-native-reanimated
          </ThemedText>{' '}
          librería para crear animaciones de bienvenida al estudiante.
        </ThemedText>
        {Platform.select({
          ios: (
            <ThemedText>
              El componente <ThemedText type="defaultSemiBold">components/ParallaxScrollView.tsx</ThemedText>{' '}
              proporciona un efecto parallax para la imagen de cabecera de cada curso.
            </ThemedText>
          ),
        })}
      </Collapsible>
    </ParallaxScrollView>
  );
}

const styles = StyleSheet.create({
  headerImage: {
    color: '#66BB6A',
    bottom: -90,
    left: -35,
    position: 'absolute',
  },
  titleContainer: {
    flexDirection: 'row',
    gap: 8,
  },
});
