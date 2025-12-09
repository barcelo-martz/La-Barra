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

    final theme = Theme.of(context);
    return Scaffold(
      // Use theme background so dark mode is respected
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(bebida.nombre),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
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
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      bebida.categoria,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSecondary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                bebida.descripcion,
                style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
              ),
              const Divider(height: 32),
              Row(
                children: [
                  Icon(Icons.kitchen, color: theme.colorScheme.secondary),
                  const SizedBox(width: 8),
                  Text('Ingredientes', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              ...bebida.ingredientes.map((i) => Text('• $i', style: theme.textTheme.bodyMedium)),
              const Divider(height: 32),
              Row(
                children: [
                  Icon(Icons.menu_book, color: theme.colorScheme.secondary),
                  const SizedBox(width: 8),
                  Text('Preparación', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text(bebida.pasos, style: theme.textTheme.bodyMedium),
              const Divider(height: 32),

              Row(
                children: [
                  Icon(Icons.build, color: theme.colorScheme.secondary),
                  const SizedBox(width: 8),
                  Text('Herramientas', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              ...bebida.herramientas.map((h) => Text('• $h', style: theme.textTheme.bodyMedium)),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'edit',
            backgroundColor: theme.colorScheme.secondary,
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
            backgroundColor: theme.colorScheme.error,
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