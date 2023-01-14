import 'package:gameshop_deals/model/view_enum.dart';
import 'package:gameshop_deals/riverpod/hive_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';

final displayProvider = StateNotifierProvider<HiveNotifier<View>, View>((ref) {
  final View mode = ref
      .watch(hivePreferencesProvider)
      .get(viewKey, defaultValue: View.values.first);

  return HiveNotifier<View>(ref.read, viewKey, mode);
}, name: 'View Provider');