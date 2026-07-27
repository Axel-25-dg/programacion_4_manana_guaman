// lib/widgets/tarjeta_servidor_grid.dart
import 'package:flutter/material.dart';
import '../models/servidor_ssh.dart';

class TarjetaServidorGrid extends StatelessWidget {
  final ServidorSSH  servidor;
  final VoidCallback onFavorito;
  final VoidCallback onEliminar;

  const TarjetaServidorGrid({
    super.key,
    required this.servidor,
    required this.onFavorito,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(
                Icons.language,
                color: servidor.certificado ? cs.primary : cs.outline,
                size: 18,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onFavorito,
                child: Icon(
                  servidor.favorito ? Icons.star : Icons.star_border,
                  color: servidor.favorito ? Colors.amber : cs.outline,
                  size: 18,
                ),
              ),
            ]),
            const SizedBox(height: 6),

            Text(
              servidor.nombre,
              style: text.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${servidor.idioma} · ${servidor.nivel}',
              style: text.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),

            const Spacer(),

            Row(children: [
              if (servidor.certificado)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(Icons.workspace_premium, size: 12, color: cs.primary),
                ),
              Expanded(
                child: Text(
                  '${servidor.duracionHoras}h · ${servidor.modalidad}',
                  style: text.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onEliminar,
                child: Icon(Icons.delete_outline, size: 16, color: cs.error),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
