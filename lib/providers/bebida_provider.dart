import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:la_barra/models/bebida.dart';

class BebidaProvider extends ChangeNotifier {
  static const String boxName = 'bebidasBox';
  late Box<Bebida> _box;

  BebidaProvider() {
    _init();
  }

  Future<void> _init() async {
    _box = await Hive.openBox<Bebida>(boxName);
    notifyListeners();
  }

  List<Bebida> get bebidas => _box.values.toList();

  void agregarBebida(Bebida b) {
    _box.add(b);
    notifyListeners();
  }

  void eliminarBebida(Bebida b) {
    final index = _box.values.toList().indexOf(b);
    if (index != -1) {
      _box.deleteAt(index);
      notifyListeners();
    }
  }

  void actualizarBebida(int index, Bebida nueva) {
    _box.putAt(index, nueva);
    notifyListeners();
  }
}