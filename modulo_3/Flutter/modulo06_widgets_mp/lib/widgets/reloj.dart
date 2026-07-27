import 'dart:async';
import 'package:flutter/material.dart';

class Reloj extends StatefulWidget {
  const Reloj({super.key});

  @override
  State<Reloj> createState() => _RelojState();
}

class _RelojState extends State<Reloj> {
  Timer? _timer;
  int _segundos = 0;
  bool _pausado = false;
  final List<int> _sesiones = [];

  @override
  void initState() {
    super.initState();
    _iniciarTimer();
  }

  void _iniciarTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (!mounted) return;
      setState(() => _segundos++);
    });
  }

  void _togglePausa() {
    setState(() {
      _pausado = !_pausado;
      if (_pausado) {
        _timer?.cancel();
      } else {
        _iniciarTimer();
      }
    });
  }

  void _registrarSesion() {
    setState(() {
      _sesiones.add(_segundos);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatearTiempo(int totalSegundos) {
    final h = totalSegundos ~/ 3600;
    final m = (totalSegundos % 3600) ~/ 60;
    final s = totalSegundos % 60;
    return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  String get _formato => _formatearTiempo(_segundos);

  Color get _colorTiempo {
    if (_segundos > 3600) return Colors.deepPurple;
    if (_segundos > 1800) return Colors.red;
    if (_segundos > 900) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _formato,
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: _colorTiempo,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton.icon(
              onPressed: _togglePausa,
              icon: Icon(_pausado ? Icons.play_arrow : Icons.pause),
              label: Text(_pausado ? 'Reanudar estudio' : 'Pausar estudio'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _pausado ? null : _registrarSesion,
              icon: const Icon(Icons.bookmark),
              label: const Text('Guardar sesión'),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => setState(() {
                _timer?.cancel();
                _segundos = 0;
                _pausado = false;
                _sesiones.clear();
                _iniciarTimer();
              }),
              child: const Text('Reiniciar'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _pausado ? 'Estudio en pausa' : 'Estudiando...',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        if (_sesiones.isNotEmpty) ...[
          const SizedBox(height: 20),
          const Text(
            'Últimas sesiones guardadas:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            'Sesión ${_sesiones.length}: ${_formatearTiempo(_sesiones.last)}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 16),
          ),
        ],
      ],
    );
  }
}
