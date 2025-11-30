import 'package:flutter/material.dart';
import 'package:la_barra/models/bebida.dart';
import 'package:la_barra/features/mi_barra/widgets/bebida_detalle_screen.dart';
import 'package:provider/provider.dart';
import 'package:la_barra/providers/bebida_provider.dart';

class BebidaCard extends StatelessWidget {
  final Bebida bebida;

  const BebidaCard({super.key, required this.bebida});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final provider = context.read<BebidaProvider>();
        final index = provider.bebidas.indexOf(bebida);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BebidaDetalleScreen(index: index)),
        );
      },
      child: Card(
        color: const Color(0xFFFFEBEE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bebida.nombre,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text('Categoría: ${bebida.categoria}'),
              const SizedBox(height: 4),
              Text('Descripción: ${bebida.descripcion}'),
            ],
          ),
        ),
      ),
    );
  }
}