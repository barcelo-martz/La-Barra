import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:la_barra/services/notification_service.dart';

class SettingsProvider extends ChangeNotifier {
  static const String boxName = 'settings';
  late Box _box;

  SettingsProvider() {
    _init();
  }

  Future<void> _init() async {
    _box = await Hive.openBox(boxName);
    notifyListeners();
  }

  bool get darkMode => _box.get('darkMode', defaultValue: false) as bool;
  set darkMode(bool v) {
    _box.put('darkMode', v);
    notifyListeners();
  }

  bool get dailyNotifications => _box.get('dailyNotifications', defaultValue: false) as bool;
  set dailyNotifications(bool v) {
    _box.put('dailyNotifications', v);
    notifyListeners();
    // schedule or cancel daily notification
    if (v) {
      NotificationService().scheduleDailyNotification();
    } else {
      NotificationService().cancelNotification(0);
    }
  }

  bool get challengeReminders => _box.get('challengeReminders', defaultValue: false) as bool;
  set challengeReminders(bool v) {
    _box.put('challengeReminders', v);
    notifyListeners();
    if (v) {
      NotificationService().scheduleChallengeReminder();
    } else {
      NotificationService().cancelChallengeReminder();
    }
  }

  Future<void> saveFeedback(String text) async {
    final List existing = _box.get('feedback', defaultValue: <String>[]) as List;
    existing.add(text);
    await _box.put('feedback', existing);
  }
}
