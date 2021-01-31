import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/filter.dart';

final titleProvider = ScopedProvider<String>((_) => '', name: 'TitleSearch');

final filterProviderCopy = StateProvider.autoDispose.family<Filter, String>(
  (ref, title) => ref.read(filterProvider(title)).state.copyWith(),
  name: 'FilterScreen',
);

final filterProvider = StateProvider.autoDispose.family<Filter, String>(
  (_, title) => Filter(title: title),
  name: 'FilterProvider',
);