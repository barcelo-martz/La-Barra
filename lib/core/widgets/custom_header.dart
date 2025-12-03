import 'package:flutter/material.dart';

class CustomHeader extends StatefulWidget implements PreferredSizeWidget {
  final String titulo;

  const CustomHeader({super.key, required this.titulo});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomHeaderState extends State<CustomHeader> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(198, 40, 40, 1),
      foregroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer(); 
        },
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
              onSubmitted: (query) {
                // Aquí implementas la lógica de búsqueda
                debugPrint("Buscando: $query");
              },
            )
          : Text(widget.titulo),
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
    );
  }
}