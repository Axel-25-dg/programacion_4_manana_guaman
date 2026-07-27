// lib/screens/pantalla_navegacion.dart
import 'package:flutter/material.dart';

class PantallaNavegacion extends StatefulWidget {
  const PantallaNavegacion({super.key});

  @override
  State<PantallaNavegacion> createState() => _PantallaNavegacionState();
}

class _PantallaNavegacionState extends State<PantallaNavegacion> {
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Aprende Idiomas'),
        backgroundColor: cs.surfaceContainerHighest,
      ),
      body: IndexedStack(
        index: _indice,
        children: const [
          _PantallaInicio(),
          _PantallaCursos(),
          _PantallaNotificaciones(),
          _PantallaPerfil(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex:         _indice,
        onDestinationSelected: (i) => setState(() => _indice = i),
        indicatorColor:        cs.tertiaryContainer, 
        destinations: const [
          NavigationDestination(
            icon:         Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label:        'Inicio',
          ),
          NavigationDestination(
            icon:         Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label:        'Cursos',
          ),
          NavigationDestination(
            icon:         Badge(label: Text('3'), child: Icon(Icons.notifications_outlined)),
            selectedIcon: Badge(label: Text('3'), child: Icon(Icons.notifications)),
            label:        'Avisos',
          ),
          NavigationDestination(
            icon:         Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label:        'Perfil',
          ),
        ],
      ),
    );
  }
}

// ─── Pantallas de cada pestaña ────────────────────────────────────────────

class _PantallaInicio extends StatelessWidget {
  const _PantallaInicio();

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('¡Hola, sigue aprendiendo!', style: text.headlineSmall),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _TarjetaMetrica(titulo: 'Cursos activos', valor: '4',  icono: Icons.menu_book, color: cs.primaryContainer)),
          const SizedBox(width: 8),
          Expanded(child: _TarjetaMetrica(titulo: 'Lecciones hoy',    valor: '3',  icono: Icons.assignment, color: cs.errorContainer)),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: _TarjetaMetrica(titulo: 'Racha de días',   valor: '23', icono: Icons.local_fire_department, color: cs.tertiaryContainer)),
          const SizedBox(width: 8),
          Expanded(child: _TarjetaMetrica(titulo: 'Palabras totales', valor: '1,248', icono: Icons.translate,       color: cs.secondaryContainer)),
        ]),
      ],
    );
  }
}

class _TarjetaMetrica extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color    color;

  const _TarjetaMetrica({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icono, size: 28),
            const SizedBox(height: 8),
            Text(valor,  style: text.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            Text(titulo, style: text.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _PantallaCursos extends StatelessWidget {
  const _PantallaCursos();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final cursos = [
      (nombre: 'Inglés Intermedio B2', progreso: '68% completado'),
      (nombre: 'Francés Elemental A2',  progreso: '41% completado'),
      (nombre: 'Japonés Básico N5',    progreso: '58% completado'),
      (nombre: 'Alemán Principiante A1', progreso: '15% completado'),
      (nombre: 'Italiano Conversación', progreso: '75% completado'),
      (nombre: 'Portugués Brasilero',   progreso: '30% completado'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: cursos.length,
      itemBuilder: (ctx, i) => Card(
        child: ListTile(
          leading:  Icon(Icons.language, color: cs.primary),
          title:    Text(cursos[i].nombre),
          subtitle: Text(cursos[i].progreso),
          trailing: Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Abriendo ${cursos[i].nombre}')),
            );
          },
        ),
      ),
    );
  }
}

class _PantallaNotificaciones extends StatelessWidget {
  const _PantallaNotificaciones();

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    const avisos = [
      (curso: 'Inglés B2',  mensaje: 'Tienes 5 palabras para repasar', nivel: 'HOY'),
      (curso: 'Japonés N5', mensaje: 'Examen de kanjis disponible',    nivel: 'RECORDATORIO'),
      (curso: 'Francés A2', mensaje: '¡Racha de 7 días! No la rompas',  nivel: 'LOGRO'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: avisos.length,
      itemBuilder: (ctx, i) {
        final aviso = avisos[i];
        final esImportante = aviso.nivel == 'HOY';

        return Card(
          color: esImportante ? cs.errorContainer : cs.tertiaryContainer,
          child: ListTile(
            leading: Icon(
              esImportante ? Icons.error : Icons.campaign,
              color: esImportante ? cs.onErrorContainer : cs.onTertiaryContainer,
            ),
            title: Text(aviso.curso,
                style: text.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Text(aviso.mensaje),
            trailing: Chip(
              label: Text(aviso.nivel, style: const TextStyle(fontSize: 11)),
              backgroundColor: esImportante ? cs.error : cs.tertiary,
              labelStyle: TextStyle(
                color: esImportante ? cs.onError : cs.onTertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Notificación: ${aviso.curso} - ${aviso.mensaje}'),
                  backgroundColor: esImportante ? cs.error : cs.tertiary,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _PantallaPerfil extends StatelessWidget {
  const _PantallaPerfil();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.translate_outlined),
          title:   Text('Mis idiomas'),
          trailing: Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: Icon(Icons.workspace_premium_outlined),
          title:   Text('Certificados'),
          trailing: Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title:   Text('Estadísticas de estudio'),
          trailing: Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: Icon(Icons.settings_outlined),
          title:   Text('Configuración'),
          trailing: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
