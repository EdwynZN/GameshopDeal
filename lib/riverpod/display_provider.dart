import 'package:gameshop_deals/model/deal_view_enum.dart';
import 'package:gameshop_deals/riverpod/hive_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';

final displayProvider = StateNotifierProvider<HiveNotifier<DealView>>((ref) {
  final DealView mode = ref
      .watch(hivePreferencesProvider)
      .get(viewKey, defaultValue: DealView.values.first);

  return HiveNotifier<DealView>(ref.read, viewKey, mode);
}, name: 'DealView Provider');