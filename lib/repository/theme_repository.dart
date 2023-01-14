import 'package:flutter/material.dart';
import 'package:gameshop_deals/utils/theme_constants.dart';

abstract class ThemeRepository {
  Color _darkAccentColor;
  TextTheme _darkAccentTextTheme = const TextTheme(
    subtitle1: TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.15),
    subtitle2: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1),
    bodyText1: TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5),
    bodyText2: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25),
    overline: TextStyle(
        color: Colors.black87,
        fontSize: 11,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.0,
        height: 1.5),
    button: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25),
    headline1: TextStyle(
        color: Colors.black87,
        fontSize: 28,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5),
    headline2: TextStyle(
        color: Colors.black87,
        fontSize: 26,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5),
    headline3: TextStyle(
        color: Colors.black87, fontSize: 22, fontWeight: FontWeight.normal),
    headline4: TextStyle(
        color: Colors.black87,
        fontSize: 21,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25),
    headline5: TextStyle(
        color: Colors.black87, fontSize: 20, fontWeight: FontWeight.normal),
    headline6: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15),
  );
  TextTheme _lightAccentTextTheme = const TextTheme(
    subtitle1: TextStyle(
        color: Colors.white70,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.15),
    subtitle2: TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1),
    bodyText1: TextStyle(
        color: Colors.white70,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5),
    bodyText2: TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25),
    overline: TextStyle(
        color: Colors.white70,
        fontSize: 11,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.0,
        height: 1.5),
    button: TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25),
    headline1: TextStyle(
        color: Colors.white70,
        fontSize: 28,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5),
    headline2: TextStyle(
        color: Colors.white70,
        fontSize: 26,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5),
    headline3: TextStyle(
        color: Colors.white70, fontSize: 22, fontWeight: FontWeight.normal),
    headline4: TextStyle(
        color: Colors.white70,
        fontSize: 21,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25),
    headline5: TextStyle(
        color: Colors.white70, fontSize: 20, fontWeight: FontWeight.normal),
    headline6: TextStyle(
        color: Colors.white70,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15),
  );

  ThemeData get light;
  ThemeData get dark;
}

class ThemeImpl extends ThemeRepository {
  ThemeData _lightTheme;
  ThemeData _darkTheme;

  ThemeImpl() {
    setLight = 0;
    setDark = 1;
  }

  set setLight(int light) {
    MaterialColor color = lightColor;
    MaterialAccentColor accentColor = lightAccentColor;
    _darkAccentColor = accentColor[700];
    final Brightness _brightnessColor =
        ThemeData.estimateBrightnessForColor(color);
    final Brightness _brightnessAccentColor =
        ThemeData.estimateBrightnessForColor(accentColor);
    final Brightness _brightnessPrimaryColor =
        ThemeData.estimateBrightnessForColor(accentColor[100]);
    final Brightness _brightnessAccentTextTheme =
        ThemeData.estimateBrightnessForColor(accentColor[700]);
    _lightTheme = ThemeData(
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        // TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      //splashFactory: InkRipple.splashFactory,
      primaryColorBrightness: _brightnessPrimaryColor,
      primaryColorLight: accentColor[100],
      primaryColorDark: accentColor[600],
      primaryIconTheme: const IconThemeData(color: Colors.black),
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        brightness: _brightnessColor,
        elevation: 0.0,
        color: color,
        textTheme: _brightnessColor == Brightness.light
            ? _darkAccentTextTheme
            : _darkAccentTextTheme.apply(
                bodyColor: Colors.white, displayColor: Colors.white),
        iconTheme: IconThemeData(
          color:
              _brightnessColor == Brightness.dark ? Colors.white : Colors.black,
        ),
      ),
      unselectedWidgetColor: Colors.black87,
      dividerColor: color,
      dividerTheme: DividerThemeData(
        color: color,
        space: 1.0,
        thickness: 1.0,
      ),
      scaffoldBackgroundColor: Colors.grey[300],
      accentColor: accentColor[700],
      accentIconTheme: IconThemeData(
          color: _brightnessAccentTextTheme == Brightness.dark
              ? Colors.white
              : Colors.black),
      accentColorBrightness: _brightnessAccentColor,
      iconTheme: const IconThemeData(color: Colors.black),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: _brightnessAccentColor == Brightness.dark
              ? Colors.white
              : Colors.black, //Colors.white,
          backgroundColor: accentColor),
      errorColor: Colors.redAccent,
      canvasColor: Colors.grey[300],
      primarySwatch: color,
      primaryColor: color,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white10,
        selectionHandleColor: color[300],
        selectionColor: accentColor.withOpacity(0.5),
      ),
      backgroundColor: color[100],
      selectedRowColor: color[200],
      cardColor: Colors.grey[300],
      cardTheme: CardTheme(
        color: Colors.grey[300],
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 8,
      ),
      textTheme: _darkAccentTextTheme,
      primaryTextTheme: _brightnessPrimaryColor == Brightness.dark
          ? _lightAccentTextTheme
          : _darkAccentTextTheme,
      accentTextTheme: _lightAccentTextTheme.apply(
        displayColor: _brightnessAccentTextTheme == Brightness.dark
            ? Colors.white
            : Colors.black,
        bodyColor: _brightnessAccentTextTheme == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      bottomAppBarTheme:
          BottomAppBarTheme(color: Colors.transparent, elevation: 0.0),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.grey[300],
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: accentColor[700])),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: color[100],
        contentTextStyle: TextStyle(color: Colors.black),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: accentColor)),
        behavior: SnackBarBehavior.floating,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        mouseCursor: MaterialStateProperty.all<MouseCursor>(
            MaterialStateMouseCursor.clickable),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 8.0)),
        //enableFeedback: false,
        shape:
            MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder()),
        side: MaterialStateProperty.all<BorderSide>(BorderSide(
          color: accentColor[700],
          width: 1,
        )),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color>(
            _brightnessAccentColor == Brightness.dark
                ? accentColor[700]
                : Colors.black),
      )),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        mouseCursor: MaterialStateProperty.all<MouseCursor>(
            MaterialStateMouseCursor.clickable),
        //enableFeedback: false,
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color>(
            _brightnessAccentColor == Brightness.dark
                ? accentColor[700]
                : Colors.black),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              mouseCursor: MaterialStateProperty.all<MouseCursor>(
                  MaterialStateMouseCursor.clickable),
              //enableFeedback: false,
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              elevation: MaterialStateProperty.resolveWith<double>((states) {
                if (states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.disabled)) return 2.0;
                return 8.0;
              }),
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) return null;
                return color[100];
              }),
              // backgroundColor: MaterialStateProperty.all<Color>(color[100]),
              foregroundColor: MaterialStateProperty.all<Color>(
                  _darkAccentTextTheme.headline1.color),
              //textStyle: MaterialStateProperty.all<TextStyle>(_darkAccentTextTheme.bodyText1),
              overlayColor: MaterialStateProperty.all<Color>(
                  _darkAccentColor.withOpacity(0.24)),
              visualDensity: VisualDensity(vertical: 1))),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        layoutBehavior: ButtonBarLayoutBehavior.constrained,
        buttonColor: color[100],
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: 48,
        highlightColor: color[200],
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
        modalBackgroundColor: Colors.grey[300],
        modalElevation: 8.0,
      ),
      chipTheme: ChipThemeData(
          checkmarkColor: _brightnessPrimaryColor == Brightness.dark
              ? Colors.white70
              : Colors.black87,
          backgroundColor: Colors.black12,
          deleteIconColor: Colors.black87,
          disabledColor: Colors.black.withAlpha(0x0c),
          selectedColor: color[100],
          secondarySelectedColor: color[100],
          labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          padding: const EdgeInsets.all(4.0),
          labelStyle: _darkAccentTextTheme.bodyText2,
          secondaryLabelStyle: _darkAccentTextTheme.bodyText2.apply(
              color: _brightnessColor == Brightness.light ? null : color[500]),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          brightness: _brightnessColor),
      navigationRailTheme: NavigationRailThemeData(
          labelType: NavigationRailLabelType.selected,
          backgroundColor: color[50],
          elevation: 8.0,
          groupAlignment: 1.0,
          selectedIconTheme: IconThemeData(color: accentColor[700]),
          selectedLabelTextStyle: _lightAccentTextTheme.bodyText2.apply(
              color: _brightnessAccentTextTheme == Brightness.dark
                  ? accentColor[700]
                  : Colors.black),
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          unselectedLabelTextStyle: _darkAccentTextTheme.bodyText2),
      toggleableActiveColor: accentColor[700],
      indicatorColor: color[100],
      buttonColor: color[100],
    );
  }

  set setDark(int dark) {
    dark ??= 2;
    final Brightness _brightness = Brightness.dark;
    final Color _accentColor =
        _brightness == Brightness.dark ? Colors.white : Colors.black;
    final Brightness _brightnessAccentColor =
        ThemeData.estimateBrightnessForColor(_darkAccentColor);
    switch (dark) {
      case 0:
        _darkTheme = ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            // TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          splashFactory: InkRipple.splashFactory,
          primaryColorLight: Colors.blueGrey[800],
          primaryColorDark: Colors.blueGrey[900],
          appBarTheme: AppBarTheme(
            brightness: _brightness,
            elevation: 0.0,
            color: Colors.blueGrey[900],
            textTheme: _lightAccentTextTheme.apply(),
            iconTheme: const IconThemeData(color: Colors.white70),
          ),
          brightness: Brightness.dark,
          unselectedWidgetColor: Colors.white70,
          dividerColor: Colors.blueGrey[700],
          scaffoldBackgroundColor: Colors.blueGrey[900],
          accentColor: _darkAccentColor,
          accentIconTheme: IconThemeData(color: _accentColor),
          accentColorBrightness: _brightness,
          primaryIconTheme: const IconThemeData(color: Colors.white70),
          iconTheme: const IconThemeData(color: Colors.white70),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: _accentColor,
            backgroundColor: _darkAccentColor,
          ),
          errorColor: Color.fromRGBO(207, 102, 121, 1),
          canvasColor: Colors.blueGrey[900],
          primarySwatch: Colors.blueGrey,
          primaryColor: Colors.blueGrey[900],
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white10,
            selectionHandleColor: _darkAccentColor,
            selectionColor: _darkAccentColor.withOpacity(0.5),
          ),
          backgroundColor: Colors.blueGrey[800],
          selectedRowColor: Colors.blueGrey[700],
          cardColor: Colors.blueGrey[800],
          cardTheme: CardTheme(
            color: Colors.blueGrey[800],
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 8,
          ),
          textTheme: _lightAccentTextTheme,
          primaryTextTheme: _lightAccentTextTheme,
          accentTextTheme: _brightness == Brightness.dark
              ? _lightAccentTextTheme
              : _darkAccentTextTheme,
          bottomAppBarTheme:
              BottomAppBarTheme(color: Colors.transparent, elevation: 0.0),
          dialogTheme: DialogTheme(
            backgroundColor: Colors.blueGrey[900],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          popupMenuTheme: PopupMenuThemeData(
            color: Colors.blueGrey[900],
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: _darkAccentColor)),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.blueGrey[800],
            contentTextStyle: TextStyle(color: Colors.white70),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side:
                    BorderSide(color: const Color.fromRGBO(207, 102, 121, 1))),
            behavior: SnackBarBehavior.floating,
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
            mouseCursor: MaterialStateProperty.all<MouseCursor>(
                MaterialStateMouseCursor.clickable),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 8.0)),
            //enableFeedback: false,
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder()),
            side: MaterialStateProperty.all<BorderSide>(BorderSide(
              color: _darkAccentColor,
              width: 1,
            )),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color>(_darkAccentColor),
          )),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
            mouseCursor: MaterialStateProperty.all<MouseCursor>(
                MaterialStateMouseCursor.clickable),
            //enableFeedback: false,
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color>(_darkAccentColor),
            overlayColor: MaterialStateProperty.all<Color>(
                _darkAccentColor.withOpacity(0.24)),
          )),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  mouseCursor: MaterialStateProperty.all<MouseCursor>(
                      MaterialStateMouseCursor.clickable),
                  //enableFeedback: false,
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  elevation:
                      MaterialStateProperty.resolveWith<double>((states) {
                    if (states.contains(MaterialState.pressed) ||
                        states.contains(MaterialState.disabled)) return 0.0;
                    return 8.0;
                  }),
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) return null;
                    return Colors.blueGrey[800];
                  }),
                  // backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[800]),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      _lightAccentTextTheme.headline1.color),
                  //textStyle: MaterialStateProperty.all<TextStyle>(_lightAccentTextTheme.bodyText1),
                  overlayColor: MaterialStateProperty.all<Color>(
                      _darkAccentColor.withOpacity(0.24)),
                  visualDensity: VisualDensity(vertical: 1))),
          buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.normal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              layoutBehavior: ButtonBarLayoutBehavior.constrained,
              buttonColor: Colors.grey[900],
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              height: 48),
          bottomSheetTheme: BottomSheetThemeData(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
          ),
          chipTheme: ChipThemeData(
              checkmarkColor: _brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black87,
              backgroundColor: Colors.white12,
              deleteIconColor: Colors.white70,
              disabledColor: Colors.white.withAlpha(0x0C),
              selectedColor: _darkAccentColor.withAlpha(0xFC), //Colors.white24,
              secondarySelectedColor: _darkAccentColor.withAlpha(0xFC),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              padding: const EdgeInsets.all(4.0),
              labelStyle: _lightAccentTextTheme.bodyText2,
              secondaryLabelStyle: _brightness == Brightness.dark
                  ? _lightAccentTextTheme.bodyText2
                  : _darkAccentTextTheme.bodyText2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              brightness: _brightness),
          navigationRailTheme: NavigationRailThemeData(
              labelType: NavigationRailLabelType.selected,
              backgroundColor: Colors.blueGrey[800],
              elevation: 8.0,
              groupAlignment: 1.0,
              selectedIconTheme: IconThemeData(color: _darkAccentColor),
              selectedLabelTextStyle: _lightAccentTextTheme.bodyText2
                  .apply(color: _darkAccentColor),
              unselectedIconTheme: const IconThemeData(color: Colors.white70),
              unselectedLabelTextStyle: _lightAccentTextTheme.bodyText2),
          sliderTheme: SliderThemeData(
            valueIndicatorColor: Color.alphaBlend(
                _darkAccentColor.withOpacity(0.36),
                _darkAccentColor.withAlpha(0xFC)),
            valueIndicatorTextStyle: _brightness == Brightness.dark
                ? _lightAccentTextTheme.bodyText1
                : _darkAccentTextTheme.bodyText1,
          ),
          toggleableActiveColor: _darkAccentColor,
          indicatorColor: Colors.blueGrey[700],
          buttonColor: Colors.blueGrey[800],
        );
        break;
      case 1:
        _darkTheme = ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            // TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          splashFactory: InkRipple.splashFactory,
          primaryColorLight: Colors.grey[850],
          primaryColorDark: Colors.grey[900],
          appBarTheme: AppBarTheme(
            brightness: _brightness,
            elevation: 0.0,
            color: Colors.grey[900],
            textTheme: _lightAccentTextTheme,
            iconTheme: const IconThemeData(color: Colors.white70),
          ),
          brightness: Brightness.dark,
          unselectedWidgetColor: Colors.white70,
          dividerColor: _darkAccentColor.withOpacity(0.75),
          dividerTheme: DividerThemeData(
            color: _darkAccentColor.withOpacity(0.75),
            space: 1.0,
            thickness: 1.0,
          ),
          scaffoldBackgroundColor: Colors.grey[900],
          accentColor: _darkAccentColor,
          accentIconTheme: IconThemeData(color: _accentColor),
          //accentColorBrightness: _brightnessAccentColor,
          primaryIconTheme: const IconThemeData(color: Colors.white70),
          iconTheme: const IconThemeData(color: Colors.white70),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: _accentColor,
            backgroundColor: _darkAccentColor,
          ),
          errorColor: Color.fromRGBO(207, 102, 121, 1),
          canvasColor: Colors.grey[900],
          primarySwatch: Colors.grey,
          primaryColor: Colors.grey[900],
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white10,
            selectionHandleColor: _darkAccentColor,
            selectionColor: _darkAccentColor.withOpacity(0.5),
          ),
          backgroundColor: Colors.grey[850],
          selectedRowColor: Colors.grey[800],
          cardColor: Colors.grey[850],
          cardTheme: CardTheme(
            color: Colors.grey[850],
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 8,
          ),
          textTheme: _lightAccentTextTheme,
          primaryTextTheme: _lightAccentTextTheme,
          accentTextTheme: _lightAccentTextTheme.apply(
            displayColor: _brightnessAccentColor == Brightness.dark
                ? Colors.white
                : Colors.black,
            bodyColor: _brightnessAccentColor == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          bottomAppBarTheme:
              BottomAppBarTheme(color: Colors.transparent, elevation: 0.0),
          dialogTheme: DialogTheme(
            backgroundColor: Colors.grey[900],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          popupMenuTheme: PopupMenuThemeData(
            color: Colors.grey[900],
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: _darkAccentColor)),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.grey[800],
            contentTextStyle: TextStyle(color: Colors.white70),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side:
                    BorderSide(color: const Color.fromRGBO(207, 102, 121, 1))),
            behavior: SnackBarBehavior.floating,
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
            mouseCursor: MaterialStateProperty.all<MouseCursor>(
                MaterialStateMouseCursor.clickable),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 8.0)),
            //enableFeedback: false,
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder()),
            side: MaterialStateProperty.all<BorderSide>(BorderSide(
              color: _darkAccentColor,
              width: 1,
            )),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color>(_darkAccentColor),
          )),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
            mouseCursor: MaterialStateProperty.all<MouseCursor>(
                MaterialStateMouseCursor.clickable),
            //enableFeedback: false,
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color>(_darkAccentColor),
            overlayColor: MaterialStateProperty.all<Color>(
                _darkAccentColor.withOpacity(0.24)),
          )),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  mouseCursor: MaterialStateProperty.all<MouseCursor>(
                      MaterialStateMouseCursor.clickable),
                  //enableFeedback: false,
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  elevation:
                      MaterialStateProperty.resolveWith<double>((states) {
                    if (states.contains(MaterialState.pressed) ||
                        states.contains(MaterialState.disabled)) return 2.0;
                    return 8.0;
                  }),
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) return null;
                    return Colors.grey[800];
                  }),
                  // backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[800]),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      _lightAccentTextTheme.headline1.color),
                  //textStyle: MaterialStateProperty.all<TextStyle>(_lightAccentTextTheme.bodyText1),
                  overlayColor: MaterialStateProperty.all<Color>(
                      _darkAccentColor.withOpacity(0.24)),
                  visualDensity: VisualDensity(vertical: 1))),
          buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.normal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              layoutBehavior: ButtonBarLayoutBehavior.constrained,
              buttonColor: Colors.grey[900],
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              height: 48),
          bottomSheetTheme: BottomSheetThemeData(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            modalBackgroundColor: Colors.grey[900],
            modalElevation: 8.0,
          ),
          chipTheme: ChipThemeData(
              checkmarkColor: _brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black87,
              backgroundColor: Colors.white12,
              deleteIconColor: Colors.white70,
              disabledColor: Colors.white.withAlpha(0x0C),
              selectedColor: _darkAccentColor.withAlpha(0xFC), //Colors.white24,
              secondarySelectedColor: _darkAccentColor.withAlpha(0xFC),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              padding: const EdgeInsets.all(4.0),
              labelStyle: _lightAccentTextTheme.bodyText2,
              secondaryLabelStyle: _brightness == Brightness.dark
                  ? _lightAccentTextTheme.bodyText2
                  : _darkAccentTextTheme.bodyText2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              brightness: _brightness),
          navigationRailTheme: NavigationRailThemeData(
              labelType: NavigationRailLabelType.selected,
              backgroundColor: Colors.grey[850],
              elevation: 8.0,
              groupAlignment: 1.0,
              selectedIconTheme: IconThemeData(color: _darkAccentColor),
              unselectedIconTheme: const IconThemeData(color: Colors.white70),
              selectedLabelTextStyle: _lightAccentTextTheme.bodyText2
                  .apply(color: _darkAccentColor),
              unselectedLabelTextStyle: _lightAccentTextTheme.bodyText2),
          sliderTheme: SliderThemeData(
            valueIndicatorColor: Color.alphaBlend(
                _darkAccentColor.withOpacity(0.36),
                _darkAccentColor.withAlpha(0xFC)),
            valueIndicatorTextStyle: _brightness == Brightness.dark
                ? _lightAccentTextTheme.bodyText1
                : _darkAccentTextTheme.bodyText1,
          ),
          toggleableActiveColor: _darkAccentColor,
          indicatorColor: Colors.grey[700],
          buttonColor: Colors.grey[850],
        );
        break;
      case 2:
      default:
        _darkTheme = ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            // TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          splashFactory: InkRipple.splashFactory,
          primaryColorLight:
              Colors.transparent, //_darkAccentColor.withOpacity(0.55),
          primaryColorDark: _darkAccentColor,
          appBarTheme: AppBarTheme(
            brightness: _brightness,
            elevation: 0.0,
            color: Colors.black,
            textTheme: _lightAccentTextTheme.apply(),
            iconTheme: const IconThemeData(color: Colors.white70),
          ),
          brightness: Brightness.dark,
          unselectedWidgetColor: Colors.white70,
          dividerColor: Colors.grey[800],
          scaffoldBackgroundColor: Colors.black,
          accentColor: _darkAccentColor,
          accentIconTheme: IconThemeData(color: _accentColor),
          accentColorBrightness: _brightness,
          primaryIconTheme: const IconThemeData(color: Colors.white70),
          iconTheme: const IconThemeData(color: Colors.white70),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: _accentColor,
            backgroundColor: _darkAccentColor,
          ),
          errorColor: Color.fromRGBO(207, 102, 121, 1),
          canvasColor: Colors.black,
          primarySwatch: Colors.blueGrey,
          primaryColor: Colors.grey[900],
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white10,
            selectionHandleColor: _darkAccentColor,
            selectionColor: _darkAccentColor.withOpacity(0.5),
          ),
          backgroundColor: Colors.black,
          selectedRowColor: Colors.grey[900],
          cardColor: Colors.black,
          cardTheme: CardTheme(
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey[900], width: 2)),
            elevation: 0,
          ),
          textTheme: _lightAccentTextTheme,
          primaryTextTheme: _lightAccentTextTheme,
          accentTextTheme: _brightness == Brightness.dark
              ? _lightAccentTextTheme
              : _darkAccentTextTheme,
          bottomAppBarTheme:
              BottomAppBarTheme(color: Colors.transparent, elevation: 0.0),
          dialogTheme: DialogTheme(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: _darkAccentColor)),
          ),
          popupMenuTheme: PopupMenuThemeData(
            color: Colors.grey[900],
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: _darkAccentColor)),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.grey[900],
            contentTextStyle: TextStyle(color: Colors.white70),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: _darkAccentColor)),
            behavior: SnackBarBehavior.floating,
          ),
          buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.normal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              layoutBehavior: ButtonBarLayoutBehavior.constrained,
              buttonColor: Colors.grey[900],
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              height: 48),
          bottomSheetTheme: BottomSheetThemeData(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
          ),
          chipTheme: ChipThemeData(
              checkmarkColor: _brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black87,
              backgroundColor: Colors.white12,
              deleteIconColor: Colors.white70,
              disabledColor: Colors.white.withAlpha(0x0C),
              selectedColor: _darkAccentColor.withAlpha(0xFC), //Colors.white24,
              secondarySelectedColor: _darkAccentColor.withAlpha(0xFC),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              padding: const EdgeInsets.all(4.0),
              labelStyle: _lightAccentTextTheme.bodyText2,
              secondaryLabelStyle: _brightness == Brightness.dark
                  ? _lightAccentTextTheme.bodyText2
                  : _darkAccentTextTheme.bodyText2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              brightness: _brightness),
          navigationRailTheme: NavigationRailThemeData(
              labelType: NavigationRailLabelType.selected,
              backgroundColor: Colors.transparent,
              groupAlignment: 1.0,
              selectedIconTheme: IconThemeData(color: _darkAccentColor),
              selectedLabelTextStyle: _lightAccentTextTheme.bodyText2
                  .apply(color: _darkAccentColor),
              unselectedIconTheme: const IconThemeData(color: Colors.white70),
              unselectedLabelTextStyle: _lightAccentTextTheme.bodyText2),
          sliderTheme: SliderThemeData(
            valueIndicatorColor: Color.alphaBlend(
                _darkAccentColor.withOpacity(0.36),
                _darkAccentColor.withAlpha(0xFC)),
            valueIndicatorTextStyle: _brightness == Brightness.dark
                ? _lightAccentTextTheme.bodyText1
                : _darkAccentTextTheme.bodyText1,
          ),
          toggleableActiveColor: _darkAccentColor,
          buttonColor: Colors.grey[900],
        );
        break;
    }
  }

  ThemeData get light => _lightTheme;
  ThemeData get dark => _darkTheme;
}
