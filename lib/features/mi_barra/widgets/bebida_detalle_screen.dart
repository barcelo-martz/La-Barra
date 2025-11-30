import 'package:flutter/material.dart';
import 'package:la_barra/providers/bebida_provider.dart';
import 'package:la_barra/features/mi_barra/form/formulario_edicion_screen.dart';
import 'package:provider/provider.dart';

class BebidaDetalleScreen extends StatelessWidget {
  final int index;

  const BebidaDetalleScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BebidaProvider>();
    final bebida = provider.bebidas[index];

    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE),
      appBar: AppBar(
        title: Text(bebida.nombre),
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bebida.nombre,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      bebida.categoria,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                bebida.descripcion,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
              const Divider(height: 32),

              const Row(
                children: [
                  Icon(Icons.kitchen, color: Colors.redAccent),
                  SizedBox(width: 8),
                  Text('Ingredientes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              ...bebida.ingredientes.map((i) => Text('• $i')),
              const Divider(height: 32),

              const Row(
                children: [
                  Icon(Icons.menu_book, color: Colors.redAccent),
                  SizedBox(width: 8),
                  Text('Preparación', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text(bebida.pasos),
              const Divider(height: 32),

              const Row(
                children: [
                  Icon(Icons.build, color: Colors.redAccent),
                  SizedBox(width: 8),
                  Text('Herramientas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              ...bebida.herramientas.map((h) => Text('• $h')),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'edit',
            backgroundColor: Colors.orange,
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormularioEdicionScreen(bebida: bebida),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'delete',
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete),
            onPressed: () {
              provider.eliminarBebida(bebida);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}