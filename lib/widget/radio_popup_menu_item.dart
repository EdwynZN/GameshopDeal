import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/riverpod/preference_provider.dart';

class RadioPopupMenuItem<T extends Object> extends PopupMenuItem<T> {
  const RadioPopupMenuItem({
    Key key,
    T value,
    bool enabled = true,
    @required this.provider,
    Widget child,
  }) : 
    assert(enabled != null),
    assert(provider != null),
    super(
      key: key,
      value: value,
      enabled: enabled,
      child: child,
    );

  final StateNotifierProvider<HiveNotifier<T>> provider;

  @override
  Widget get child => super.child;

  @override
  _RadioPopupMenuItemState<T> createState() => _RadioPopupMenuItemState<T>();
}

class _RadioPopupMenuItemState<T>
    extends PopupMenuItemState<T, RadioPopupMenuItem<T>> {

  @override
  void handleTap() {
    context.read(widget.provider).changeState(widget.value);
    super.handleTap();
  }

  @override
  Widget buildChild() {
    return ListTileTheme(
      contentPadding: EdgeInsetsDirectional.zero,
      dense: true,
      style: ListTileStyle.drawer,
      child: ListTile(
        enabled: widget.enabled,
        trailing: Consumer(builder: (_, watch, __) {
          final groupValue = watch(widget.provider.state);
          return Radio<T>(
            value: widget.value,
            groupValue: groupValue,
            onChanged: widget.enabled ? (T newValue) => handleTap() : null,
          );
        }),
        title: widget.child,
      ),
    );
  }
}
