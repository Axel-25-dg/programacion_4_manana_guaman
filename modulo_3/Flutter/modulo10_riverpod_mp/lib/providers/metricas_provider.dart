import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/metrica_servidor.dart';

class MetricasNotifier extends AsyncNotifier<List<MetricaServidor>> {
  @override
  Future<List<MetricaServidor>> build() => _fetch();

  Future<List<MetricaServidor>> _fetch() async {
    await Future.delayed(const Duration(milliseconds: 900));
    
    return const [
      MetricaServidor(servidor: 'Inglés Conversacional', vocabulario: 72.3, gramatica: 58.1, pronunciacion: 81.5, xp: 1240),
      MetricaServidor(servidor: 'Gramática Francesa',    vocabulario: 41.2, gramatica: 90.4, pronunciacion: 55.0, xp: 680),
      MetricaServidor(servidor: 'Kanjis N5-N4',          vocabulario: 88.7, gramatica: 35.0, pronunciacion: 42.0, xp: 2100),
      MetricaServidor(servidor: 'Alemán para viajar',    vocabulario: 55.1, gramatica: 38.7, pronunciacion: 70.0, xp: 320),
      MetricaServidor(servidor: 'Italiano Básico',       vocabulario: 62.0, gramatica: 55.0, pronunciacion: 48.5, xp: 510),
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
