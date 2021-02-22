// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:gameshop_deals/riverpod/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';

import 'model_json_deserialization_test.dart';

class MockCheapShark extends Mock implements DiscountApi {}

const dioHttpHeadersForResponseBody = {
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

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
      final file = File('test_resources/game_lookup.json');
      final dioAdapterMock = DioAdapterMock();

      final httpResponse = ResponseBody.fromString(
        file.readAsStringSync(),
        200,
        headers: dioHttpHeadersForResponseBody,
      );

      final container = ProviderContainer(overrides: [
        dioProvider.overrideWithValue(Dio()..httpClientAdapter = dioAdapterMock)
      ]);

      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final resultGame = container.listen(
        gameDealLookupProvider('612').future,
      );

      //final result = container.listen(dealsOfGameProvider('612'),);

      /* final resultTest = container.listen(gameDealLookupTestProvider('612'));

      expect(result.read(), const AsyncValue<List<Deal>>.loading());
      expect(resultTest.read(), const AsyncValue<List<Deal>>.loading());

      await Future.delayed(const Duration(seconds: 10));

      expect(result.read(), isA<AsyncData<List<Deal>>>());
      expect(resultTest.read(), isA<AsyncData<List<Deal>>>());

      final List<Deal> deals = result.read().data.value;
      final List<Deal> dealsTest = resultTest.read().data.value;

      expect(deals.length, dealsTest.length); */
      await expectLater(
        resultGame.read(),
        completion(isA<GameLookup>()
            .having((d) => d.deals, 'deals length', hasLength(7))),
      );
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
