import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';

class SteamRating extends StatefulWidget {
  @override
  _SteamRatingState createState() => _SteamRatingState();
}

class _SteamRatingState extends State<SteamRating> {
  FilterProvider _filterProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _filterProvider = context.read<FilterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final int steamScore = _filterProvider.metacritic;
    return Slider.adaptive(
      value: steamScore <= 40 ? 40 : steamScore.toDouble(),
      onChanged: (newValue) =>
        setState(() => _filterProvider.steamRating = newValue <= 40 ? 0 : newValue.toInt()),
      min: 40, max: 95,
      divisions: 11,
      label: '${steamScore <= 40 ? ' Any' : steamScore.toString()}',
    );
  }
}
