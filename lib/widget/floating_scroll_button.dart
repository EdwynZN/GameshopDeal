import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gameshop_deals/generated/l10n.dart';

class FAB extends StatefulWidget {
  final ScrollController controller;
  const FAB({Key key, @required this.controller}) : super(key: key);

  @override
  _FABState createState() => _FABState();
}

class _FABState extends State<FAB> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this)
      ..value = 1.0;
    positionAnimation = Tween<Offset>(begin: Offset(0, 1.5), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 1, curve: Curves.decelerate),
    ));
    widget.controller?.addListener(_scrollAnimationListener);
  }

  @override
  void didUpdateWidget(covariant FAB oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_scrollAnimationListener);
      widget.controller?.addListener(_scrollAnimationListener);
    }
  }

  void _scrollAnimationListener() {
    if ((widget.controller?.hasClients ?? false) && !_controller.isAnimating) {
      switch (widget.controller.position.userScrollDirection) {
        case ScrollDirection.forward:
          if (_controller.isDismissed) _controller.forward();
          _controller.forward();
          break;
        case ScrollDirection.reverse:
          if (_controller.isCompleted) _controller.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(_scrollAnimationListener);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return SlideTransition(
      position: positionAnimation,
      child: FloatingActionButton(
        tooltip: translate.up_tooltip,
        //heroTag: '${title}_FAB',
        onPressed: () => widget.controller.jumpTo(0.0),
        child: const Icon(Icons.keyboard_arrow_up),
      ),
    );
  }
}