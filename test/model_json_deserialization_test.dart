import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/deal_lookup.dart';
import 'package:gameshop_deals/model/game.dart';
import 'package:gameshop_deals/model/store.dart';

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

      final List<Game> games = await cheapShark.getGames({});

      expect(games.length, 1);
      expect(games.first.externalName,
          'Batman: Arkham Asylum Game of the Year Edition');
      expect(
          games.first.internalName, 'BATMANARKHAMASYLUMGAMEOFTHEYEAREDITION');
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
      expect(games.deals.map((e) => e.storeId).toList(),
          containsAllInOrder(['23', '21', '28', '24', '15', '8', '29']));
      expect(
          games.deals.map((e) => e.salePrice).toList(),
          containsAllInOrder(
              ['4.23', '4.59', '5.00', '17.99', '19.99', '19.99', '19.99']));
      expect(
          games.deals.map((e) => e.normalPrice).toList(),
          containsAllInOrder(
              ['19.99', '19.99', '19.99', '19.99', '19.99', '19.99', '19.99']));
      expect(
          games.deals.map((e) => e.dealId).toList(),
          containsAllInOrder([
            'tyTH88J0PXRvYALBjV3cNHd5Juq1qKcu4tG4lBiUCt4%3D',
            'Dtzv5PHBf71720cIYjxx3oHvvZK3iHUbQjv6fWLVpd8%3D',
            'atibivJQyXsOousolMoHm2iwPKyZaYMxbJ0sR0030M4%3D',
            'gxfmQjEJ%2Fk7JylG%2FKYHcmK4RcZY51YLVWfGF4CRkPIY%3D',
            '2G7cvZxDvSCoqSOpvARBvMXuwrA70L3j1%2FelPGxhddw%3D',
            'S8sC6rS2qZS5e0tROfV8hBgYeJPbG1T61BNmcz5Z%2BwE%3D',
            '%2B7VX8im%2FkdTZIoOpHzeQ0X3roxf655hXC6oq6iruQCM%3D'
          ]));
      expect(games.deals.map((e) => e.savings).toList(),
          containsAllInOrder([79, 77, 75, 10, 0, 0, 0]));
      expect(games.deals.map((e) => e.isOnSale).toList(),
          containsAllInOrder(List.filled(7, null)));
    });

    test('Game Lookup ID Real Retrofit', () async {
      final DiscountApi cheapShark = DiscountApi(Dio());
      final games = await cheapShark.getGamesById('612');

      expect(games.info.title, 'LEGO Batman');
    }, skip: 'Real Retrofit: Only active if the API changes');

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
      expect(value['128'].info.title, "BioShock");
      expect(value['128'].deals.length, 8);
      expect(value['129'].info.title, "Red Orchestra 2: Heroes of Stalingrad");
      expect(value['129'].deals.length, 2);
      expect(value['130'].info.title, "Renegade Ops");
      expect(value['130'].deals.length, 1);
    });

    test('Multiple IDs Real Retrofit', () async {
      final DiscountApi cheapShark = DiscountApi(Dio());
      final ids = const <String>{'128', '129', '130'};
      final value = await cheapShark.getGamesByMultipleId(ids.join(','));

      expect(value.keys, containsAll(ids));
      expect(value.keys.length, 3);
      expect(value['130'].info.title, "Renegade Ops");
    }, skip: 'Real Retrofit: Only active if the API changes');

    tearDownAll(() {
      dio?.close();
    });
  });

  group('Testing Deal:', () {
    final Dio dio = Dio();
    DioAdapterMock dioAdapterMock;
    DiscountApi cheapShark;

    setUpAll(() {
      dioAdapterMock = DioAdapterMock();
      dio.httpClientAdapter = dioAdapterMock;
      cheapShark = DiscountApi(dio);
    });

    test('List of Deals Mocking Retrofit', () async {
      final file = File('test_resources/deal_response.json');
      final httpResponse = ResponseBody.fromString(
        file.readAsStringSync(),
        200,
        headers: dioHttpHeadersForResponseBody,
      );

      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final deals = await cheapShark.getDeals();

      expect(deals, hasLength(60));
      final deal = deals.last;

      Deal actualDeal = Deal(
        internalName: "REDSHARK",
        title: "Red Shark",
        dealId: "zqu%2Fw8yODmBipd7q%2B7vB3pfClljmES%2FZNB5iaQYe8Kw%3D",
        storeId: '2',
        gameId: '2842',
        salePrice: "1.99",
        normalPrice: "9.95",
        isOnSale: '1',
        savings: 80,
        metacriticScore: '76',
        steamRatingCount: '0',
        steamRatingPercent: '0',
        releaseDate: 0,
        lastChange: 1534989345,
        dealRating: '8.2',
        thumb:
            "https://www.gamersgate.com/media/products/profile/89158/180_259.jpg/w90/",
      );

      expect(
        deal,
        isA<Deal>()
          .having((d) => d.internalName, 'internalName', equals("REDSHARK"))
          .having((d) => d.title, 'title', equals("Red Shark"))
          .having((d) => d.metacriticLink, 'metacriticLink', isNull)
          .having(
              (d) => d.dealId,
              'dealId',
              equals(
                  "zqu%2Fw8yODmBipd7q%2B7vB3pfClljmES%2FZNB5iaQYe8Kw%3D"))
          .having((d) => d.storeId, 'storeId', equals("2"))
          .having((d) => d.gameId, 'gameId', equals("2842"))
          .having((d) => d.salePrice, 'salePrice', equals("1.99"))
          .having((d) => d.normalPrice, 'normalPrice', equals("9.95"))
          .having((d) => d.isOnSale, 'isOnSale', equals("1"))
          .having((d) => d.metacriticScore, 'metacriticScore', equals("76"))
          .having((d) => d.steamRatingText, 'steamRatingText', isNull)
          .having((d) => d.steamRatingPercent, 'steamRatingPercent',
              equals("0"))
          .having(
              (d) => d.steamRatingCount, 'steamRatingCount', equals("0"))
          .having((d) => d.steamAppId, 'steamAppId', isNull)
          .having((d) => d.releaseDate, 'releaseDate', equals(0))
          .having((d) => d.lastChange, 'lastChange', equals(1534989345))
          .having((d) => d.dealRating, 'dealRating', equals("8.2"))
          .having(
            (d) => d.thumb,'thumb',
            equals(
              "https://www.gamersgate.com/media/products/profile/89158/180_259.jpg/w90/"),
          ),
      );

      expect(deal, actualDeal);
    });

    test('Deal Lookup ID Mocking Retrofit', () async {
      final file = File('test_resources/deal_lookup_response.json');
      final httpResponse = ResponseBody.fromString(
        file.readAsStringSync(),
        200,
        headers: dioHttpHeadersForResponseBody,
      );

      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final dealLookup = await cheapShark
          .getDealsById('X8sebHhbc1Ga0dTkgg59WgyM506af9oNZZJLU9uSrX8%3D');

      expect(
        dealLookup,
        isA<DealLookup>()
          .having((d) => d.deal.storeId, 'storeId', equals("1"))
          .having((d) => d.deal.gameId, 'gameId', equals("93503"))
          .having((d) => d.deal.title, 'title', equals("BioShock Infinite"))
          .having((d) => d.deal.steamAppId, 'steamAppId', equals("8870"))
          .having((d) => d.deal.salePrice, 'salePrice', equals("7.49"))
          .having(
            (d) => d.deal.normalPrice, 'normalPrice', equals("29.99"))
          .having((d) => d.deal.steamRatingText, 'steamRatingText',
            equals("Overwhelmingly Positive"))
          .having((d) => d.deal.steamRatingPercent, 'steamRatingPercent',
            equals("95"))
          .having((d) => d.deal.steamRatingCount, 'steamRatingCount',
            equals("52167"))
          .having(
            (d) => d.deal.releaseDate, 'releaseDate', equals(1364169600))
          .having((d) => d.deal.metacriticLink, 'metacriticLink',
            equals("/game/pc/bioshock-infinite"))
          .having((d) => d.deal.metacriticScore, 'metacriticScore',
            equals("94"))
          .having((d) => d.deal.thumb,'thumb',
            equals(
              "https://steamcdn-a.akamaihd.net/steam/apps/8870/capsule_sm_120.jpg?t=1534538071"))
          .having((d) => d.cheaperStores, 'CheapestStore', isEmpty)
          .having((d) => d.cheapestPrice.price, 'CheapestPrice', equals('5.90'))
          .having((d) => d.cheapestPrice.date, 'date', equals(1528368365)));
    });

    test('Deal Lookup ID Real Retrofit', () async {
      final DiscountApi cheapShark = DiscountApi(Dio());
      final dealLookup = await cheapShark
          .getDealsById('X8sebHhbc1Ga0dTkgg59WgyM506af9oNZZJLU9uSrX8%3D');

      expect(dealLookup, isA<DealLookup>());
    }, skip: 'Real Retrofit: Only active if the API changes');

    tearDownAll(() {
      dio?.close();
    });
  });

  group('Testing Store:', () {
    final Dio dio = Dio();
    DioAdapterMock dioAdapterMock;
    DiscountApi cheapShark;

    setUpAll(() {
      dioAdapterMock = DioAdapterMock();
      dio.httpClientAdapter = dioAdapterMock;
      cheapShark = DiscountApi(dio);
    });

    test('Store Mocking Retrofit', () async {
      final file = File('test_resources/store_response.json');
      final httpResponse = ResponseBody.fromString(
        file.readAsStringSync(),
        200,
        headers: dioHttpHeadersForResponseBody,
      );

      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final stores = await cheapShark.getStores(RequestOptions());

      expect(stores, hasLength(24));

      expect(stores.last,
        isA<Store>()
          .having((s) => s.storeId, 'storeId', equals("24"))
          .having((d) => d.storeName, 'storeName', equals("Voidu"))
          .having((d) => d.isActive, 'isActive', isTrue)
          .having((s) => s.images.banner, 'banner', equals("/img/stores/banners/23.png"))
          .having((d) => d.images.logo, 'logo', equals("/img/stores/logos/23.png"))
          .having((d) => d.images.icon, 'icon', equals("/img/stores/icons/23.png"))
      );
    });

    tearDownAll(() {
      dio?.close();
    });
  });
}
