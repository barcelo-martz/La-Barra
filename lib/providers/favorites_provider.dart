import 'package:flutter/material.dart';
import '../models/trago_categoria.dart';

class FavoritosProvider extends ChangeNotifier {
  final List<TragoCategoria> _favoritos = [];

  List<TragoCategoria> get favoritos => _favoritos;

  void toggleFavorito(TragoCategoria trago) {
    if (_favoritos.contains(trago)) {
      _favoritos.remove(trago);
    } else {
      _favoritos.add(trago);
    }
    notifyListeners();
  }

  bool esFavorito(TragoCategoria trago) => _favoritos.contains(trago);
}