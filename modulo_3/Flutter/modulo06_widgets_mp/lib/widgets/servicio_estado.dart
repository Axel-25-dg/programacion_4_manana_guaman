import 'package:flutter/material.dart';

class ServicioEstado extends StatefulWidget {
  final String nombre;
  const ServicioEstado({super.key, required this.nombre});

  @override
  State<ServicioEstado> createState() => _ServicioEstadoState();
}

class _ServicioEstadoState extends State<ServicioEstado> {
  bool _activo = true;
  int _repasos = 0;
  String _nivel = 'principiante';

  static const int _maxRepasos = 5;

  void _toggle() {
    setState(() {
      _activo = !_activo;
      if (_activo) {
        _repasos++;
        if (_repasos == 2) {
          _nivel = 'intermedio';
        } else if (_repasos >= 4) {
          _nivel = 'avanzado';
        }
      }
    });
  }

  void _restablecer() {
    setState(() {
      _activo = true;
      _repasos = 0;
      _nivel = 'principiante';
    });
  }

  Color _obtenerColorIcono() {
    if (!_activo) return Colors.red;
    switch (_nivel) {
      case 'intermedio':
        return Colors.orange;
      case 'avanzado':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final enLimite = _repasos >= _maxRepasos;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _activo ? Icons.menu_book : Icons.book_outlined,
            size: 72,
            color: _obtenerColorIcono(),
          ),
          const SizedBox(height: 8),
          Text(
            widget.nombre,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            _activo ? 'En progreso' : 'Pausado',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _activo ? Colors.green.shade700 : Colors.red.shade700,
              fontStyle: _activo ? FontStyle.normal : FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          if (!_activo)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.pause_circle, color: Colors.red, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Continúa tu aprendizaje',
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ],
              ),
            ),
          ElevatedButton.icon(
            onPressed: enLimite ? null : _toggle,
            icon: Icon(_activo ? Icons.pause : Icons.play_arrow),
            label: Text(_activo ? 'Pausar estudio' : 'Continuar estudio'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _activo ? Colors.red.shade600 : Colors.green.shade600,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 12),
          Opacity(
            opacity: enLimite ? 0.1 : 1.0,
            child: Text(
              'Sesiones de repaso: $_repasos / $_maxRepasos',
              style: TextStyle(
                fontSize: 13,
                color: enLimite ? Colors.red : Colors.grey.shade600,
              ),
            ),
          ),
          if (enLimite)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '¡Nivel máximo alcanzado hoy!',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: _restablecer,
            child: const Text('Reiniciar progreso'),
          ),
        ],
      ),
    );
  }
}
