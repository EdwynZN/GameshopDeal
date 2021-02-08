import 'package:flutter/material.dart';
import 'package:gameshop_deals/riverpod/hive_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/repository/theme_repository.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier>((ref) {
  final ThemeMode mode = ref
    .watch(hivePreferencesProvider)
    .get(themeModeKey, defaultValue: ThemeMode.system);

  return ThemeNotifier(ref.read, themeModeKey, mode);
}, name: 'ThemeMode Provider');

class ThemeNotifier extends HiveNotifier<ThemeMode> {
  ThemeNotifier(Reader read, String key, ThemeMode mode) : super(read, key, mode);

  final ThemeRepository _theme = ThemeImpl();

  ThemeData get lightTheme => _theme.light;
  ThemeData get darkTheme => _theme.dark;
}