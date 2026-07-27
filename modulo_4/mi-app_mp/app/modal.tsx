import { Link } from 'expo-router';
import { StyleSheet } from 'react-native';

import { ThemedText } from '@/components/themed-text';
import { ThemedView } from '@/components/themed-view';

export default function ModalScreen() {
  return (
    <ThemedView style={styles.container}>
      <ThemedText type="title">Detalle de la Lección</ThemedText>
      <ThemedText style={{ marginTop: 10, textAlign: 'center' }}>
        Contenido de la lección, vocabulario y ejercicios interactivos.
      </ThemedText>
      <Link href="/" dismissTo style={styles.link}>
        <ThemedText type="link">Volver a Mis Cursos</ThemedText>
      </Link>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  link: {
    marginTop: 15,
    paddingVertical: 15,
  },
});
