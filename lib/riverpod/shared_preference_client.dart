import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesClient = Provider((ref) => SharedPreferencesClient());

class SharedPreferencesClient {

  Future<int> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  Future<void> saveInt(String key, int number) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, number);
  }
}