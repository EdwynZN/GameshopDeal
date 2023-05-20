import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/filter.dart';

final _metaScore = Provider.autoDispose<double>(
  (ref) {
    final title = ref.watch(titleProvider);
    return ref.watch(filterProviderCopy(title).select((f) => f.metacritic.toDouble()));
  },
  name: 'Metacritic Score',
);

class MetacriticFilter extends ConsumerWidget {
  const MetacriticFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final double metacritic = ref.watch(_metaScore);
    return Slider.adaptive(
      value: metacritic,
      onChanged: (newValue) {
        final StateController<Filter> filter =
            ref.read(filterProviderCopy(title).notifier);
        filter.state = filter.state.copyWith(metacritic: newValue.toInt());
      },
      min: 0,
      max: 95,
      divisions: 19,
      label:
          '${metacritic <= 0 ? translate.any_metacritic : metacritic.toInt()}',
      semanticFormatterCallback: (value) =>
          '${metacritic <= 0 ? translate.any_metacritic : metacritic.toInt()}',
    );
  }
}
