import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';

class OrderByWidget extends StatefulWidget {

  @override
  _OrderByWidgetState createState() => _OrderByWidgetState();
}

class _OrderByWidgetState extends State<OrderByWidget> {
  FilterProvider _filterProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _filterProvider = context.read<FilterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final bool _isDescendant = _filterProvider.orderBy == OrderBy.Descendant;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: FlatButton.icon(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            textColor: !_isDescendant ? Theme.of(context).accentTextTheme.headline6.color : null,
            color: !_isDescendant ? Theme.of(context).accentColor : null,
            shape: Border.all(
              color: Theme.of(context).accentColor,
              width: 2,
            ),
            onPressed: () => !_isDescendant ? null : setState(() => _filterProvider.orderBy = OrderBy.Ascendant),
            icon: const Icon(Icons.arrow_downward, size: 20,),
            label:  const Flexible(child: FittedBox(child: Text('Ascending (A-Z)'),)),
          )
        ),
        Expanded(
          child: FlatButton.icon(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            textColor: _isDescendant ? Theme.of(context).accentTextTheme.headline6.color : null,
            color: _isDescendant ? Theme.of(context).accentColor : null,
            shape: Border(
              bottom: BorderSide(
                color: Theme.of(context).accentColor,
                width: 2,
              ),
              top: BorderSide(
                color: Theme.of(context).accentColor,
                width: 2,
              ),
              left: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: 0.0
              ),
              right: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: 2.0
              ),
            ),
            onPressed: () => _isDescendant ? null : setState(() => _filterProvider.orderBy = OrderBy.Descendant),
            icon: const Icon(Icons.arrow_upward, size: 20),
            label: const Flexible(child: FittedBox(child: Text('Descending (Z-A)'),))
          )
        ),
      ],
    );
  }
}

