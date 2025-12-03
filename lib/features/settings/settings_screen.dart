import 'package:flutter/material.dart';
import 'package:la_barra/core/widgets/custom_header.dart';
import 'package:la_barra/core/widgets/app_footer.dart';
import 'package:la_barra/features/categories/categoria_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 3;

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
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: const CustomHeader(titulo: 'Ajustes'),
      body: const Center(child: Text('A implementar por Yanes')),
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