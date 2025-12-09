import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:la_barra/models/bebida.dart';
// import 'package:la_barra/models/trago_categoria.dart';

class BebidaProvider extends ChangeNotifier {
  static const String boxName = 'bebidasBox';
  static const String trashBoxName = 'bebidas_trash';
  late Box<Bebida> _box;
  late Box _trashBox;

  BebidaProvider() {
    _init();
  }

  Future<void> _init() async {
    _box = await Hive.openBox<Bebida>(boxName);
    _trashBox = await Hive.openBox(trashBoxName);
    // Purge old trash entries older than 7 days
    await _purgeOldTrash();
    notifyListeners();
  }

  List<Bebida> get bebidas => _box.values.toList();

  void agregarBebida(Bebida b) {
    _box.add(b);
    notifyListeners();
  }

  Future<void> eliminarBebida(Bebida b) async {
    final index = _box.values.toList().indexOf(b);
    if (index != -1) {
      // move to trash with timestamp
      final map = b.toMap();
      await _trashBox.add({'bebida': map, 'deletedAt': DateTime.now().toIso8601String()});
      _box.deleteAt(index);
      notifyListeners();
    }
  }

  void actualizarBebida(int index, Bebida nueva) {
    _box.putAt(index, nueva);
    notifyListeners();
  }

  /// Elimina todas las bebidas del box (Mi Barra)
  Future<void> clearAll() async {
    final items = _box.values.toList();
    final now = DateTime.now().toIso8601String();
    for (final b in items) {
      await _trashBox.add({'bebida': b.toMap(), 'deletedAt': now});
    }
    await _box.clear();
    notifyListeners();
  }

  /// Restaura desde la papelera (solo items borrados hace <= 7 días).
  /// Devuelve el número de items restaurados.
  Future<int> restoreFromTrash() async {
    await _purgeOldTrash();
    final now = DateTime.now();
    int restored = 0;
    // We need keys to delete while iterating
    final entries = _trashBox.toMap();
    for (final entry in entries.entries) {
      final key = entry.key;
      final value = entry.value as Map;
      final deletedAtStr = value['deletedAt'] as String?;
      if (deletedAtStr == null) continue;
      final deletedAt = DateTime.parse(deletedAtStr);
      final difference = now.difference(deletedAt).inDays;
      if (difference <= 7) {
        final bebidaMap = Map<String, dynamic>.from(value['bebida'] as Map);
        final bebida = Bebida.fromMap(bebidaMap);
        await _box.add(bebida);
        await _trashBox.delete(key);
        restored++;
      }
    }
    if (restored > 0) notifyListeners();
    return restored;
  }

  Future<void> _purgeOldTrash() async {
    final now = DateTime.now();
    final entries = _trashBox.toMap();
    for (final entry in entries.entries) {
      final key = entry.key;
      final value = entry.value as Map;
      final deletedAtStr = value['deletedAt'] as String?;
      if (deletedAtStr == null) {
        await _trashBox.delete(key);
        continue;
      }
      final deletedAt = DateTime.parse(deletedAtStr);
      if (now.difference(deletedAt).inDays > 7) {
        await _trashBox.delete(key);
      }
    }
  }
}