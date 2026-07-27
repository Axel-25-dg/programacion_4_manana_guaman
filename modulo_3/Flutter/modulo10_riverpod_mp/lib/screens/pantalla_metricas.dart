import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/metrica_servidor.dart';
import '../providers/metricas_provider.dart';

class PantallaMetricas extends ConsumerWidget {
  const PantallaMetricas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricasAsync = ref.watch(metricasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progreso de aprendizaje'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        actions: [
          IconButton(
            icon:    const Icon(Icons.refresh),
            tooltip: 'Actualizar progreso',
            onPressed: () =>
                ref.read(metricasProvider.notifier).recargar(),
          ),
        ],
      ),
      body: metricasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 8),
              Text('Error al cargar el progreso: $e'),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () =>
                    ref.read(metricasProvider.notifier).recargar(),
                icon:  const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (metricas) => ListView.builder(
          padding:     const EdgeInsets.all(12),
          itemCount:   metricas.length,
          itemBuilder: (_, i) => _TarjetaMetrica(metrica: metricas[i]),
        ),
      ),
    );
  }
}

class _TarjetaMetrica extends StatelessWidget {
  final MetricaServidor metrica;
  const _TarjetaMetrica({required this.metrica});

  @override
  Widget build(BuildContext context) {
    final cs             = Theme.of(context).colorScheme;
    final vocabularioBajo = metrica.vocabulario < 50;
    final gramaticaBaja   = metrica.gramatica < 50;
    final necesitaRefuerzo = vocabularioBajo || gramaticaBaja;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color:  necesitaRefuerzo ? cs.errorContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.menu_book,
                  color: necesitaRefuerzo ? cs.error : cs.primary, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(metrica.servidor,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.emoji_events, size: 14, color: cs.primary),
                  const SizedBox(width: 4),
                  Text('${metrica.xp} XP',
                      style: TextStyle(
                          fontSize: 12,
                          color: necesitaRefuerzo ? cs.onErrorContainer : cs.onSurfaceVariant,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ]),
            const SizedBox(height: 10),
            _Barra('Vocabulario', metrica.vocabulario, vocabularioBajo, Icons.translate),
            const SizedBox(height: 4),
            _Barra('Gramática',    metrica.gramatica,   gramaticaBaja,   Icons.rule),
            const SizedBox(height: 4),
            _Barra('Pronunciación',metrica.pronunciacion,false,           Icons.record_voice_over),
          ],
        ),
      ),
    );
  }
}

class _Barra extends StatelessWidget {
  final String label;
  final double valor;
  final bool   baja;
  final IconData icono;
  const _Barra(this.label, this.valor, this.baja, this.icono);

  @override
  Widget build(BuildContext context) {
    final color = baja ? Colors.orange : Colors.green;
    return Row(children: [
      Icon(icono, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
      const SizedBox(width: 6),
      SizedBox(width: 84, child: Text(label,
          style: const TextStyle(fontSize: 12))),
      Expanded(
        child: LinearProgressIndicator(
          value:           valor / 100,
          backgroundColor: Colors.grey.shade200,
          valueColor:      AlwaysStoppedAnimation(color),
        ),
      ),
      const SizedBox(width: 8),
      Text('${valor.toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 12, color: color,
              fontWeight: FontWeight.w600)),
    ]);
  }
}
