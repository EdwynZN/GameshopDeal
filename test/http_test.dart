// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:dio/dio.dart';

void main() {
  test('Test Http Request', () async {
    const String _host = 'https://www.cheapshark.com/api/1.0/';

    BaseOptions _options = BaseOptions(
        baseUrl: _host,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        responseType: ResponseType.json
    );
    Dio dio = Dio(_options);

    Response response = await dio.get<List<dynamic>>('deals', queryParameters: {'metacritic' : 885});
    List<dynamic> map = response.data;
    List<Deal> list = List<Deal>.from(map.map((x) => Deal.fromJson(x)));

    print(list);
    list.forEach((x) => print(x.title));
  });
}
