import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/filter.dart';

final _metaScore = ScopedProvider<double>((watch) {
    final title = watch(titleProvider);
    return watch(filterProviderCopy(title)).state.metacritic.toDouble();
  },
  name: 'Metacritic Score',
);

class MetacriticFilter extends ConsumerWidget {
  const MetacriticFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final title = watch(titleProvider);
    final double metacritic = watch(_metaScore);
    return Slider.adaptive(
      value: metacritic,
      onChanged: (newValue) {
        final StateController<Filter> filter =
            context.read(filterProviderCopy(title));
        filter.state = filter.state.copyWith(metacritic: newValue.toInt());
      },
      min: 0,
      max: 95,
      divisions: 19,
      label: '${metacritic <= 0 ? translate.any_metacritic : metacritic.toInt()}',
      semanticFormatterCallback: (value) =>
        '${metacritic <= 0 ? translate.any_metacritic : metacritic.toInt()}',
    );
  }
}