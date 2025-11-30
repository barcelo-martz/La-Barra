import 'package:flutter/material.dart';
import 'package:la_barra/features/categories/categoria_screen.dart';
import 'package:la_barra/features/home/widgets/consejos%20_diarios.dart';
import 'package:la_barra/features/home/widgets/curiosidades_noticias.dart';
import 'package:la_barra/features/home/widgets/retos_logros.dart';
import 'package:la_barra/features/home/widgets/text_carousel.dart';
import 'package:la_barra/features/mi_barra/mi_barra_screen.dart';
import '../widgets/home_header.dart';
import '../widgets/image_carousel.dart';
import '../widgets/category_scroll.dart';
import '../../favorites/favorites_screen.dart';
import '../../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navigate(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Solo Inicio usa Scaffold con header especial y footer
    if (_selectedIndex == 0) {
      return Scaffold(
        drawer: _buildDrawer(context),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(220),
          child: HomeHeader(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: ImageCarousel(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Categorias',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 12),
              CategoryScroll(),
              SizedBox(height: 24),
              AutoTextCarousel(
                titulo: 'Curiosidades',
                icono: Icons.info_outline,
                color: Colors.redAccent,
                items: [
                  'El Mojito era el cóctel favorito de Hemingway.',
                  'El Margarita es uno de los tragos más pedidos en el mundo.',
                  'El Daiquiri nació en Cuba a finales del siglo XIX.',
                ],
            ),
              SizedBox(height: 24),
              // 🏆 Retos y Logros
              RetosLogrosBlock(),
              SizedBox(height: 24),
              AutoTextCarousel(
                titulo: 'Consejos Diarios',
                icono: Icons.lightbulb_outline,
                color: Colors.orange,
                items: [
                  'Agita siempre con hielo para enfriar y diluir correctamente.',
                  'Usa vasos adecuados para cada tipo de cóctel.',
                  'Decora con frutas frescas para dar un toque profesional.',
                  'Prueba nuevas combinaciones, ¡la creatividad es clave!',
                ],
              ),
              SizedBox(height: 24),
              
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   child: Text(
              //     'Mi Barra',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // SizedBox(height: 24),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   child: Text(
              //     'Consejos Diarios',
              //     style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(16),
              //   child: Text(
              //     'Bienvenido a La Barra, tu rincón de coctelería\n¿Qué vas a preparar hoy?',
              //     textAlign: TextAlign.center,
              //   ),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _navigate,
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

    // ✅ Para las demás secciones, renderiza directamente su pantalla completa
    switch (_selectedIndex) {
      case 1:
        return const MiBarraScreen();
      case 2:
        return const FavoritesScreen();
      case 3:
        return const SettingsScreen();
      default:
        return const MiBarraScreen();
    }
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
                    radius: 30,
                    backgroundImage: AssetImage('assets/icons/drinks.png'),
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
    );
  }

  Widget _drawerItem(BuildContext context, String categoria) {
    return ListTile(
      leading: const Icon(Icons.local_drink),
      title: Text(categoria),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CategoriaScreen(categoria: categoria)),
        );
      },
    );
  }
}