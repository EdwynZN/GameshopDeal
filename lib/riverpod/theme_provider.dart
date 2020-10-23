import 'package:flutter/material.dart';
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

final themeFamilyModeState = StateNotifierProvider.family<ThemeNotifier, ThemeMode>((_, mode) => ThemeNotifier(mode), name: 'ThemeMode Provider');

final themeModeState = StateNotifierProvider<ThemeNotifier>((_) => ThemeNotifier(), name: 'ThemeMode Provider');

class ThemeNotifier extends StateNotifier<ThemeMode>{
  ThemeNotifier([ThemeMode mode]) : super(mode ?? ThemeMode.dark);

  final ThemeRepository _theme = ThemeImpl();

  ThemeMode get mode => state;
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
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('Theme', state.index);
  }

  themePreference(ThemeMode mode) async {
    if(mode != state){
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('Theme', mode.index);
      state = mode;
      print('$state');
    }
  }
}