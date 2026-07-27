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
        Text('Módulo actual: $nombre ($detalle)'),
        
        const SizedBox(height: 32),          
        const Text('Siguiente lección (después del espaciado fijo)'),

        const Divider(height: 32),

        const Text('Padding', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          color: Colors.indigo.shade50,
          child: const Padding(
            padding: EdgeInsets.only(left: 24),    
            child:   Text('Vocabulario: Saludos y presentaciones'),
          ),
        ),

        const Divider(height: 32),
        const Text('Align', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.record_voice_over, color: Colors.indigo),
        ),

        const Divider(height: 32),
        const Text('Wrap (Banderas de países / idiomas disponibles)', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  _idioma(i), 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  String _idioma(int i) {
    const idiomas = ['EN','FR','DE','IT','PT','ES','JA','ZH','KO','RU','AR','HE','NL','SV','NO','DA','PL','TR'];
    return idiomas[i % idiomas.length];
  }
}
