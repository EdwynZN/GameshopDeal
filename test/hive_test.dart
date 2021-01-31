// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';

const Iterable<String> values = [
  'Grand',
  'Grand Theft',
  'StAr WarS',
  'StarWars',
  'Star-Wars',
  'Star Wars',
  'star wars',
  'battle star galactic'
];

class MockitoBox extends Mock implements Box<dynamic> {}

void main() {
  test('Find word/phrase insensitive', () {
    final exp1 = RegExp('star', caseSensitive: false);
    final iterable = values.where((element) => exp1.hasMatch(element));
    expect(iterable, isNotEmpty);
    expect(
      iterable.toList(),
      isList.having((l) => l.length, 'length 6', equals(6)).having(
            (l) => l,
            'list Strings',
            containsAllInOrder(<String>[
              'StAr WarS',
              'StarWars',
              'Star-Wars',
              'Star Wars',
              'star wars',
              'battle star galactic'
            ]),
          ),
    );

    final iterable2 = values
        .take(2)
        .firstWhere((element) => exp1.hasMatch(element), orElse: () => null);
    expect(iterable2, isNull);

    final exp2 = RegExp('star wars', caseSensitive: false);
    final iterable3 = values.where((element) => exp2.hasMatch(element));
    expect(iterable3, isNotEmpty);
    expect(
      iterable3.toList(),
      isList.having((l) => l.length, 'length 3', equals(3)).having(
            (l) => l,
            'list Strings',
            containsAllInOrder(<String>['StAr WarS', 'Star Wars', 'star wars']),
          ),
    );
  });

  test('Find as a whole sentence insensitive', () {
    final exp1 = RegExp('\^star\$', caseSensitive: false);
    final iterable = values.where((element) => exp1.hasMatch(element));
    expect(iterable, isEmpty);

    final exp2 = RegExp('\^gRanD\$', caseSensitive: false);
    final iterable2 = values.where((element) => exp2.hasMatch(element));
    expect(iterable2, isNotEmpty);
    expect(iterable2.length, equals(1));
    expect(iterable2.first, equals('Grand'));

    final exp3 = RegExp('\^star wars\$', caseSensitive: false);
    final iterable3 = values.where((element) => exp3.hasMatch(element));
    expect(iterable3, isNotEmpty);
    expect(
      iterable3.toList(),
      isList.having((l) => l.length, 'length 3', equals(3)).having(
        (l) => l,
        'list Strings',
        containsAllInOrder(<String>['StAr WarS', 'Star Wars', 'star wars']),
      ),
    );
  });
}
