import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/provider/hive_preferences_provider.dart';

class RadioPopupMenuItem<T extends Object> extends PopupMenuItem<T> {
  const RadioPopupMenuItem({
    Key? key,
    T? value,
    bool enabled = true,
    required this.provider,
    Widget? child,
  }) : super(
          key: key,
          value: value,
          enabled: enabled,
          child: child,
        );

  final StateNotifierProvider<HiveNotifier<T>, T> provider;

  @override
  Widget? get child => super.child;

  @override
  _RadioPopupMenuItemState<T> createState() => _RadioPopupMenuItemState<T>();
}

class _RadioPopupMenuItemState<T extends Object>
    extends PopupMenuItemState<T, RadioPopupMenuItem<T>> {

  @override
  Widget buildChild() {
    return ListTileTheme(
      contentPadding: EdgeInsetsDirectional.zero,
      dense: true,
      style: ListTileStyle.drawer,
      child: ListTile(
        enabled: widget.enabled,
        trailing: Consumer(
          builder: (_, ref, __) {
            final groupValue = ref.watch(widget.provider);
            return Radio<T?>(
              value: widget.value,
              groupValue: groupValue,
              onChanged: widget.enabled
                  ? (T? newValue) {
                      if (newValue != null) {
                        ref.read(widget.provider.notifier).changeState(newValue);
                      }
                      super.handleTap();
                    }
                  : null,
            );
          },
        ),
        title: widget.child,
      ),
    );
  }
}
