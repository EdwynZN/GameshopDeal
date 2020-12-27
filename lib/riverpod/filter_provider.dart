import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/filter.dart';


final filterProviderCopy = StateProvider.autoDispose<Filter>((ref) =>
  ref.read(filterProvider).state.copyWith(),
  name: 'FilterScreen'
);

final filterProvider = StateProvider<Filter>((_) => Filter(), name: 'FilterProvider');