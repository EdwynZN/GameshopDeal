import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;
import 'package:flutter_riverpod/src/internals.dart';
import 'package:gameshop_deals/model/view_enum.dart' as viewEnum;

mixin PrincipalState<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController(keepPage: false);
  late bool _isTablet, _isPageView = false;
  ProviderSubscription<viewEnum.View>? _subscription;
  ProviderContainer _container;
  RefreshController refreshController = RefreshController();
  S translate;

  bool get isTablet => _isTablet;
  bool get isPageView => _isPageView;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translate = S.of(context);
    _isTablet = MediaQuery.of(context).size.longestSide >= 800;
    final container = ProviderScope.containerOf(context);
    if (container != _container) {
      _container = container;
      bool _isPage = _container.read(displayProvider.state) == View.Swipe;
      if (_isPage != isPageView) _isPageView = _isPage;
      _listen();
    }
  }

  void _listen() {
    _subscription?.close();
    _subscription = null;
    _subscription = _container.listen<View>(
      displayProvider.state,
      mayHaveChanged: _mayHaveChanged,
    );
  }

  void _mayHaveChanged(ProviderSubscription<View> subscription) {
    if (subscription?.flush()) {
      bool _isPage = subscription.read() == viewEnum.View.Swipe;
      if (_isPage != isPageView) setState(() => _isPageView = _isPage);
    }
  }

  String errorRequestMessage(AsyncError e) {
    if (e.error is DioError) {
      DioError dioError = e.error as DioError;
      switch (dioError.type) {
        case DioErrorType.unknown:
          if (dioError.error is SocketException) {
            SocketException socketException = dioError.error as SocketException;
            if (socketException.osError != null &&
                socketException.osError!.errorCode == 7)
              return translate.connection_error;
          }
          return translate.dio_error(dioError.type, dioError.message ?? '');
        case DioErrorType.badResponse:
          return '${dioError.response!.statusCode} : ${dioError.response!.statusMessage}';
        case DioErrorType.cancel:
        case DioErrorType.connectionError:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
        default:
          return translate.dio_error(dioError.type, dioError.message ?? '');
      }
    }
    return e.error.toString();
  }

  @override
  void dispose() {
    _subscription?.close();
    scrollController.dispose();
    pageController.dispose();
    refreshController.dispose();
    super.dispose();
  }
}
