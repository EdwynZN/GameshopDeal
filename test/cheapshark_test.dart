// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshop_deals/riverpod/deal_detail_provider.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';

import 'game_test.dart';

class MockCheapShark extends Mock implements DiscountApi {}

const dioHttpHeadersForResponseBody = {
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

final gameDealLookupTestProvider =
    FutureProvider.family<List<Deal>, String>((ref, id) async {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  final gameLookup = await DiscountApi(Dio()).getGamesById(id);
  final deals = gameLookup.deals;
  return deals..sort((a, b) => b.savings.compareTo(a.savings));
}, name: 'Game Deal Lookup');

void main() {
  group('Testing different dio responses', () {
    /* 
    test('Dio error no internet', () async {
      final MockCheapShark mockDiscountApi = MockCheapShark();

      when(mockDiscountApi.getDeals())
          .thenThrow((_) async => DioErrorType.RESPONSE);

      try {
        final deals = mockDiscountApi.getDeals();
      } catch (e) {
        print('error $e');
      }
    }); */

    test('Compare Deal with Games.deals Provider', () async {
      final file = File('test_resources/deal_response.json');
      final dioAdapterMock = DioAdapterMock();

      final httpResponse = ResponseBody.fromString(
        file.readAsStringSync(),
        200,
        headers: dioHttpHeadersForResponseBody,
      );

      final container = ProviderContainer(overrides: [
        //dioProvider.overrideWithValue(Dio()..httpClientAdapter = dioAdapterMock)
      ]);

      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final result = container.listen(
        dealsOfGameProvider('LEGO Batman'),
        // didChange: (value) => print(value.read())
        // didChange: (value) => expect(value.read(), isA<AsyncData<List<Deal>>>())
      );

      final resultTest = container.listen(gameDealLookupTestProvider('612'));

      expect(result.read(), const AsyncValue<List<Deal>>.loading());
      expect(resultTest.read(), const AsyncValue<List<Deal>>.loading());

      await Future.delayed(const Duration(seconds: 10));

      expect(result.read(), isA<AsyncData<List<Deal>>>());
      expect(resultTest.read(), isA<AsyncData<List<Deal>>>());

      final List<Deal> deals = result.read().data.value;
      final List<Deal> dealsTest = resultTest.read().data.value;

      expect(deals.length, dealsTest.length);
      //expect(deals.map<String>((cb) => cb.dealId), equals(dealsTest.map<String>((cb) => cb.dealId)));
    });
  });

  /* testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GameShop());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  }, skip: true); */
}
