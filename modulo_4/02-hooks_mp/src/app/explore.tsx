import { Image } from 'expo-image';
import { SymbolView } from 'expo-symbols';
import { Platform, Pressable, ScrollView, StyleSheet } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import { ExternalLink } from '@/components/external-link';
import { ThemedText } from '@/components/themed-text';
import { ThemedView } from '@/components/themed-view';
import { Collapsible } from '@/components/ui/collapsible';
import { WebBadge } from '@/components/web-badge';
import { BottomTabInset, MaxContentWidth, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

export default function TabTwoScreen() {
  const safeAreaInsets = useSafeAreaInsets();
  const insets = {
    ...safeAreaInsets,
    bottom: safeAreaInsets.bottom + BottomTabInset + Spacing.three,
  };
  const theme = useTheme();

  const contentPlatformStyle = Platform.select({
    android: {
      paddingTop: insets.top,
      paddingLeft: insets.left,
      paddingRight: insets.right,
      paddingBottom: insets.bottom,
    },
    web: {
      paddingTop: Spacing.six,
      paddingBottom: Spacing.four,
    },
  });

  return (
    <ScrollView
      style={[styles.scrollView, { backgroundColor: theme.background }]}
      contentInset={insets}
      contentContainerStyle={[styles.contentContainer, contentPlatformStyle]}>
      <ThemedView style={styles.container}>
        <ThemedView style={styles.titleContainer}>
          <ThemedText type="subtitle">Explorar Cursos</ThemedText>
          <ThemedText style={styles.centerText} themeColor="textSecondary">
            Descubre cursos de idiomas, niveles MCER y material de estudio.
          </ThemedText>

          <ExternalLink href="https://www.coe.int/es/web/common-european-framework-reference-languages" asChild>
            <Pressable style={({ pressed }) => pressed && styles.pressed}>
              <ThemedView type="backgroundElement" style={styles.linkButton}>
                <ThemedText type="link">Ver niveles MCER</ThemedText>
                <SymbolView
                  tintColor={theme.text}
                  name={{ ios: 'arrow.up.right.square', android: 'link', web: 'link' }}
                  size={12}
                />
              </ThemedView>
            </Pressable>
          </ExternalLink>
        </ThemedView>

        <ThemedView style={styles.sectionsWrapper}>
          <Collapsible title="Rutas basadas en archivos">
            <ThemedText type="small">
              Esta app tiene dos pantallas: <ThemedText type="code">src/app/index.tsx</ThemedText> y{' '}
              <ThemedText type="code">src/app/explore.tsx</ThemedText>
            </ThemedText>
            <ThemedText type="small">
              El archivo de layout en <ThemedText type="code">src/app/_layout.tsx</ThemedText> configura
              el navegador de pestañas para Mis Cursos y Explorar.
            </ThemedText>
            <ExternalLink href="https://docs.expo.dev/router/introduction">
              <ThemedText type="linkPrimary">Saber más</ThemedText>
            </ExternalLink>
          </Collapsible>

          <Collapsible title="Soporte Android, iOS y web">
            <ThemedView type="backgroundElement" style={styles.collapsibleContent}>
              <ThemedText type="small">
                Puedes abrir este proyecto en Android, iOS y web. Para abrir la versión web,
                pulsa <ThemedText type="smallBold">w</ThemedText> en la terminal que ejecuta este
                proyecto.
              </ThemedText>
              <Image
                source={require('@/assets/images/tutorial-web.png')}
                style={styles.imageTutorial}
              />
            </ThemedView>
          </Collapsible>

          <Collapsible title="Imágenes de vocabulario">
            <ThemedText type="small">
              Para imágenes estáticas, puedes usar los sufijos <ThemedText type="code">@2x</ThemedText> y{' '}
              <ThemedText type="code">@3x</ThemedText> para proporcionar archivos para diferentes
              densidades de pantalla.
            </ThemedText>
            <Image source={require('@/assets/images/react-logo.png')} style={styles.imageReact} />
            <ExternalLink href="https://reactnative.dev/docs/images">
              <ThemedText type="linkPrimary">Saber más</ThemedText>
            </ExternalLink>
          </Collapsible>

          <Collapsible title="Componentes claro y oscuro">
            <ThemedText type="small">
              Esta plantilla soporta modo claro y oscuro. El hook{' '}
              <ThemedText type="code">useColorScheme()</ThemedText> te permite inspeccionar
              el esquema de color actual del usuario y ajustar los colores de la UI.
            </ThemedText>
            <ExternalLink href="https://docs.expo.dev/develop/user-interface/color-themes/">
              <ThemedText type="linkPrimary">Saber más</ThemedText>
            </ExternalLink>
          </Collapsible>

          <Collapsible title="Animaciones de lecciones">
            <ThemedText type="small">
              Esta plantilla incluye un ejemplo de componente animado. El componente{' '}
              <ThemedText type="code">src/components/ui/collapsible.tsx</ThemedText> usa
              la potente librería <ThemedText type="code">react-native-reanimated</ThemedText> para
              animar la apertura de las tarjetas de vocabulario.
            </ThemedText>
          </Collapsible>
        </ThemedView>
        {Platform.OS === 'web' && <WebBadge />}
      </ThemedView>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  scrollView: {
    flex: 1,
  },
  contentContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
  },
  container: {
    maxWidth: MaxContentWidth,
    flexGrow: 1,
  },
  titleContainer: {
    gap: Spacing.three,
    alignItems: 'center',
    paddingHorizontal: Spacing.four,
    paddingVertical: Spacing.six,
  },
  centerText: {
    textAlign: 'center',
  },
  pressed: {
    opacity: 0.7,
  },
  linkButton: {
    flexDirection: 'row',
    paddingHorizontal: Spacing.four,
    paddingVertical: Spacing.two,
    borderRadius: Spacing.five,
    justifyContent: 'center',
    gap: Spacing.one,
    alignItems: 'center',
  },
  sectionsWrapper: {
    gap: Spacing.five,
    paddingHorizontal: Spacing.four,
    paddingTop: Spacing.three,
  },
  collapsibleContent: {
    alignItems: 'center',
  },
  imageTutorial: {
    width: '100%',
    aspectRatio: 296 / 171,
    borderRadius: Spacing.three,
    marginTop: Spacing.two,
  },
  imageReact: {
    width: 100,
    height: 100,
    alignSelf: 'center',
  },
});
