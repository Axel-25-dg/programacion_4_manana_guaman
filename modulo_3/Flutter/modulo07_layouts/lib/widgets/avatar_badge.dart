import 'package:flutter/material.dart';

class AvatarBadge extends StatelessWidget {
  final String nombre;
  final int    alertas;
  final bool   activo;

  const AvatarBadge({
    super.key,
    required this.nombre,
    required this.alertas,
    required this.activo,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,   
      children: [
        Container(
          width:  56,
          height: 56,
          decoration: BoxDecoration(
            color:        activo ? Colors.indigo.shade100 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              nombre.substring(0, 2).toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:   18,
                color:      activo ? Colors.indigo : Colors.grey,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0, right: 0,
          child: Container(
            width:  14,
            height: 14,
            decoration: BoxDecoration(
              color:  activo ? Colors.green : Colors.red,
              shape:  BoxShape.rectangle, 
              border: Border.all(color: Colors.white, width: 4), 
            ),
          ),
        ),

        if (alertas > 0)
          Positioned(
            top: 0, right: 0, 
            child: Container(
              padding:     const EdgeInsets.all(4),
              decoration:  const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                alertas > 9 ? '9+' : '$alertas',
                style: const TextStyle(
                    color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
