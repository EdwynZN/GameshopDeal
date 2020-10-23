import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter_model.dart';

final _orderBy = Provider.autoDispose((ref) =>
  ref.watch(filterProviderCopy).state.orderBy == OrderBy.Descendant,
  name: 'Order By'
);

class OrderByWidget extends ConsumerWidget{
  const OrderByWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool _isDescendant = watch(_orderBy);
    final ThemeData theme = Theme.of(context);
    final Color _accentColor = theme.accentColor;
    final Color _accentTextThemeColor = theme.accentTextTheme.headline6.color;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: OutlinedButton.icon(
            style: !_isDescendant ? OutlinedButton.styleFrom(
              primary: _accentTextThemeColor,
              backgroundColor: _accentColor
            ) : null,
            onPressed: () {
              if(!_isDescendant) return;
              final StateController<Filter> filter = context.read(filterProviderCopy);
              filter.state = filter.state.copyWith(orderBy: OrderBy.Ascendant);
            },
            icon: const Icon(Icons.arrow_downward, size: 20,),
            label:  const Flexible(child: FittedBox(child: Text('Ascending (A-Z)'),)),
          )
        ),
        Expanded(
          child: OutlinedButton.icon(
            style: _isDescendant ? OutlinedButton.styleFrom(
              primary: _accentTextThemeColor,
              backgroundColor: _accentColor
            ) : null,
            onPressed: () {
              if(_isDescendant) return;
              final StateController<Filter> filter = context.read(filterProviderCopy);
              filter.state = filter.state.copyWith(orderBy: OrderBy.Descendant);
            },
            icon: const Icon(Icons.arrow_upward, size: 20),
            label: const Flexible(child: FittedBox(child: Text('Descending (Z-A)'),))
          )
        ),
      ],
    );
  }
}

