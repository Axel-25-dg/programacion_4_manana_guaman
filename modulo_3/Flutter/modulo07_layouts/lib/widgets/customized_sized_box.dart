import 'package:flutter/material.dart';

class CustomizedSizedBox extends StatelessWidget {
  final String nombre;
  final String detalle;
  final bool   activo;

  const CustomizedSizedBox({
    super.key,
    required this.nombre,
    required this.detalle,
    required this.activo,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('SizedBox', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Primer elemento: $nombre ($detalle)'),
        
        const SizedBox(height: 32),          
        const Text('Segundo elemento (después del espaciado fijo)'),

        const Divider(height: 32),

        const Text('Padding', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          color: Colors.indigo.shade50,
          child: const Padding(
            padding: EdgeInsets.only(left: 24),    
            child:   Text('Texto con Padding izquierdo'),
          ),
        ),

        const Divider(height: 32),
        const Text('Align', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.settings, color: Colors.indigo),
        ),

        const Divider(height: 32),
        const Text('Wrap (Paleta de Colores Dinámica)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing:   24,
          runSpacing: 8,
          direction: Axis.vertical,   
          children: List.generate(18, (i) {
            return Container(
              width: 40, 
              height: 40, 
              color: Colors.primaries[i % 18],
              child: Center(
                child: Text(
                  '$i', 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}