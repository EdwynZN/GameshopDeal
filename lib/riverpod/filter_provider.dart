import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/filter_model.dart';

final filterProviderCopy = StateProvider.autoDispose<Filter>((ref) =>
  ref.watch(filterProvider).state.copy,
  name: 'FilterScreen'
);

final filterProvider = StateProvider<Filter>((_) => Filter(), name: 'FilterProvider');