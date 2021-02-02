import 'package:gameshop_deals/model/deal_view_enum.dart';
import 'package:gameshop_deals/riverpod/preference_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final displayProvider = StateNotifierProvider<HiveNotifier<DealView>>((ref) {
  final DealView mode = ref
      .watch(preferencesProvider)
      .get('DealView', defaultValue: DealView.values.first);

  return HiveNotifier<DealView>(ref.read, 'DealView', mode);
}, name: 'DealView Provider');