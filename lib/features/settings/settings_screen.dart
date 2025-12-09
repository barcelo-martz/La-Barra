import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:la_barra/core/widgets/custom_header.dart';
import 'package:la_barra/core/widgets/app_footer.dart';
import 'package:la_barra/features/categories/categoria_screen.dart';
import 'package:la_barra/providers/settings_provider.dart';
import 'package:la_barra/providers/bebida_provider.dart';
import 'package:la_barra/providers/favorites_provider.dart';
// bebida and favorites providers not needed here when only theme toggle is shown

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
      case 0:
        return '/';
      case 1:
        return '/mi_barra';
      case 2:
        return '/favoritos';
      case 3:
        return '/ajustes';
      default:
        return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: const CustomHeader(titulo: 'Ajustes'),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const SizedBox(height: 8),
          const Text('Preferencias', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SwitchListTile.adaptive(
            title: const Text('Tema oscuro'),
            value: settings.darkMode,
            onChanged: (v) => settings.darkMode = v,
            secondary: const Icon(Icons.brightness_6),
          ),
          SwitchListTile.adaptive(
            title: const Text('Notificaciones diarias'),
            value: settings.dailyNotifications,
            onChanged: (v) => settings.dailyNotifications = v,
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile.adaptive(
            title: const Text('Recordatorios de retos'),
            value: settings.challengeReminders,
            onChanged: (v) => settings.challengeReminders = v,
            secondary: const Icon(Icons.flag),
          ),

          const SizedBox(height: 12),
          const Divider(),
          const Text('Datos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // Moved 'Quitar favoritos' into Datos section
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.redAccent),
            title: const Text('Quitar favoritos'),
            onTap: () async {
              final favProv = Provider.of<FavoritosProvider>(context, listen: false);
              final ok = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Quitar favoritos'),
                  content: const Text('¿Deseas quitar todos los favoritos?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                    ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Confirmar')),
                  ],
                ),
              );
              if (ok ?? false) {
                favProv.clearAll();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Favoritos eliminados.')));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
            title: const Text('Borrar todo el contenido de Mi Barra'),
            onTap: () async {
              final bebidaProv = Provider.of<BebidaProvider>(context, listen: false);
              final ok = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Borrar Mi Barra'),
                  content: const Text('¿Seguro que deseas eliminar todo el contenido de Mi Barra? Los items irán a la papelera por 7 días.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                    ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Confirmar')),
                  ],
                ),
              );
              if (ok ?? false) {
                await bebidaProv.clearAll();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mi Barra vaciada y movida a la papelera (7 días).')));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.restore, color: Colors.green),
            title: const Text('Restaurar contenido de Mi Barra'),
            subtitle: const Text('Recupera items borrados en los últimos 7 días'),
            onTap: () async {
              final bebidaProv = Provider.of<BebidaProvider>(context, listen: false);
              final ok = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Restaurar Mi Barra'),
                  content: const Text('Se restaurarán los items borrados en los últimos 7 días. Continuar?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                    ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Confirmar')),
                  ],
                ),
              );
              if (ok ?? false) {
                final restored = await bebidaProv.restoreFromTrash();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Restaurados: $restored items.')));
              }
            },
          ),
          const SizedBox(height: 12),

          // Version section
          const Text('Versión', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Versión de la app'),
            subtitle: const Text('1.0.0+1'),
          ),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: AppFooter(
        selectedIndex: _selectedIndex,
        onTabChange: _navigate,
      ),
    );
  }

  // No extra dialogs needed when only theme toggle is shown.

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
            _drawerItem(context, 'Modernos', Icons.star),
            _drawerItem(context, 'Sin Alcohol', Icons.no_drinks),
            _drawerItem(context, 'De Temporada', Icons.calendar_today),
            _drawerItem(context, 'Postres o Dulces', Icons.icecream),
            _drawerItem(context, 'Shots', Icons.bolt),
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