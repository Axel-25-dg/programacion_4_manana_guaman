import 'package:flutter/material.dart';
import '../models/servidor_ssh.dart';
import '../widgets/fila_servidor.dart';
import '../widgets/tarjeta_servidor_grid.dart';

class PantallaBusqueda extends StatefulWidget {
  const PantallaBusqueda({super.key});
  @override
  State<PantallaBusqueda> createState() => _PantallaBusquedaState();
}

class _PantallaBusquedaState extends State<PantallaBusqueda> {
  final _servidores = [
    ServidorSSH(id:'1', nombre:'Inglés Conversacional',  idioma:'Inglés',   nivel:'B2', duracionHoras:60, modalidad:'Online',     certificado:true,  favorito:true,  categoria:'conversación'),
    ServidorSSH(id:'2', nombre:'Gramática Francesa',     idioma:'Francés',  nivel:'A2', duracionHoras:40, modalidad:'Presencial', certificado:true,  categoria:'gramática'),
    ServidorSSH(id:'3', nombre:'Kanjis N5-N4',           idioma:'Japonés',  nivel:'N5', duracionHoras:80, modalidad:'Online',     certificado:false, categoria:'vocabulario'),
    ServidorSSH(id:'4', nombre:'Alemán para viajar',     idioma:'Alemán',   nivel:'A1', duracionHoras:20, modalidad:'Híbrido',    certificado:false, categoria:'frases útiles'),
    ServidorSSH(id:'5', nombre:'Italiano Básico',        idioma:'Italiano', nivel:'A1', duracionHoras:30, modalidad:'Autodidacta',certificado:true,  favorito:true,  categoria:'conversación'),
    ServidorSSH(id:'6', nombre:'Chino Mandarín HSK1',    idioma:'Chino',    nivel:'A1', duracionHoras:50, modalidad:'Online',     certificado:true,  categoria:'vocabulario'),
    ServidorSSH(id:'7', nombre:'Coreano para K-dramas',  idioma:'Coreano',  nivel:'A2', duracionHoras:35, modalidad:'Online',     certificado:false, categoria:'frases útiles'),
    ServidorSSH(id:'8', nombre:'Portugués Brasilero',    idioma:'Portugués',nivel:'B1', duracionHoras:45, modalidad:'Presencial', certificado:true,  categoria:'conversación'),
  ];

  String _busqueda = '';
  bool   _modoGrid = false;

  List<ServidorSSH> get _filtrados => _servidores
      .where((s) =>
          s.nombre.toLowerCase().contains(_busqueda.toLowerCase()) ||
          s.idioma.toLowerCase().contains(_busqueda.toLowerCase()) ||
          s.categoria.toLowerCase().contains(_busqueda.toLowerCase()) ||
          s.nivel.toLowerCase().contains(_busqueda.toLowerCase()))
      .toList();

  void _toggleFavorito(ServidorSSH s) =>
      setState(() => s.favorito = !s.favorito);

  void _eliminar(ServidorSSH s) =>
      setState(() => _servidores.removeWhere((x) => x.id == s.id));

  @override
  Widget build(BuildContext context) {
    final cs       = Theme.of(context).colorScheme;
    final filtrados = _filtrados;

    return Scaffold(
      appBar: AppBar(
        title:           Text('Buscar cursos (${_servidores.length})'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        actions: [
          IconButton(
            icon:      Icon(_modoGrid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _modoGrid = !_modoGrid),
            tooltip:   _modoGrid ? 'Vista lista' : 'Vista cuadrícula',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: SearchBar(
              hintText: 'Buscar por nombre, idioma, categoría o nivel...',
              leading:  const Icon(Icons.search),
              trailing: _busqueda.isNotEmpty
                  ? [
                      IconButton(
                        icon:      const Icon(Icons.clear),
                        onPressed: () => setState(() => _busqueda = ''),
                      ),
                    ]
                  : null,
              onChanged: (v) => setState(() => _busqueda = v),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),

          if (_busqueda.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${filtrados.length} resultado${filtrados.length == 1 ? '' : 's'}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            ),

          Expanded(
            child: filtrados.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off,
                            size: 56, color: cs.onSurfaceVariant),
                        const SizedBox(height: 12),
                        Text(
                          'Sin resultados para "$_busqueda"',
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => setState(() => _busqueda = ''),
                          child: const Text('Limpiar búsqueda'),
                        ),
                      ],
                    ),
                  )
                : _modoGrid
                    ? GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:   2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing:  8,
                        ),
                        itemCount:   filtrados.length,
                        itemBuilder: (ctx, i) => TarjetaServidorGrid(
                          servidor:   filtrados[i],
                          onFavorito: () => _toggleFavorito(filtrados[i]),
                          onEliminar: () => _eliminar(filtrados[i]),
                        ),
                      )
                    : ListView.separated(
                        itemCount:        filtrados.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, indent: 72),
                        itemBuilder: (ctx, i) => FilaServidor(
                          servidor:   filtrados[i],
                          onFavorito: () => _toggleFavorito(filtrados[i]),
                          onEliminar: () => _eliminar(filtrados[i]),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
