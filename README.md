# Gameshop Deals [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

<p align='left'>
    <a href='https://play.google.com/store/apps/details?id=com.dartz.gameshop_deals'>
       <img height="56" alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' />
    </a>
</p>

[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/N4N8169NZ)

**Or you can [donate on PayPal](https://paypal.me/EdwynZN)**

Browse through different shops and find the best deals of the games you want!

Features:
- Infinite scrolling, as long as there are deals, they will be fetched, the sky is the limit
- Filter by:
    - **Ascending** and **Descending** order
    - **SteamWorks** (games that are registered in steam, regardless the store), **Retail Discount** (games with a retail price **< $29**) and **On Sale** only
    - **Deal Rating** (from 0 to 10, factors reviews, price, saving etc.), **Title**, **Savings**, **Price**, **Metacritic**, **Reviews**, **Release** (release date of the game), **Store** and **Recent** (How recent a deal was found by CheapShark, not confuse with release date)
    - Metacritic Score, Price Range or Steam Rating
    - Search across multiple stores or select only the one you want
- Create a custom filter and save it to start the app with it always, useful if you're only interested in particular stores or deals
- Light and Dark Theme
- Multiple views:
    - **List**, **Compact**, **Grid** and **Detail** to show the deals arranged in the screen
        - Tap to visualize a page with all the information related with that deal
        - Long Press to select what you want to do with that deal:
            - Metacritic page (if available)
            - PCWiki (if available)
            - Steam reviews (if available)
            - Go to the deal website
            - Save the game in your personal list (notifications coming soon)
    - **Swipe** to see all the information related of an specific deal in a page, including visualization of the same deal in multiple stores to compare prices
- Search by name, with filter availability specific to that search, so each search can be unique


##### [Powered by CheapShark](https://www.cheapshark.com/)

## Screenshots

<img src="screenshots/home.png" height="350">  <img src="screenshots/dark_home.png" height="350">
<img src="screenshots/detail.png" height="350">  <img src="screenshots/filter.png" height="350">
<img src="screenshots/saved_games.png" height="350">  <img src="screenshots/view.png" height="350">
<img src="screenshots/deal_buttons.png" height="350">

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

##### STEP 1

go to [android/app/build.gradle](android/app/build.gradle) and comment (or delete) signingConfigs (unless you have your own keys to publish apps in google play store, in that case just save it as key.properties in the android folder)

```
/// line 55 comment or delete this block
*/signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}/*

/// return to debug mode and clear all other properties (minify, etc.)
buildTypes {
    release {
        // TODO: Add your own signing config for the release build.
        // Signing with the debug keys for now, so `flutter run --release` works.
        signingConfig signingConfigs.debug
    }
}

You can also delete line 28-33 if you're not interested in using key.properties to build your app
*/def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}/*
```

##### STEP 2

Run `flutter pub get` and `flutter pub run build_runner build` to generate all `.g.dart files`. Once generated you can run the app and it will show no error but actually the generator have an inconveninence when creating `Set()` (It creates them as `List()` with the Hive adapter, there will be no warning or lint error, but it will crash the app when finally uses it) in the models, specifically `filter` and `price_alert` models.

Go to [model](/lib/model) and localize `filter.g.dart` and `price_alert.g.dart` (after running build_runner)

In `filter.g.dart` line 20 and 28 add `.toSet()` at the end of the line:

```
line 20: storeId: (fields[0] as List)?.cast<String>().toSet(),
line 28: steamAppId: (fields[8] as List)?.cast<String>().toSet(),
```

In `price_alert.g.dart` line 21 add `.toSet()` at the en of the line:

`line 21: storeId: (fields[1] as List)?.cast<String>().toSet(),`

###### You're now ready to try the app and build your app