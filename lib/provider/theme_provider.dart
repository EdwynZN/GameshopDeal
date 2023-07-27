import 'package:flutter/material.dart';
import 'package:gameshop_deals/provider/hive_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/repository/theme_repository.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

final themeModeProvider =
    StateNotifierProvider<ThemeStateNotifier, ThemeMode>((ref) {
  final ThemeMode mode = ref
      .watch(hivePreferencesProvider)
      .get(themeModeKey, defaultValue: ThemeMode.system);

  return ThemeStateNotifier(ref, themeModeKey, mode);
}, name: 'ThemeMode Provider');

class ThemeStateNotifier extends HiveNotifier<ThemeMode> {
  ThemeStateNotifier(super.ref, super.key, super.mode);
}

@riverpod
class ThemeNotifier extends _$ThemeNotifier {

  @override
  ThemeRepository build() => ThemeImpl();
}