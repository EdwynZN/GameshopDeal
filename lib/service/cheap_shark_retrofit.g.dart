// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheap_shark_retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DiscountApi implements DiscountApi {
  _DiscountApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://www.cheapshark.com/api/1.0/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<Deal>> getDeals([parameters, cancelToken]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(parameters ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/deals',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    var value = _result.data
        .map((dynamic i) => Deal.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<DealLookup> getDealsById(id, [cancelToken]) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/deals?id=$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = DealLookup.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<Game>> getGames(parameters, [cancelToken]) async {
    ArgumentError.checkNotNull(parameters, 'parameters');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(parameters ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/games',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    var value = _result.data
        .map((dynamic i) => Game.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<GameLookup> getGamesById(id, [options, cancelToken]) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(<String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/games',
        queryParameters: queryParameters,
        options: newOptions.merge(method: 'GET', baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = GameLookup.fromJson(_result.data);
    return value;
  }

  @override
  Future<Map<String, GameLookup>> getGamesByMultipleId(ids,
      [cancelToken]) async {
    ArgumentError.checkNotNull(ids, 'ids');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ids': ids};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/games',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    var value = _result.data.map((k, dynamic v) =>
        MapEntry(k, GameLookup.fromJson(v as Map<String, dynamic>)));

    return value;
  }

  @override
  Future<List<Store>> getStores(options, [cancelToken]) async {
    ArgumentError.checkNotNull(options, 'options');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(<String, dynamic>{});
    final _result = await _dio.request<List<dynamic>>('/stores',
        queryParameters: queryParameters,
        options: newOptions.merge(method: 'GET', baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    var value = _result.data
        .map((dynamic i) => Store.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions newRequestOptions(Options options) {
    if (options is RequestOptions) {
      return options;
    }
    if (options == null) {
      return RequestOptions();
    }
    return RequestOptions(
      method: options.method,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
      extra: options.extra,
      headers: options.headers,
      responseType: options.responseType,
      contentType: options.contentType.toString(),
      validateStatus: options.validateStatus,
      receiveDataWhenStatusError: options.receiveDataWhenStatusError,
      followRedirects: options.followRedirects,
      maxRedirects: options.maxRedirects,
      requestEncoder: options.requestEncoder,
      responseDecoder: options.responseDecoder,
    );
  }
}
