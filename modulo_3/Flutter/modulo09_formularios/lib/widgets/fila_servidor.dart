// lib/widgets/fila_servidor.dart
import 'package:flutter/material.dart';
import '../models/servidor_ssh.dart';

class FilaServidor extends StatelessWidget {
  final ServidorSSH  servidor;
  final VoidCallback onFavorito;
  final VoidCallback onEliminar;

  const FilaServidor({
    super.key,
    required this.servidor,
    required this.onFavorito,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      // leading — icono con color según SSL
      leading: CircleAvatar(
        backgroundColor: servidor.ssl
            ? cs.primaryContainer
            : cs.surfaceContainerHighest,
        child: Icon(
          Icons.dns,
          color: servidor.ssl ? cs.onPrimaryContainer : cs.onSurfaceVariant,
        ),
      ),
      title: Text(
        servidor.nombre,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      // Se agrupan el host y el servicio usando una Column
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${servidor.usuario}@${servidor.ip}:${servidor.puerto}',
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 2), // Un pequeño espacio de separación
          // CAMPO SERVICIO (Muestra dinámicamente ssh, mongo, etc.)
          Text(
            'Servicio: ${servidor.servicio}', 
            style: TextStyle(
              fontSize: 11, 
              fontWeight: FontWeight.w500,
              color: cs.primary, // Color destacado usando el esquema del tema
            ),
          ),
        ],
      ),
      // trailing — dos acciones compactas (Favorito y Eliminar)
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              servidor.favorito ? Icons.star : Icons.star_border,
              color: servidor.favorito ? Colors.amber : cs.outline,
            ),
            onPressed:     onFavorito,
            visualDensity: VisualDensity.compact,
            tooltip:       servidor.favorito ? 'Quitar favorito' : 'Agregar a favoritos',
          ),
          IconButton(
            icon:          Icon(Icons.delete_outline, color: cs.error),
            onPressed:     onEliminar,
            visualDensity: VisualDensity.compact,
            tooltip:       'Eliminar',
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding vertical ajustado para la columna
    );
  }
}