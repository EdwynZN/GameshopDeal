import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/all.dart';

mixin FutureDelegate<T> {
  Future<T> call();
}

const k_STRING_DELEGATE = StringDelegate();

class StringDelegate implements FutureDelegate<String> {
  const StringDelegate();
  @override
  Future<String> call() async {
    return 'String';

    /// ... returns a string at some point, not important now
  }
}

final stringProvider = FutureProvider<String>((ref) => k_STRING_DELEGATE());

class MockDelegate extends Fake implements FutureDelegate<String> {
  @override
  Future<String> call() async {
    throw NullThrownError;
  }
}

void main() {
  group('`stringProvider`', () {
    final _delegate = MockDelegate();
    test('WHEN `delegate` throws THEN `provider`return exception', () async {
      /* when(_delegate.call()).thenAnswer((_) async {
        //await Future.delayed(const Duration(seconds: 1));
        return 'NullThrownError';
      }); */

      /* when(_delegate.call()).thenThrow((_) async {
        return Future.delayed(const Duration(seconds: 5), () => NullThrownError);
        //return NullThrownError();
      }); */

      final container = ProviderContainer(
        overrides: [
          stringProvider
              .overrideWithProvider(FutureProvider((ref) => _delegate.call()))
        ],
      );

      /* expect(
        container.read(stringProvider),
        const AsyncValue<String>.loading(),
      ); */

      expect(
          container.read(stringProvider), const AsyncValue<String>.loading());

      container.read(stringProvider).data.value;

      await Future<void>.value();
      expect(container.read(stringProvider), isA<AsyncError>());
    });
  });
}
