import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';

class PriceSlider extends StatefulWidget {
  @override
  _PriceSliderState createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  FilterProvider _filterProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _filterProvider = context.read<FilterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final RangeValues range = RangeValues(
      _filterProvider.lowerPrice.toDouble(),
      _filterProvider.upperPrice.toDouble()
    );
    return RangeSlider(
      values: range,
      onChanged: (newRange) => setState((){
        _filterProvider.lowerPrice = newRange.start.round();
        _filterProvider.upperPrice = newRange.end.round();
      }),
      min: 0, max: 50,
      divisions: 50,
      labels: RangeLabels(
        '\$${range.start}',
        '\$${range.end}'
      ),
      semanticFormatterCallback: (RangeValues rangeValues) =>
      '${rangeValues.start.round()} - ${rangeValues.end.round()} dollars'
    );
  }
}
