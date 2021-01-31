import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter.dart';

final _rangePrice = ScopedProvider<RangeValues>((watch) {
  final title = watch(titleProvider);
  double lower = watch(filterProviderCopy(title)).state.lowerPrice.toDouble();
  double upper = watch(filterProviderCopy(title)).state.upperPrice.toDouble();

  return RangeValues(lower, upper);
}, name: 'RangePrice');

class PriceSlider extends ConsumerWidget {
  const PriceSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final title = watch(titleProvider);
    final RangeValues range = watch(_rangePrice);
    return RangeSlider(
      values: range,
      onChanged: (newRange) {
        final StateController<Filter> filter =
          context.read(filterProviderCopy(title));
        filter.state = filter.state.copyWith(
          lowerPrice: newRange.start.round(),
          upperPrice: newRange.end.round(),
        );
      },
      min: 0,
      max: 50,
      divisions: 50,
      labels: RangeLabels('\$${range.start.toInt()}', '\$${range.end.toInt()}'),
      semanticFormatterCallback: translate.dollar_currency,
    );
  }
}