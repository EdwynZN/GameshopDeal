import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/screen/detail_game_screen.dart';
import 'package:gameshop_deals/screen/detail_screen.dart';
import 'package:gameshop_deals/screen/home_screen.dart';
import 'package:gameshop_deals/screen/filter_screen.dart';
import 'package:gameshop_deals/screen/saved_games_home_screen.dart';
import 'package:gameshop_deals/screen/saved_games_screen.dart';
import 'package:gameshop_deals/screen/settings_screen.dart';
import 'package:gameshop_deals/screen/search_screen.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:math' as math;

class Routes {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case filterRoute:
        return VerticalSlideRoute(
            builder: (_) => FilterScreen(), settings: settings);
      case homeRoute:
        return materialRoute(
          child: const Home(),
          settings: settings,
        );
      case settingsRoute:
        return materialRoute(child: const SettingsScreen(), settings: settings);
      case searchRoute:
        return SlideRoute(
          builder: (_) => SearchScreen(title: settings.arguments as String),
          settings: settings,
        );
      case detailRoute:
        return materialRoute(
          child: DetailDealPageView(offset: settings.arguments as int),
          settings: settings,
        );
      case savedGamesRoute:
        return SlideRoute(
          builder: (_) => GameLookupScreen(),
          settings: settings,
        );
      default:
        return materialRoute(child: const Home(), settings: settings);
    }
  }

  static Route<dynamic> getSearchRoute(RouteSettings settings) {
    switch (settings.name) {
      case filterRoute:
        return VerticalSlideRoute(
            builder: (_) => FilterScreen(), settings: settings);
      case detailRoute:
        return materialRoute(
          child: DetailDealPageView(offset: settings.arguments as int),
          settings: settings,
        );
      case homeRoute:
      default:
        return materialRoute(
          child: Consumer(builder: (context, watch, _) {
            final title = watch(titleProvider);
            return Home.Search(title: title);
          }),
          settings: settings,
        );
    }
  }

  static Route<dynamic> getSavedGamesRoute(RouteSettings settings) {
    switch (settings.name) {
      case detailRoute:
        return materialRoute(
          child: DetailGamePageView(offset: settings.arguments as int),
          settings: settings,
        );
      case homeRoute:
      default:
        return materialRoute(
          child: const GameHome(),
          settings: settings,
        );
    }
  }
}

CupertinoPageRoute cupertinoRoute(
    {Widget child, RouteSettings settings, bool fullscreenDialog = false}) {
  return CupertinoPageRoute(
    settings: settings,
    fullscreenDialog: fullscreenDialog,
    builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness:
            Theme.of(ctx).appBarTheme.brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        systemNavigationBarIconBrightness:
            Theme.of(ctx).appBarTheme.brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        statusBarColor: Theme.of(ctx).appBarTheme.color,
        systemNavigationBarColor: Theme.of(ctx).appBarTheme.color,
      ),
      child: child,
    ),
  );
}

MaterialPageRoute materialRoute(
    {Widget child, RouteSettings settings, bool fullscreenDialog = false}) {
  return MaterialPageRoute(
    settings: settings,
    fullscreenDialog: fullscreenDialog,
    builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness:
            Theme.of(ctx).appBarTheme.brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        systemNavigationBarIconBrightness:
            Theme.of(ctx).appBarTheme.brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        statusBarColor: Theme.of(ctx).appBarTheme.color,
        systemNavigationBarColor: Theme.of(ctx).appBarTheme.color,
      ),
      child: child,
    ),
  );
}

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute(
      {WidgetBuilder builder,
      RouteSettings settings,
      bool fullscreenDialog = false})
      : super(
            builder: builder,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness:
            Theme.of(context).appBarTheme.brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        systemNavigationBarIconBrightness:
            Theme.of(context).appBarTheme.brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        statusBarColor: Theme.of(context).appBarTheme.color,
        systemNavigationBarColor: Theme.of(context).appBarTheme.color,
      ),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}

class VerticalSlideRoute<T> extends PageRoute<T> {
  VerticalSlideRoute(
      {Key key,
      this.builder,
      RouteSettings settings,
      bool fullscreenDialog = false})
      : super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  String get barrierLabel => null;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final double maxHeight = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness:
              Theme.of(context).appBarTheme.brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
          systemNavigationBarIconBrightness:
              Theme.of(context).appBarTheme.brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
          statusBarColor: Theme.of(context).appBarTheme.color,
          systemNavigationBarColor: Theme.of(context).appBarTheme.color,
        ),
        child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(animation),
            child: GestureDetector(
              child: child,
              onVerticalDragUpdate: (DragUpdateDetails details) =>
                  _handleDragUpdate(details, maxHeight),
              onVerticalDragEnd: (DragEndDetails details) =>
                  _handleDragEnd(details, maxHeight),
            )));
  }

  void _handleDragUpdate(DragUpdateDetails details, double maxHeight) {
    if (!navigator.userGestureInProgress) navigator.didStartUserGesture();
    controller.value -= details.primaryDelta / maxHeight;
    if (controller.value == 1.0 && navigator.userGestureInProgress)
      navigator.didStopUserGesture();
  }

  void _handleDragEnd(DragEndDetails details, double maxHeight) {
    final NavigatorState _navigator = navigator;
    if (controller.value == 1.0 && !_navigator.userGestureInProgress) return;
    bool animateForward;

    final double flingVelocity = details.primaryVelocity / maxHeight;
    if (flingVelocity.abs() >= 2.0)
      animateForward = flingVelocity <= 0;
    else
      animateForward = controller.value > 0.85;

    if (animateForward) {
      controller.fling(velocity: math.max(2.0, -flingVelocity));
    } else {
      _navigator.pop();
      if (controller.isAnimating)
        controller.fling(velocity: math.min(-2.0, -flingVelocity));
    }

    if (controller.isAnimating) {
      AnimationStatusListener animationStatusCallback;
      animationStatusCallback = (AnimationStatus status) {
        _navigator.didStopUserGesture();
        controller.removeStatusListener(animationStatusCallback);
      };
      controller.addStatusListener(animationStatusCallback);
    } else {
      _navigator.didStopUserGesture();
    }
  }
}

class SlideRoute<T> extends PageRoute<T> {
  SlideRoute(
      {Key key,
      this.builder,
      RouteSettings settings,
      bool fullscreenDialog = false})
      : super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  String get barrierLabel => null;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness:
            Theme.of(context).appBarTheme.brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        systemNavigationBarIconBrightness:
            Theme.of(context).appBarTheme.brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        statusBarColor: Theme.of(context).appBarTheme.color,
        systemNavigationBarColor: Theme.of(context).appBarTheme.color,
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(animation),
        child: GestureDetector(
          child: child,
          onHorizontalDragUpdate: _handleDragUpdate,
          onHorizontalDragEnd: _handleDragEnd,
        ),
      ),
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!navigator.userGestureInProgress) navigator.didStartUserGesture();
    controller.value -= details.primaryDelta / navigator.context.size.width;
    if (controller.value == 1.0 && navigator.userGestureInProgress)
      navigator.didStopUserGesture();
  }

  void _handleDragEnd(DragEndDetails details) {
    final NavigatorState _navigator = navigator;
    if (controller.value == 1.0 && !_navigator.userGestureInProgress) return;
    bool animateForward;

    final double flingVelocity =
      details.primaryVelocity / navigator.context.size.width;
    if (flingVelocity.abs() >= 2.0)
      animateForward = flingVelocity <= 0;
    else
      animateForward = controller.value > 0.8;
    if (animateForward) {
      controller.fling(velocity: math.max(2.0, -flingVelocity));
    } else {
      _navigator.pop();
      if (controller.isAnimating)
        controller.fling(velocity: math.min(-2.0, -flingVelocity));
    }

    if (controller.isAnimating) {
      AnimationStatusListener animationStatusCallback;
      animationStatusCallback = (AnimationStatus status) {
        _navigator.didStopUserGesture();
        controller.removeStatusListener(animationStatusCallback);
      };
      controller.addStatusListener(animationStatusCallback);
    } else {
      _navigator.didStopUserGesture();
    }
  }
}
