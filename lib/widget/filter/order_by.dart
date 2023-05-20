import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter.dart';

final _orderBy = Provider.autoDispose<bool>(
  (ref) {
    final title = ref.watch(titleProvider);
    return ref.watch(filterProviderCopy(title).select((f) => f.isAscendant));
  },
  name: 'Order By',
);

class OrderByWidget extends ConsumerWidget {
  const OrderByWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final bool _isAscendant = ref.watch(_orderBy);
    final ThemeData theme = Theme.of(context);
    final Color _accentColor = theme.colorScheme.secondary;
    final Color _accentTextThemeColor = theme.colorScheme.primary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: OutlinedButton.icon(
            style: _isAscendant
                ? OutlinedButton.styleFrom(
                    foregroundColor: _accentTextThemeColor,
                    backgroundColor: _accentColor)
                : null,
            onPressed: () {
              if (_isAscendant) return;
              final StateController<Filter> filter =
                  ref.read(filterProviderCopy(title).notifier);
              filter.state = filter.state.copyWith(isAscendant: true);
            },
            icon: const Icon(Icons.arrow_upward, size: 20),
            label: Flexible(child: FittedBox(child: Text(translate.ascending))),
          ),
        ),
        Expanded(
          child: OutlinedButton.icon(
            style: !_isAscendant
                ? OutlinedButton.styleFrom(
                    foregroundColor: _accentTextThemeColor,
                    backgroundColor: _accentColor)
                : null,
            onPressed: () {
              if (!_isAscendant) return;
              final StateController<Filter> filter =
                  ref.read(filterProviderCopy(title).notifier);
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
