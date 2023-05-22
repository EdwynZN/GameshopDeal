import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;
import 'package:flutter_riverpod/src/internals.dart';

mixin PrincipalState<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController(keepPage: false);
  late bool _isTablet;
  RefreshController refreshController = RefreshController();
  late S translate;

  bool get isTablet => _isTablet;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translate = S.of(context);
    _isTablet = MediaQuery.of(context).size.longestSide >= 800;
  }

  String errorRequestMessage(AsyncError<dynamic> e) {
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
    scrollController.dispose();
    pageController.dispose();
    refreshController.dispose();
    super.dispose();
  }
}
