import 'package:flutter/material.dart';
import 'custom_header.dart';

class LaBarraLayout extends StatelessWidget {
  final Widget body;
  final String titulo;
  final int selectedIndex;
  final Function(int) onTabChange;

  const LaBarraLayout({
    super.key,
    required this.body,
    required this.titulo,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                      radius: 30,
                      backgroundImage: AssetImage('assets/icons/drinks.png'),
                    ),
                    SizedBox(height: 12),
                    Text('La Barra',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text('Explora tus categorías favoritas',
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const Divider(),
              _drawerItem(context, 'Clásicos'),
              _drawerItem(context, 'Tropicales'),
              _drawerItem(context, 'De Autor'),
              _drawerItem(context, 'Sin Alcohol'),
              _drawerItem(context, 'De Temporada'),
              _drawerItem(context, 'Postres'),
              _drawerItem(context, 'Shots'),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Versión 1.0.0'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: CustomHeader(titulo: titulo),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onTabChange,
        destinations: const [
          NavigationDestination(
            icon: ImageIcon(AssetImage('assets/icons/home.png')),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: ImageIcon(AssetImage('assets/icons/drinks.png')),
            label: 'Mi Barra',
          ),
          NavigationDestination(
            icon: ImageIcon(AssetImage('assets/icons/favorites.png')),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: ImageIcon(AssetImage('assets/icons/settings.png')),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String categoria) {
    return ListTile(
      leading: const Icon(Icons.local_drink),
      title: Text(categoria),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/categoria/$categoria');
      },
    );
  }
}