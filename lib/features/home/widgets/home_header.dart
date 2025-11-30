import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(198, 40, 40, 1),
      elevation: 0,

      // Menú hamburguesa abre el drawer
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white , size: 38),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),

      // Ícono de lupa (PNG) a la derecha
      // actions: const [
      //   Padding(
      //     padding: EdgeInsets.only(right: 16),
      //     child: ImageIcon(
      //       AssetImage('assets/icons/search.png'),
      //       color: Colors.white,
      //       size: 24,
      //     ),
      //   ),
      // ],

      // Contenido del header
      flexibleSpace: SafeArea(
        child: Container(
          color: const Color.fromRGBO(170, 40, 40, 1),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'La Barra',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Bienvenido a La Barra tu rincón de coctelería\n¿qué vas a preparar hoy?',
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Buscador dentro del header (estilo visual)
              TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar trago...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}