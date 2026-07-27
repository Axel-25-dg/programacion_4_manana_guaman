import 'package:flutter/material.dart';

class ContadorLimitado extends StatefulWidget {
  final String etiqueta;
  final int limite;
  final Color color;
  final VoidCallback? onLimite;
  final String textoBoton;
  final int pasoIncremento;

  const ContadorLimitado({
    super.key,
    required this.etiqueta,
    this.limite = 10,
    this.color = Colors.indigo,
    this.onLimite,
    this.textoBoton = 'Sumar',
    this.pasoIncremento = 1,
  });

  @override
  State<ContadorLimitado> createState() => _ContadorLimitadoState();
}

class _ContadorLimitadoState extends State<ContadorLimitado> {
  int _valor = 0;

  void _incrementar() {
    if (_valor >= widget.limite) return;
    setState(() {
      _valor += widget.pasoIncremento;
      if (_valor > widget.limite) _valor = widget.limite;
    });
    if (_valor == widget.limite) {
      widget.onLimite?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final enLimite = _valor >= widget.limite;
    final progreso = _valor / widget.limite;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.etiqueta,
          style: TextStyle(color: widget.color, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progreso,
          color: enLimite ? Colors.red : widget.color,
          backgroundColor: widget.color.withOpacity(0.15),
        ),
        const SizedBox(height: 4),
        Text(
          '$_valor / ${widget.limite}',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: enLimite ? Colors.red : widget.color,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: enLimite ? null : _incrementar,
              style: FilledButton.styleFrom(backgroundColor: widget.color),
              child: Text(widget.textoBoton),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => setState(() => _valor = 0),
              child: const Text('Reset'),
            ),
          ],
        ),
        if (enLimite)
          Text(
            'Límite alcanzado',
            style: TextStyle(fontSize: 12, color: Colors.red.shade700),
          ),
      ],
    );
  }
}