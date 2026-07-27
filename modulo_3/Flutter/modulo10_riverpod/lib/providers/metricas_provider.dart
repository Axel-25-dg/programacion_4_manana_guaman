// lib/providers/metricas_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/metrica_servidor.dart';

class MetricasNotifier extends AsyncNotifier<List<MetricaServidor>> {
  @override
  Future<List<MetricaServidor>> build() => _fetch();

  Future<List<MetricaServidor>> _fetch() async {
    // Simulación de latencia de red
    await Future.delayed(const Duration(milliseconds: 800));
    
    return const [
      MetricaServidor(servidor: 'prod-web-01', cpu: 45.2, ram: 62.1, ssd: 80.5, conexiones: 230),
      MetricaServidor(servidor: 'prod-db-01',  cpu: 88.1, ram: 91.2, ssd: 75.0, conexiones: 80),
      MetricaServidor(servidor: 'staging-api', cpu: 22.4, ram: 41.0, ssd: 60.0, conexiones: 50),
      MetricaServidor(servidor: 'dev-nest-api', cpu: 25.4, ram: 45.0, ssd: 65.0, conexiones: 90),
      MetricaServidor(servidor: 'dev-db-api',   cpu: 23.4, ram: 42.0, ssd: 65.0, conexiones: 85),
    ];
  }

  Future<void> recargar() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }
}

final metricasProvider =
    AsyncNotifierProvider<MetricasNotifier, List<MetricaServidor>>(
  MetricasNotifier.new,
);