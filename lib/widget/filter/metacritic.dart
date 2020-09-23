import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';

class MetacriticFilter extends StatefulWidget {
  @override
  _MetacriticFilterState createState() => _MetacriticFilterState();
}

class _MetacriticFilterState extends State<MetacriticFilter> {
  FilterProvider _filterProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _filterProvider = context.read<FilterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final int metaScore = _filterProvider.metacritic;
    return Slider.adaptive(
      value: metaScore.toDouble(),
      onChanged: (newValue) => setState(() => _filterProvider.metacritic = newValue.toInt()),
      min: 0, max: 95,
      divisions: 19,
      label: '${metaScore <= 0 ? ' Any' : metaScore.toString()}',
    );
  }
}
