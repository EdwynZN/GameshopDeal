import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:flutter/foundation.dart';

extension on SortBy{
  String get name => describeEnum(this).replaceFirst('_', ' ');
}

final _sortByProvider = ScopedProvider<SortBy>((watch) =>
  watch(filterProviderCopy).state.sortBy,
  name: 'Sort By'
);

class SortByWidget extends ConsumerWidget{
  const SortByWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final SortBy sortOrder = watch(_sortByProvider);
    return Wrap(
      spacing: 8,
      children: <Widget>[
        for(SortBy sort in SortBy.values)
          ChoiceChip(
            key: ValueKey<String>(sort.name),
            tooltip: sort.name,
            label: Text(sort.name),
            selected: sortOrder == sort,
            onSelected: (val) {
              final StateController<Filter> filter = context.read(filterProviderCopy);
              filter.state = filter.state.copyWith(sortBy: sort);
            },
          )
      ],
    );
  }
}
