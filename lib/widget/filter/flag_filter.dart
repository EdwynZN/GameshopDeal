import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';

class FlagFilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      alignment: WrapAlignment.center,
      children: <Widget>[
        _OnSaleFilterWidget(),
        _RetailWidget(),
        _SteamWorksWidget(),
      ],
    );
  }
}

class _OnSaleFilterWidget extends StatefulWidget {
  @override
  __OnSaleFilterWidgetState createState() => __OnSaleFilterWidgetState();
}

class __OnSaleFilterWidgetState extends State<_OnSaleFilterWidget> {
  FilterProvider _filterProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _filterProvider = context.read<FilterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final bool sale = _filterProvider.onSale;
    return FilterChip(
      label: const Text('On sale'),
      tooltip: 'On sale',
      selected: sale,
      onSelected: (value) => setState(() => _filterProvider.onSale = value)
    );
  }
}

class _RetailWidget extends StatefulWidget {
  @override
  __RetailWidgetState createState() => __RetailWidgetState();
}

class __RetailWidgetState extends State<_RetailWidget> {
  FilterProvider _filterProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _filterProvider = context.read<FilterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final bool retail = _filterProvider.onlyRetail;
    return FilterChip(
      label: const Text('Retail discount'),
      tooltip: 'Retail discount',
      selected: retail,
      onSelected: (value) => setState(() => _filterProvider.onlyRetail = value)
    );
  }
}

class _SteamWorksWidget extends StatefulWidget {
  @override
  __SteamWorksWidgetState createState() => __SteamWorksWidgetState();
}

class __SteamWorksWidgetState extends State<_SteamWorksWidget> {
  FilterProvider _filterProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _filterProvider = context.read<FilterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final bool steamWorks = _filterProvider.steamWorks;
    return FilterChip(
      label: const Text('SteamWorks'),
      tooltip: 'SteamWorks',
      selected: steamWorks,
      onSelected: (value) => setState(() => _filterProvider.steamWorks = value)
    );
  }
}
