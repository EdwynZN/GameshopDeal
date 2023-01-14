import 'package:gameshop_deals/riverpod/hive_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/preference.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';

final preferenceProvider =
    StateNotifierProvider<HiveNotifier<Preference>, Preference>((ref) {
  final Preference mode = ref
      .watch(hivePreferencesProvider)
      .get(preferenceKey, defaultValue: const Preference());

  return HiveNotifier<Preference>(ref.read, preferenceKey, mode);
}, name: 'Preference Provider');