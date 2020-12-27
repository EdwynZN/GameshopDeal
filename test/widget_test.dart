// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gameshop_deals/main.dart';
import 'package:gameshop_deals/model/filter.dart';

const Map<String, dynamic> defaultFilter = {
  'pageNumber': 0,
  'pageSize': 60,
  'sortBy': 'Deal_Rating',
  'desc': 0,
  'lowerPrice': 0,
  'upperPrice': 50,
  'metacritic': 0,
  'steamRating': 0,
  'AAA': 0,
  'steamWorks': 0,
  'onSale': 0
};

void main() {
  test('Test Freezed filter model', (){
    Filter filter = Filter();
    Filter filterTest = Filter(storeID: <int>{1,2,3}, onlyRetail: true, steamWorks: true);
    Filter filterTest2 = Filter(storeID: <int>{});

    Filter filterTest3 = filterTest.copyWith(storeID: <int>{});

    print(filterTest);
    print(filterTest.toJson());
    print(Filter.fromJson(defaultFilter));
    print(filterTest.parameters);
    print(filterTest3.parameters);

    expect(filterTest2, filter);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
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
  });
}
