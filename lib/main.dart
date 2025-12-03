import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'providers/bebida_provider.dart';
import 'providers/favorites_provider.dart';
import 'features/home/screens/home_screen.dart';
import 'features/mi_barra/mi_barra_screen.dart';
import 'features/favorites/favorites_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/categories/categoria_screen.dart';
import 'models/bebida.dart';

//flutter run -d web-server
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(BebidaAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BebidaProvider()),
        ChangeNotifierProvider(create: (_) => FavoritosProvider()),
      ],
      child: const LaBarraApp(),
    ),
  );
}

class LaBarraApp extends StatelessWidget {
  const LaBarraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Barra',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/mi_barra': (context) => const MiBarraScreen(),
        '/favoritos': (context) => const FavoritesScreen(),
        '/ajustes': (context) => const SettingsScreen(),
      },
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '');
        if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'categoria') {
          final categoria = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (_) => CategoriaScreen(categoria: categoria),
          );
        }
        return null;
      },
    );
  }
}