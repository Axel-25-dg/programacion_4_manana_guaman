import 'package:flutter/material.dart';

class CatalogoBasicos extends StatelessWidget {
  const CatalogoBasicos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets Básicos de Aprendizaje'),
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Curso de Inglés: En progreso',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              letterSpacing: 0.5,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              shadows: const [
                Shadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          const SizedBox(
            width: double.infinity,
            child: Text(
              'Lección de vocabulario avanzado — tema: viajes y turismo internacional con expresiones coloquiales',
              textAlign: TextAlign.justify,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(children: [
              TextSpan(text: 'Nivel: ', style: TextStyle(fontWeight: FontWeight.w600)),
              TextSpan(
                text: 'INTERMEDIO ALTO B2',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              TextSpan(text: ' — última lección completada hace 2 días', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ),
          const SizedBox(height: 8),
          const SelectableText(
            'hello@language-app.com',
            style: TextStyle(fontFamily: 'monospace', fontSize: 14),
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tooltip(
                message: 'Lección completada',
                child: Icon(
                  Icons.check_circle_outline,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Icon(Icons.cancel, size: 14, color: Colors.red),
              const Icon(Icons.warning_amber, size: 40, color: Colors.orange),
              const Icon(Icons.translate, size: 40, color: Colors.indigo),
              const Icon(Icons.volume_off, size: 40, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          const Icon(
            Icons.settings,
            size: 24,
            color: Colors.blueGrey,
            semanticLabel: 'Configuración del curso',
          ),
          const Divider(height: 32),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Siguiente lección')),
              FilledButton(onPressed: () {}, child: const Text('Empezar quiz')),
              OutlinedButton(onPressed: () {}, child: const Text('Repasar vocabulario')),
              TextButton(onPressed: () {}, child: const Text('Ver material')),
              ElevatedButton(onPressed: () {}, child: const Text('Guardar progreso')),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Reiniciar lección'),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.stop, size: 18),
                label: const Text('Finalizar sesión'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.info, size: 18),
                label: const Text('Instrucciones'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.history, size: 18),
                label: const Text('Historial de estudio'),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.volume_up),
                color: Colors.indigo,
                iconSize: 28,
                tooltip: 'Escuchar pronunciación',
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: const StadiumBorder(),
              elevation: 12,
            ),
            child: const Text(
              'Borrar progreso',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 32),
          Card(
            elevation: 12,
            color: Colors.blue.shade50,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              isThreeLine: true,
              leading: const Icon(Icons.translate, color: Colors.indigo, size: 28),
              title: const Text('Vocabulario: Verbos irregulares'),
              subtitle: const Text(
                'Nivel: Intermedio B1 · 24 palabras\nEstado: Estudiando con flashcards de repaso espaciado.',
              ),
              trailing: const Icon(Icons.circle, color: Colors.green, size: 12),
              onTap: () {},
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.red.shade50,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.red.shade200, width: 1),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red.shade100,
                child: const Icon(Icons.cancel, color: Colors.red, size: 20),
              ),
              title: const Text('Examen de gramática'),
              subtitle: const Text('Sin intentos disponibles · 3 fallos'),
              trailing: TextButton(
                onPressed: () {},
                child: const Text('Revisar'),
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: SwitchListTile(
              value: false,
              onChanged: (bool nuevoValor) {},
              title: const Text('Modo sin conexión'),
              subtitle: const Text('Descarga todas las lecciones para estudiar offline'),
              secondary: const Icon(Icons.offline_bolt, color: Colors.blueGrey),
            ),
          ),
          const Divider(height: 32),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                label: const Text('Inglés'),
                padding: const EdgeInsets.all(8),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () {},
              ),
              Chip(
                label: const Text('Francés'),
                padding: const EdgeInsets.all(8),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () {},
              ),
              const Chip(
                avatar: Icon(Icons.check, size: 16, color: Colors.white),
                label: Text('Alemán'),
                backgroundColor: Colors.blue,
                labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              ),
              FilterChip(
                label: const Text('Japonés'),
                selected: false,
                onSelected: (bool valor) {},
              ),
              const Chip(
                avatar: Icon(Icons.check, size: 16, color: Colors.white),
                label: Text('Vocabulario'),
                backgroundColor: Colors.blue,
                labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              ),
              FilterChip(
                label: const Text('Gramática'),
                selected: false,
                onSelected: (bool valor) {},
              ),
              ActionChip(
                label: const Text('Ver progreso'),
                avatar: const Icon(Icons.bar_chart, size: 16),
                onPressed: () {},
              ),
              InputChip(
                avatar: const Icon(Icons.record_voice_over, size: 16),
                label: const Text('pronunciación-EN'),
                selected: true,
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () {},
                onSelected: (bool valor) {},
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  value: 0.7,
                  color: Colors.green,
                  strokeWidth: 6,
                ),
              ),
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  value: 0.3,
                  color: Colors.red,
                  strokeWidth: 3,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
            value: 0.6,
            color: Colors.indigo,
          ),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
            value: 1.0,
            color: Colors.green,
            minHeight: 6,
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }
}
