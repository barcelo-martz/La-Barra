import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const AppFooter({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
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
    );
  }
}