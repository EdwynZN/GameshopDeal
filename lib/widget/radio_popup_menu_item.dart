import 'package:flutter/material.dart';

class RadioPopupMenuItem<T> extends PopupMenuItem<T> {
  const RadioPopupMenuItem({
    Key key,
    T value,
    bool enabled = true,
    this.groupValue,
    Widget child,
  }) : super(
    key: key,
    value: value,
    enabled: enabled,
    child: child,
  );

  final T groupValue;

  @override
  Widget get child => super.child;

  @override
  _RadioPopupMenuItemState<T> createState() => _RadioPopupMenuItemState<T>();
}

class _RadioPopupMenuItemState<T>
    extends PopupMenuItemState<T, RadioPopupMenuItem<T>> {
  T groupValue;

  @override
  void initState() {
    super.initState();
    groupValue = widget.groupValue;
  }

  @override
  void handleTap() {
    setState(() => groupValue = widget.value);
    super.handleTap();
  }

  @override
  Widget buildChild() {
    return ListTileTheme(
      contentPadding: EdgeInsets.zero,
      style: ListTileStyle.list,
      child: ListTile(
        enabled: widget.enabled,
        trailing: Radio<T>(
          value: widget.value,
          groupValue: groupValue,
          toggleable: true,
          onChanged: widget.enabled ? (T newValue) => handleTap() : null,
        ),
        title: widget.child,
      ),
    );
  }
}
