import 'package:flutter/material.dart';
import 'package:la_barra/core/widgets/custom_header.dart';
import 'package:la_barra/core/widgets/app_footer.dart';
import 'package:la_barra/features/categories/categoria_screen.dart';
import 'package:la_barra/features/mi_barra/form/formulario_bebida_screen.dart';
import 'package:la_barra/features/mi_barra/widgets/bebida_card.dart';
import 'package:la_barra/providers/bebida_provider.dart';
import 'package:provider/provider.dart';

class MiBarraScreen extends StatefulWidget {
  const MiBarraScreen({super.key});

  @override
  State<MiBarraScreen> createState() => _MiBarraScreenState();
}

class _MiBarraScreenState extends State<MiBarraScreen> {
  int _selectedIndex = 1;

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
    final bebidas = context.watch<BebidaProvider>().bebidas;

    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: const CustomHeader(titulo: 'Mi Barra'),
      body: bebidas.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_bar, size: 100, color: Colors.grey),
                  SizedBox(height: 26),
                  Text(
                    'Tu barra está más limpia que una copa recién lavada.\n¡Hora de ensuciarla con tus creaciones!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 23),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bebidas.length,
              itemBuilder: (_, i) => BebidaCard(bebida: bebidas[i]),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE53935),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormularioBebidaScreen()),
          );
        },
      ),
      bottomNavigationBar: AppFooter(
        selectedIndex: _selectedIndex,
        onTabChange: _navigate,
      ),
    );
  }

 Widget _buildDrawer(BuildContext context) {
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