import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter.dart';

final _orderBy = ScopedProvider<bool>((watch) {
    final title = watch(titleProvider);
    return watch(filterProviderCopy(title)).state.isAscendant;
  },
  name: 'Order By',
);

class OrderByWidget extends ConsumerWidget {
  const OrderByWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final title = watch(titleProvider);
    final bool _isAscendant = watch(_orderBy);
    final ThemeData theme = Theme.of(context);
    final Color _accentColor = theme.accentColor;
    final Color _accentTextThemeColor = theme.accentTextTheme.headline6.color;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: OutlinedButton.icon(
          style: _isAscendant
            ? OutlinedButton.styleFrom(
                primary: _accentTextThemeColor, backgroundColor: _accentColor)
            : null,
          onPressed: () {
            if (_isAscendant) return;
            final StateController<Filter> filter =
                context.read(filterProviderCopy(title));
            filter.state = filter.state.copyWith(isAscendant: true);
          },
          icon: const Icon(Icons.arrow_upward, size: 20),
          label: Flexible(
            child: FittedBox(child: Text(translate.ascending))),
          ),
        ),
        Expanded(
          child: OutlinedButton.icon(
            style: !_isAscendant
              ? OutlinedButton.styleFrom(
                  primary: _accentTextThemeColor,
                  backgroundColor: _accentColor)
              : null,
            onPressed: () {
              if (!_isAscendant) return;
              final StateController<Filter> filter =
                  context.read(filterProviderCopy(title));
              filter.state = filter.state.copyWith(isAscendant: false);
            },
            icon: const Icon(Icons.arrow_downward, size: 20),
            label: Flexible(
              child: FittedBox(
                child: Text(translate.descending),
              ),
            ),
          ),
        ),
      ],
    );
  }
}