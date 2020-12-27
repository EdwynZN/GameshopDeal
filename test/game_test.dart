import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

const dioHttpHeadersForResponseBody = {
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

void main() {
  group('Testing Game:', () {
    final Dio dio = Dio();
    DioAdapterMock dioAdapterMock;
    DiscountApi cheapShark;

    setUpAll(() {
      dioAdapterMock = DioAdapterMock();
      dio.httpClientAdapter = dioAdapterMock;
      cheapShark = DiscountApi(dio);
    });

    test('List of Games Mocking Retrofit', () async {
      final file = File('test_resources/list_of_games.json');
      final httpResponse = ResponseBody.fromString(
        file.readAsStringSync(),
        200,
        headers: dioHttpHeadersForResponseBody,
      );

      when(dioAdapterMock.fetch(any, any, any))
        .thenAnswer((_) async => httpResponse);

      final games = await cheapShark.getGames({});

      expect(games.length, 1);
      expect(games.first.external,
        'Batman: Arkham Asylum Game of the Year Edition');
      expect(games.first.internalName,
        'BATMANARKHAMASYLUMGAMEOFTHEYEAREDITION');
      expect(games.first.gameId, '146');
      expect(games.first.steamAppId, '35140');
      expect(games.first.cheapest, "4.99");
      expect(games.first.cheapestDealId,
        "VVYUpHqeVVgSdqLIctNxMuqfVwMoNckTxOgu%2F%2FkbPO8%3D");
      expect(games.first.thumb,
        "https://cdn.cloudflare.steamstatic.com/steam/apps/35140/capsule_sm_120.jpg?t=1569358035");
    });

    test('Game Lookup ID Mocking Retrofit', () async {
      final file = File('test_resources/game_lookup.json');
      final httpResponse = ResponseBody.fromString(
        file.readAsStringSync(),
        200,
        headers: dioHttpHeadersForResponseBody,
      );

      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final games = await cheapShark.getGamesById('612');

      expect(games.info.title, 'LEGO Batman');
      expect(games.info.steamAppId, '21000');
      expect(games.cheapestPrice.price, '3.99');
      expect(games.cheapestPrice.date, 1543028665);
      expect(games.deals.length, 7);
      expect(games.deals.map((e) => e.storeId),
          containsAllInOrder(['23', '21', '28', '24', '15', '8', '29']));
    });

    test('Game Lookup ID Real Retrofit', () async {
      final DiscountApi cheapShark = DiscountApi(Dio());
      final games = await cheapShark.getGamesById('612');

      expect(games.info.title, 'LEGO Batman');
    }, skip: 'Only active if the API changes');

    test('Multiple IDs Mocking Retrofit', () async {
      final file = File('test_resources/multiple_game_lookup.json');
      final ids = const <String>{'128', '129', '130'};
      final httpResponse = ResponseBody.fromString(
        file.readAsStringSync(),
        200,
        headers: dioHttpHeadersForResponseBody,
      );

      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final value = await cheapShark.getGamesByMultipleId(ids.join(','));

      expect(value.keys, containsAll(ids));
      expect(value['130'].info.title, "Renegade Ops");
    });

    test('Multiple IDs Real Retrofit', () async {
      final DiscountApi cheapShark = DiscountApi(Dio());
      final ids = const <String>{'128', '129', '130'};
      final value = await cheapShark.getGamesByMultipleId(ids.join(','));

      expect(value.keys, containsAll(ids));
      expect(value.keys.length, 3);
      expect(value['130'].info.title, "Renegade Ops");
    }, skip: 'Only active if the API changes');

    tearDownAll(() {
      dio?.close();
    });
  });
}
