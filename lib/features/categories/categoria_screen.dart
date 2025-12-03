import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:la_barra/core/widgets/empty_state.dart';
import 'package:la_barra/core/widgets/app_footer.dart';
import 'package:la_barra/core/widgets/trago_detalle_screen.dart';
import 'package:la_barra/features/categories/tragos_por_categoria.dart';
import 'package:la_barra/providers/favorites_provider.dart';

class CategoriaScreen extends StatefulWidget {
  final String categoria;

  const CategoriaScreen({super.key, required this.categoria});

  @override
  State<CategoriaScreen> createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

  void _navigate(int index) {
    Navigator.pushReplacementNamed(context, _routeFromIndex(index));
  }

  String _routeFromIndex(int i) {
    switch (i) {
      case 0: return '/';
      case 1: return '/mi_barra';
      case 2: return '/favoritos';
      case 3: return '/ajustes';
      default: return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritos = context.watch<FavoritosProvider>();
    //final todos = tragosPorCategoria[widget.categoria] ?? [];
    final box = Hive.box<TragoCategoria>('tragos');

    // Filtro simple por búsqueda (por nombre y descripción)
    //final query = _searchController.text.trim().toLowerCase();
    //final tragos = query.isEmpty
    //    ? todos
    //    : todos.where((t) {
    //        return t.nombre.toLowerCase().contains(query) ||
    //            t.descripcion.toLowerCase().contains(query);
    //      }).toList();

   // Todos los tragos de la categoría seleccionada
    final todos = box.values
        .where((t) => t.categoria == widget.categoria)
        .toList();

    // Filtro de búsqueda
    final query = _searchController.text.trim().toLowerCase();
    final tragos = query.isEmpty
        ? todos
        : todos.where((t) =>
            t.nombre.toLowerCase().contains(query) ||
            t.descripcion.toLowerCase().contains(query) ||
            t.ingredientes.any((ing) => ing.toLowerCase().contains(query))
          ).toList();   

    return Scaffold(
      // Drawer propio para que el ícono de menú funcione en esta ruta
      drawer: _buildDrawer(context),

      appBar: AppBar(
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Buscar...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (_) => setState(() {}),
              )
            : Text(widget.categoria,
                style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) _searchController.clear();
              });
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: tragos.isEmpty
        ? _buildEmptyState()
        /* child */: ListView.builder(
          itemCount: tragos.length,
          itemBuilder: (_, i) {
            final trago = tragos[i];
            final esFavorito = favoritos.esFavorito(trago);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TragoDetalleScreen(trago: trago),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          trago.imagen,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(trago.nombre,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(height: 4),
                            Text(trago.descripcion,
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text(trago.categoria,
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          esFavorito ? Icons.favorite : Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => favoritos.toggleFavorito(trago),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: AppFooter(
        selectedIndex: _selectedIndex,
        onTabChange: _navigate,
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {

      // Extraemos categorías únicas desde Hive
    final box = Hive.box<TragoCategoria>('tragos');
    final categorias = box.values.map((t) => t.categoria).toSet().toList();

    categorias.sort((a, b)=> a.compareTo(b))

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Color(0xFFE53935)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/logo/logo.jpg'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'La Barra',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Explora tus categorías favoritas',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            //////////////////////////////////////////////////////////
            const Divider(),
            _drawerItem(context, 'Clásicos', Icons.local_bar),
          _drawerItem(context, 'Tropicales', Icons.beach_access),
          _drawerItem(context, 'De Autor', Icons.star),
          _drawerItem(context, 'Sin Alcohol', Icons.no_drinks),
          _drawerItem(context, 'De Temporada', Icons.calendar_today),
          _drawerItem(context, 'Postres', Icons.icecream),
          _drawerItem(context, 'Shots', Icons.bolt),
            //const Divider(),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Versión Beta 1.0'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String categoria, IconData icono) {
  return ListTile(
    leading: Icon(icono, color: Colors.redAccent),
    title: Text(categoria),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CategoriaScreen(categoria: categoria),
        ),
      );
    },
  );
}
}