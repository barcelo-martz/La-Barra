import 'package:flutter/material.dart';
import 'package:la_barra/models/bebida.dart';
import 'package:la_barra/providers/bebida_provider.dart';
import 'package:provider/provider.dart';

class FormularioEdicionScreen extends StatefulWidget {
  final Bebida bebida;

  const FormularioEdicionScreen({super.key, required this.bebida});

  @override
  State<FormularioEdicionScreen> createState() => _FormularioEdicionScreenState();
}

class _FormularioEdicionScreenState extends State<FormularioEdicionScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _pasosController;
  late List<TextEditingController> _ingredientes;
  late List<TextEditingController> _herramientas;
  late String _categoriaSeleccionada;

  final List<String> _categorias = [
    'Clásico',
    'Tropical',
    'Sin alcohol',
    'Fácil',
    'Fiesta',
    'Frutal',
    'Personalizado',
  ];

  @override
  void initState() {
    super.initState();
    final b = widget.bebida;
    _nombreController = TextEditingController(text: b.nombre);
    _descripcionController = TextEditingController(text: b.descripcion);
    _pasosController = TextEditingController(text: b.pasos);
    _ingredientes = b.ingredientes.map((i) => TextEditingController(text: i)).toList();
    _herramientas = b.herramientas.map((h) => TextEditingController(text: h)).toList();
    _categoriaSeleccionada = b.categoria;
  }

  void _agregarCampo(List<TextEditingController> lista) {
    setState(() => lista.add(TextEditingController()));
  }

  Widget _buildCampos(String label, List<TextEditingController> lista, VoidCallback onAdd) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ...List.generate(lista.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(controller: lista[i]),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  setState(() => lista.removeAt(i));
                },
              ),
            ],
          ),
        );
      }),
      TextButton.icon(
        onPressed: onAdd,
        icon: const Icon(Icons.add, color: Colors.red),
        label: const Text('Agregar otro', style: TextStyle(color: Colors.red)),
      ),
    ],
  );
}

  void _guardarCambios() {
    final nombre = _nombreController.text;
    final descripcion = _descripcionController.text;
    final pasos = _pasosController.text;
    final ingredientes = _ingredientes.map((c) => c.text).where((t) => t.isNotEmpty).toList();
    final herramientas = _herramientas.map((c) => c.text).where((t) => t.isNotEmpty).toList();

    if (nombre.isEmpty || pasos.isEmpty || ingredientes.isEmpty || descripcion.isEmpty) return;

    final bebidaEditada = Bebida(
      nombre: nombre,
      categoria: _categoriaSeleccionada,
      descripcion: descripcion,
      ingredientes: ingredientes,
      pasos: pasos,
      herramientas: herramientas,
    );

    final provider = context.read<BebidaProvider>();
    provider.eliminarBebida(widget.bebida); // elimina la anterior
    provider.agregarBebida(bebidaEditada);  // agrega la nueva

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Trago'),
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _nombreController),
            const SizedBox(height: 12),

            const Text('Categoría', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: _categoriaSeleccionada,
              items: _categorias.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() => _categoriaSeleccionada = value!),
            ),
            const SizedBox(height: 12),

            const Text('Descripción breve', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _descripcionController),
            const SizedBox(height: 12),

            _buildCampos('Ingredientes', _ingredientes, () => _agregarCampo(_ingredientes)),
            const SizedBox(height: 12),

            const Text('Pasos de preparación', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _pasosController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 12),

            _buildCampos('Herramientas', _herramientas, () => _agregarCampo(_herramientas)),
            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE53935)),
              onPressed: _guardarCambios,
              child: const Text('Guardar cambios', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}