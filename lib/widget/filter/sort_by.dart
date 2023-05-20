import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/model/filter.dart';

final _sortByProvider = Provider.autoDispose<SortBy>((ref) {
  final title = ref.watch(titleProvider);
  return ref.watch(filterProviderCopy(title).select((f) => f.sortBy));
}, name: 'Sort By');

class SortByWidget extends ConsumerWidget {
  const SortByWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final SortBy sortOrder = ref.watch(_sortByProvider);
    return Wrap(
      spacing: 8,
      children: <Widget>[
        for (SortBy sort in SortBy.values)
          ChoiceChip(
            key: ValueKey<SortBy>(sort),
            tooltip: translate.sort_tooltip(sort),
            label: Text(translate.sort(sort)),
            selected: sortOrder == sort,
            onSelected: (val) {
              final StateController<Filter> filter =
                  ref.read(filterProviderCopy(title).notifier);
              filter.state = filter.state.copyWith(sortBy: sort);
            },
          )
      ],
    );
  }
}
