import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gameshop_deals/screen/home_page.dart';
import 'package:gameshop_deals/screen/filter_screen.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'dart:math' as math;

class Routes{
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch(settings.name){
      case filterRoute:
        return VerticalSlideRoute(builder: (_) => FilterScreen());
      case homeRoute:
        return materialRoute(MyHomePage(), settings);
      default:
        return materialRoute(MyHomePage(), settings);
    }
  }
}

CupertinoPageRoute cupertinoRoute(Widget builder, RouteSettings settings){
  return CupertinoPageRoute(
      settings: settings,
      builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(ctx).appBarTheme.color,
          systemNavigationBarColor: Theme.of(ctx).appBarTheme.color,
        ),
        child: builder
      )
  );
}

MaterialPageRoute materialRoute(Widget child, RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(ctx).appBarTheme.color,
        systemNavigationBarColor: Theme.of(ctx).appBarTheme.color,
      ),
      child: child,
    )
  );
}

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).appBarTheme.color,
        systemNavigationBarColor: Theme.of(context).appBarTheme.color,
      ),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}

class VerticalSlideRoute<T> extends MaterialPageRoute<T> {
  VerticalSlideRoute({Key key, WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).appBarTheme.color,
        systemNavigationBarColor: Theme.of(context).appBarTheme.color,
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
          .animate(animation),
        child: child
      )
    );
  }
}

class SlideRoute<T> extends MaterialPageRoute<T> {
  SlideRoute({Key key, WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final double maxWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).appBarTheme.color,
          systemNavigationBarColor: Theme.of(context).appBarTheme.color,
        ),
        child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animation),
            child: GestureDetector(
              child: child,
              onHorizontalDragUpdate: (DragUpdateDetails details) => _handleDragUpdate(details, maxWidth),
              onHorizontalDragEnd: (DragEndDetails details) => _handleDragEnd(details, maxWidth, context),
            )
        )
    );
  }

  void _handleDragUpdate(DragUpdateDetails details, double maxWidth){
    /*
    print('''
      $isFirst || $willHandlePopInternally
      || $hasScopedWillPopCallback || $fullscreenDialog
      || ${animation.status != AnimationStatus.completed}
      || ${secondaryAnimation.status != AnimationStatus.dismissed}
        ''');
    if (isFirst || willHandlePopInternally
      || hasScopedWillPopCallback || fullscreenDialog
      || animation.status != AnimationStatus.completed
      || secondaryAnimation.status != AnimationStatus.dismissed)
      return;
     */
    controller.value -= details.primaryDelta / maxWidth;
  }

  void _handleDragEnd(DragEndDetails details, double maxWidth, BuildContext context){
    if (controller.isAnimating || controller.status == AnimationStatus.dismissed) return;

    final double flingVelocity = details.primaryVelocity / maxWidth;
    if (flingVelocity < 0.0)
      controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      controller.fling(velocity: math.min(-2.0, -flingVelocity))
          .whenComplete(() => Navigator.of(context).maybePop());
    else
      controller.fling(velocity: controller.value < 0.5 ? -2.0 : 2.0)
          .whenComplete(() {if(controller.value == 0) Navigator.of(context).maybePop();});
  }

}