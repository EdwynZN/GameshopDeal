import 'package:flutter/material.dart';
import 'package:gameshop_deals/riverpod/shared_preference_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/repository/theme_repository.dart';

Future<Map<String,dynamic>> getTheme() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final int themeMode = preferences.getInt('Theme') ?? 0;
  // final int light = preferences.getInt(sharedLightTheme) ?? 0;
  // final int dark = preferences.getInt(sharedDarkTheme) ?? 0;
  return {'Theme' : themeMode};
}

final themeProvider = StateNotifierProvider<ThemeNotifier>((ref) {
  final SharedPreferences preferences = ref.watch(sharedPreferencesProvider);
  final int mode = preferences.getInt('Theme')?.clamp(0, 2) ?? 0;

  return ThemeNotifier(ref.read, ThemeMode.values[mode]);
}, name: 'ThemeMode Provider');

class ThemeNotifier extends StateNotifier<ThemeMode>{
  ThemeNotifier(this._read, [ThemeMode mode]) : super(mode ?? ThemeMode.system);

  final Reader _read;
  final ThemeRepository _theme = ThemeImpl();

  ThemeData get lightTheme => _theme.light;
  ThemeData get darkTheme => _theme.dark;

  toggleMode() async {
    switch(state){
      case ThemeMode.system:
        state = ThemeMode.light;
        break;
      case ThemeMode.light:
        state = ThemeMode.dark;
        break;
      case ThemeMode.dark:
      default:
        state = ThemeMode.system;
        break;
    }
    final SharedPreferences preferences = _read(sharedPreferencesProvider);
    await preferences.setInt('Theme', state.index);
  }

  themePreference(ThemeMode mode) async {
    if(mode != state){
      final SharedPreferences preferences = _read(sharedPreferencesProvider);
      await preferences.setInt('Theme', mode.index);
      state = mode;
    }
  }
}