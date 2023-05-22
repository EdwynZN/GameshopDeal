import 'package:gameshop_deals/model/view_format_enum.dart';
import 'package:gameshop_deals/provider/hive_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';

final displayProvider =
    StateNotifierProvider<HiveNotifier<ViewFormat>, ViewFormat>((ref) {
  final ViewFormat mode = ref
      .watch(hivePreferencesProvider)
      .get(viewKey, defaultValue: ViewFormat.values.first);

  return HiveNotifier<ViewFormat>(ref, viewKey, mode);
}, name: 'View Provider');
