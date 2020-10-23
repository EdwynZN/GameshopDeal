import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter_model.dart';

final _metaScore = Provider.autoDispose((ref) =>
  ref.watch(filterProviderCopy).state.metacritic.toDouble(),
  name: 'Metacritic Score'
);

class MetacriticFilter extends ConsumerWidget{
  const MetacriticFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final double metacritic = watch(_metaScore);
    return Slider.adaptive(
      value: metacritic,
      onChanged: (newValue) {
        final StateController<Filter> filter = context.read(filterProviderCopy);
        filter.state = filter.state.copyWith(metacritic: newValue.toInt());
      },
      min: 0, max: 95,
      divisions: 19,
      label: '${metacritic <= 0 ? 'Any' : metacritic.toInt()}',
      semanticFormatterCallback: (value) => '${metacritic <= 0 ? 'Any score' : metacritic.toInt()}'
    );
  }
}
