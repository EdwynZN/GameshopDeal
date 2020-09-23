import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';

class SortByWidget extends StatefulWidget {
  @override
  _SortByWidgetState createState() => _SortByWidgetState();
}

class _SortByWidgetState extends State<SortByWidget> {
  FilterProvider _filterProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _filterProvider = context.read<FilterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final SortBy sortOrder = _filterProvider.sortBy;
    return Wrap(
      spacing: 8,
      children: <Widget>[
        for(SortBy sort in SortBy.values)
          ChoiceChip(
            key: ValueKey<String>(describeEnum(sort)),
            tooltip: describeEnum(sort).replaceFirst('_', ' '),
            label: Text(describeEnum(sort).replaceFirst('_', ' ')),
            selected: sortOrder == sort,
            onSelected: (val) => setState(() =>  _filterProvider.sortBy = sort),
          )
      ],
    );
  }
}
