import 'package:flutter/material.dart';
import '../models/servidor_ssh.dart';
import '../widgets/fila_servidor.dart';
import '../widgets/tarjeta_servidor_grid.dart';

class PantallaServidores extends StatefulWidget {
  const PantallaServidores({super.key});
  @override
  State<PantallaServidores> createState() => _PantallaServidoresState();
}

class _PantallaServidoresState extends State<PantallaServidores> {
  final _servidores = [
    ServidorSSH(
      id: '1', 
      nombre: 'Inglés Conversacional',  
      idioma: 'Inglés',   
      nivel: 'B2',   
      duracionHoras: 60,   
      modalidad: 'Online', 
      certificado: true,  
      favorito: true,
      categoria: 'conversación',
    ),
    ServidorSSH(
      id: '2', 
      nombre: 'Gramática Francesa',   
      idioma: 'Francés',   
      nivel: 'A2',   
      duracionHoras: 40,   
      modalidad: 'Presencial', 
      certificado: true,
      categoria: 'gramática',
    ),
    ServidorSSH(
      id: '3', 
      nombre: 'Kanjis N5-N4',  
      idioma: 'Japonés',   
      nivel: 'N5', 
      duracionHoras: 80,   
      modalidad: 'Online', 
      certificado: false,
      categoria: 'vocabulario',
    ),
    ServidorSSH(
      id: '4', 
      nombre: 'Alemán para viajar',  
      idioma: 'Alemán', 
      nivel: 'A1',   
      duracionHoras: 20,  
      modalidad: 'Híbrido', 
      certificado: false,
      categoria: 'frases útiles',
    ),
    ServidorSSH(
      id: '5', 
      nombre: 'Italiano Básico',  
      idioma: 'Italiano', 
      nivel: 'A1',   
      duracionHoras: 30,  
      modalidad: 'Autodidacta', 
      certificado: true,
      favorito: true,
      categoria: 'conversación',
    ),
    ServidorSSH(
      id: '6', 
      nombre: 'Chino Mandarín HSK1',  
      idioma: 'Chino', 
      nivel: 'A1',   
      duracionHoras: 50,  
      modalidad: 'Online', 
      certificado: true,
      categoria: 'vocabulario',
    ),
  ];

  bool _modoGrid = false;

  void _toggleFavorito(int i) =>
      setState(() => _servidores[i].favorito = !_servidores[i].favorito);

  void _eliminar(int i) => setState(() => _servidores.removeAt(i));

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           Text('Mis cursos (${_servidores.length})'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        actions: [
          IconButton(
            icon:    Icon(_modoGrid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _modoGrid = !_modoGrid),
            tooltip: _modoGrid ? 'Vista lista' : 'Vista cuadrícula',
          ),
        ],
      ),
      body: _modoGrid
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:   2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 8,
                mainAxisSpacing:  8,
              ),
              itemCount:   _servidores.length,
              itemBuilder: (ctx, i) => TarjetaServidorGrid(
                servidor:   _servidores[i],
                onFavorito: () => _toggleFavorito(i),
                onEliminar: () => _eliminar(i),
              ),
            )
          : ListView.separated(
              itemCount:        _servidores.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, indent: 72),
              itemBuilder: (ctx, i) => FilaServidor(
                servidor:   _servidores[i],
                onFavorito: () => _toggleFavorito(i),
                onEliminar: () => _eliminar(i),
              ),
            ),
    );
  }
}
