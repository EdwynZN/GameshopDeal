import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/services.dart';

abstract class ThemeRepository {
  late Color _darkAccentColor;
  final TextTheme _darkAccentTextTheme = const TextTheme(
    titleMedium: TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.15),
    titleSmall: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1),
    bodyLarge: TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5),
    bodyMedium: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25),
    labelSmall: TextStyle(
        color: Colors.black87,
        fontSize: 11,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.0,
        height: 1.5),
    labelLarge: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25),
    displayLarge: TextStyle(
        color: Colors.black87,
        fontSize: 28,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5),
    displayMedium: TextStyle(
        color: Colors.black87,
        fontSize: 26,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5),
    displaySmall: TextStyle(
        color: Colors.black87, fontSize: 22, fontWeight: FontWeight.normal),
    headlineMedium: TextStyle(
        color: Colors.black87,
        fontSize: 21,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25),
    headlineSmall: TextStyle(
        color: Colors.black87, fontSize: 20, fontWeight: FontWeight.normal),
    titleLarge: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15),
  );
  final TextTheme _lightAccentTextTheme = const TextTheme(
    titleMedium: TextStyle(
        color: Colors.white70,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.15),
    titleSmall: TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1),
    bodyLarge: TextStyle(
        color: Colors.white70,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5),
    bodyMedium: TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25),
    labelSmall: TextStyle(
        color: Colors.white70,
        fontSize: 11,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.0,
        height: 1.5),
    labelLarge: TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25),
    displayLarge: TextStyle(
        color: Colors.white70,
        fontSize: 28,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5),
    displayMedium: TextStyle(
        color: Colors.white70,
        fontSize: 26,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5),
    displaySmall: TextStyle(
        color: Colors.white70, fontSize: 22, fontWeight: FontWeight.normal),
    headlineMedium: TextStyle(
        color: Colors.white70,
        fontSize: 21,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25),
    headlineSmall: TextStyle(
        color: Colors.white70, fontSize: 20, fontWeight: FontWeight.normal),
    titleLarge: TextStyle(
        color: Colors.white70,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15),
  );

  ThemeData get light;
  ThemeData get dark;
}

class ThemeFlex extends ThemeRepository {
  ThemeFlex();
  
  final light = FlexThemeData.light(
    scheme: FlexScheme.redWine,
    subThemesData: const FlexSubThemesData(
      interactionEffects: false,
      tintedDisabledControls: false,
      blendOnColors: false,
      useTextTheme: true,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      inputDecoratorUnfocusedBorderIsColored: false,
      tooltipRadius: 4,
      tooltipSchemeColor: SchemeColor.inverseSurface,
      tooltipOpacity: 0.9,
      snackBarElevation: 6,
      textButtonTextStyle: const MaterialStatePropertyAll(
        TextStyle(
          fontSize: 16.0,
          decoration: TextDecoration.underline,
        ),
      ),
      snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
      navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedLabel: false,
      navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedIcon: false,
      navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationBarIndicatorOpacity: 1.00,
      navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
      navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
      navigationRailMutedUnselectedLabel: false,
      navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
      navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationRailMutedUnselectedIcon: false,
      navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailBackgroundSchemeColor: SchemeColor.surface,
      navigationRailLabelType: NavigationRailLabelType.none,
    ),
    keyColors: const FlexKeyColors(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    appBarStyle: FlexAppBarStyle.primary,
    // To use the Playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  final dark = FlexThemeData.dark(
    scheme: FlexScheme.redWine,
    subThemesData: const FlexSubThemesData(
      interactionEffects: false,
      tintedDisabledControls: false,
      useTextTheme: true,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      inputDecoratorUnfocusedBorderIsColored: false,
      tooltipRadius: 4,
      tooltipSchemeColor: SchemeColor.inverseSurface,
      tooltipOpacity: 0.9,
      snackBarElevation: 6,
      textButtonTextStyle: const MaterialStatePropertyAll(
        TextStyle(
          fontSize: 16.0,
          decoration: TextDecoration.underline,
        ),
      ),
      snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
      navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedLabel: false,
      navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedIcon: false,
      navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationBarIndicatorOpacity: 1.00,
      navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
      navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
      navigationRailMutedUnselectedLabel: false,
      navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
      navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationRailMutedUnselectedIcon: false,
      navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailBackgroundSchemeColor: SchemeColor.surface,
      navigationRailLabelType: NavigationRailLabelType.none,
    ),
    keyColors: const FlexKeyColors(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );

}

class ThemeImpl extends ThemeRepository {
  late final ThemeData _lightTheme;
  late final ThemeData _darkTheme;

  ThemeImpl() {
    _setLight = 0;
    _setDark = 1;
  }

  set _setLight(int light) {
    MaterialColor color = Colors.primaries[light.clamp(0, 17)];
    MaterialAccentColor accentColor = Colors.accents[light.clamp(0, 15)];
    if (light >= 17)
      accentColor = const MaterialAccentColor(
        0xFF4D6773,
        <int, Color>{
          100: Color(0xFFA7C0CD),
          200: Color(0xFF78909C),
          400: Color(0xFF62727b),
          700: Color(0xFF546E7A),
        },
      );
    _darkAccentColor = accentColor;
    final Brightness _brightnessColor =
        ThemeData.estimateBrightnessForColor(color);
    final Brightness _brightnessAccentColor =
        ThemeData.estimateBrightnessForColor(accentColor);
    final Brightness _brightnessPrimaryColor =
        ThemeData.estimateBrightnessForColor(accentColor[100]!);
    final Brightness _brightnessAccentTextTheme =
        ThemeData.estimateBrightnessForColor(accentColor[700]!);
    _lightTheme = ThemeData(
      splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
      primaryColorLight: accentColor[100],
      primaryColorDark: accentColor[600],
      primaryIconTheme: const IconThemeData(color: Colors.black),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: color[300],
        selectionColor: accentColor.withOpacity(0.5),
        cursorColor: Colors.black12,
      ),
      brightness: _brightnessColor,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        surfaceTintColor: color,
        backgroundColor: color,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: _brightnessColor,
          statusBarIconBrightness: _brightnessColor == Brightness.light
              ? Brightness.dark
              : Brightness.light,
          systemNavigationBarIconBrightness:
              _brightnessColor == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
          statusBarColor: color,
          systemNavigationBarColor: color,
        ),
        titleTextStyle: _brightnessColor == Brightness.light
            ? _darkAccentTextTheme.titleLarge!
            : _lightAccentTextTheme.titleLarge!.apply(color: Colors.white),
        foregroundColor:
            _brightnessColor == Brightness.light ? Colors.black : Colors.white,
        toolbarTextStyle: _brightnessColor == Brightness.light
            ? _darkAccentTextTheme.bodyMedium
            : _lightAccentTextTheme.bodyMedium,
        iconTheme: IconThemeData(
          color: _brightnessColor == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
      unselectedWidgetColor: Colors.black87,
      dividerColor: color,
      disabledColor: Colors.black26,
      scaffoldBackgroundColor: color[50],
      iconTheme: const IconThemeData(color: Colors.black),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: const CircleBorder(),
        foregroundColor: _brightnessAccentColor == Brightness.dark
            ? Colors.white
            : Colors.black,
        backgroundColor: accentColor,
      ),
      canvasColor: color[50],
      primaryColor: color,
      highlightColor: color[200],
      cardColor: color[100],
      cardTheme: CardTheme(
        color: color.shade100,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        elevation: 8.0,
        surfaceTintColor: color.shade100,
      ),
      textTheme: _darkAccentTextTheme,
      primaryTextTheme: _brightnessPrimaryColor == Brightness.dark
          ? _lightAccentTextTheme
          : _darkAccentTextTheme,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: accentColor,
        linearTrackColor: color.shade100,
        circularTrackColor: color.shade100,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
          shape: CircularNotchedRectangle(),
          color: color,
          // color: Colors.transparent,
          elevation: 0.0),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        selectedItemColor: _brightnessAccentColor == Brightness.dark
            ? Colors.white
            : Colors.black,
        unselectedItemColor: _brightnessAccentColor == Brightness.dark
            ? color[100]!.withOpacity(0.75)
            : Colors.black38,
        showUnselectedLabels: true,
      ),
      dialogTheme: DialogTheme(
        titleTextStyle: _darkAccentTextTheme.titleLarge,
        contentTextStyle: _darkAccentTextTheme.titleMedium,
        backgroundColor: color[50],
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: color[100],
        contentTextStyle: TextStyle(color: Colors.black),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: accentColor)),
        behavior: SnackBarBehavior.floating,
      ),
      splashColor: color.withOpacity(0.24),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        mouseCursor: MaterialStateProperty.all<MouseCursor>(
            MaterialStateMouseCursor.clickable),
        //enableFeedback: false,
        shape:
            MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder()),
        side: MaterialStateProperty.all<BorderSide>(BorderSide(
          color: accentColor[700]!,
          width: 1,
        )),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color?>(
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
        foregroundColor: MaterialStateProperty.all<Color?>(
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
                if (states.contains(MaterialState.pressed)) return 0.0;
                return 8.0;
              }),
              backgroundColor: MaterialStateProperty.all<Color?>(color[100]),
              foregroundColor: MaterialStateProperty.all<Color?>(
                  _darkAccentTextTheme.displayLarge!.color),
              textStyle: MaterialStateProperty.all<TextStyle?>(
                  _darkAccentTextTheme.bodyLarge),
              overlayColor: MaterialStateProperty.all<Color>(
                  _darkAccentColor.withOpacity(0.24)),
              visualDensity: VisualDensity(vertical: 2.5))),
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
      ),
      chipTheme: ChipThemeData(
        checkmarkColor: _brightnessPrimaryColor == Brightness.light
            ? Colors.white
            : Colors.black,
        backgroundColor: Colors.black12,
        deleteIconColor: Colors.black87,
        disabledColor: Colors.black.withAlpha(0x0c),
        selectedColor: color.shade100,
        secondarySelectedColor: color.shade100,
        labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.all(4.0),
        labelStyle: _darkAccentTextTheme.bodyMedium!,
        secondaryLabelStyle: _darkAccentTextTheme.bodyMedium!.apply(
          color:
              _brightnessPrimaryColor == Brightness.light ? null : color[500],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide.none,
        brightness: _brightnessColor,
      ),
      navigationRailTheme: NavigationRailThemeData(
        labelType: NavigationRailLabelType.selected,
        backgroundColor: color[50],
        elevation: 8.0,
        groupAlignment: 1.0,
        selectedIconTheme: IconThemeData(color: accentColor[700]),
        selectedLabelTextStyle: _lightAccentTextTheme.bodyMedium!.apply(
            color: _brightnessAccentTextTheme == Brightness.dark
                ? accentColor[700]
                : Colors.black),
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        unselectedLabelTextStyle: _darkAccentTextTheme.bodyMedium,
      ),
      indicatorColor: color[100],
      useMaterial3: true, checkboxTheme: CheckboxThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return accentColor[700]; }
 return null;
 }),
 ), radioTheme: RadioThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return accentColor[700]; }
 return null;
 }),
 ), switchTheme: SwitchThemeData(
 thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return accentColor[700]; }
 return null;
 }),
 trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return accentColor[700]; }
 return null;
 }),
 ), colorScheme: ColorScheme.light(
        background: Colors.white,
        error: Colors.redAccent,
        onBackground: Colors.black,
        onError: Colors.white,
        primary: color,
        onPrimary: Colors.white,
        onSecondary: _brightnessAccentTextTheme == Brightness.dark
            ? Colors.white70
            : Colors.black,
        secondary: accentColor.shade700,
        surface: Colors.white,
        onSurface: Colors.black,
        primaryContainer: color.shade700,
        secondaryContainer: accentColor.shade700,
        brightness: _brightnessColor,
        surfaceTint: color.shade100,
      ).copyWith(background: color[100]).copyWith(error: Colors.redAccent),
    );
  
  }

  set _setDark(int dark) {
    final Brightness _brightness = Brightness.dark;
    final Color _accentColor =
        _brightness == Brightness.dark ? Colors.white : Colors.black;
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
            systemOverlayStyle: _brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
            elevation: 0.0,
            color: Colors.blueGrey[900],
            iconTheme: const IconThemeData(color: Colors.white70), toolbarTextStyle: _lightAccentTextTheme.apply().bodyMedium, titleTextStyle: _lightAccentTextTheme.apply().titleLarge,
          ),
          brightness: Brightness.dark,
          unselectedWidgetColor: Colors.white70,
          dividerColor: Colors.blueGrey[700],
          scaffoldBackgroundColor: Colors.blueGrey[900],
          primaryIconTheme: const IconThemeData(color: Colors.white70),
          iconTheme: const IconThemeData(color: Colors.white70),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: _accentColor,
            backgroundColor: _darkAccentColor,
          ),
          canvasColor: Colors.blueGrey[900],
          primaryColor: Colors.blueGrey[900],
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white10,
            selectionHandleColor: _darkAccentColor,
            selectionColor: _darkAccentColor.withOpacity(0.5),
          ),
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
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.disabled)) return null;
                    return Colors.blueGrey.shade800;
                  }),
                  // backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[800]),
                  foregroundColor: MaterialStateProperty.all<Color?>(
                      _lightAccentTextTheme.displayLarge?.color),
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
              labelStyle: _lightAccentTextTheme.bodyMedium,
              secondaryLabelStyle: _brightness == Brightness.dark
                  ? _lightAccentTextTheme.bodyMedium
                  : _darkAccentTextTheme.bodyMedium,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              brightness: _brightness),
          navigationRailTheme: NavigationRailThemeData(
              labelType: NavigationRailLabelType.selected,
              backgroundColor: Colors.blueGrey[800],
              elevation: 8.0,
              groupAlignment: 1.0,
              selectedIconTheme: IconThemeData(color: _darkAccentColor),
              selectedLabelTextStyle: _lightAccentTextTheme.bodyMedium
                  ?.apply(color: _darkAccentColor),
              unselectedIconTheme: const IconThemeData(color: Colors.white70),
              unselectedLabelTextStyle: _lightAccentTextTheme.bodyMedium),
          sliderTheme: SliderThemeData(
            valueIndicatorColor: Color.alphaBlend(
                _darkAccentColor.withOpacity(0.36),
                _darkAccentColor.withAlpha(0xFC)),
            valueIndicatorTextStyle: _brightness == Brightness.dark
                ? _lightAccentTextTheme.bodyLarge
                : _darkAccentTextTheme.bodyLarge,
          ),
          indicatorColor: Colors.blueGrey[700], checkboxTheme: CheckboxThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 ), radioTheme: RadioThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 ), switchTheme: SwitchThemeData(
 thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(secondary: _darkAccentColor).copyWith(background: Colors.blueGrey[800]).copyWith(error: Color.fromRGBO(207, 102, 121, 1)),
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
            systemOverlayStyle: _brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
            elevation: 0.0,
            color: Colors.grey[900],
            iconTheme: const IconThemeData(color: Colors.white70), toolbarTextStyle: _lightAccentTextTheme.bodyMedium, titleTextStyle: _lightAccentTextTheme.titleLarge,
          ),
          unselectedWidgetColor: Colors.white70,
          dividerColor: _darkAccentColor.withOpacity(0.75),
          dividerTheme: DividerThemeData(
            color: _darkAccentColor.withOpacity(0.75),
            space: 1.0,
            thickness: 1.0,
          ),
          scaffoldBackgroundColor: Colors.grey[900],
          //accentColorBrightness: _brightnessAccentColor,
          primaryIconTheme: const IconThemeData(color: Colors.white70),
          iconTheme: const IconThemeData(color: Colors.white70),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: _accentColor,
            backgroundColor: _darkAccentColor,
          ),
          canvasColor: Colors.grey[900],
          primaryColor: Colors.grey[900],
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white10,
            selectionHandleColor: _darkAccentColor,
            selectionColor: _darkAccentColor.withOpacity(0.5),
          ),
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
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.disabled)) return null;
                    return Colors.grey[800];
                  }),
                  // backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[800]),
                  foregroundColor: MaterialStateProperty.all<Color?>(
                      _lightAccentTextTheme.displayLarge?.color),
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
              labelStyle: _lightAccentTextTheme.bodyMedium,
              secondaryLabelStyle: _brightness == Brightness.dark
                  ? _lightAccentTextTheme.bodyMedium
                  : _darkAccentTextTheme.bodyMedium,
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
              selectedLabelTextStyle: _lightAccentTextTheme.bodyMedium
                  ?.apply(color: _darkAccentColor),
              unselectedLabelTextStyle: _lightAccentTextTheme.bodyMedium),
          sliderTheme: SliderThemeData(
            valueIndicatorColor: Color.alphaBlend(
                _darkAccentColor.withOpacity(0.36),
                _darkAccentColor.withAlpha(0xFC)),
            valueIndicatorTextStyle: _brightness == Brightness.dark
                ? _lightAccentTextTheme.bodyLarge
                : _darkAccentTextTheme.bodyLarge,
          ),
          indicatorColor: Colors.grey[700], checkboxTheme: CheckboxThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 ), radioTheme: RadioThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 ), switchTheme: SwitchThemeData(
 thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(secondary: _darkAccentColor).copyWith(background: Colors.grey[850]).copyWith(error: Color.fromRGBO(207, 102, 121, 1)),
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
            systemOverlayStyle: _brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
            elevation: 0.0,
            color: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white70), toolbarTextStyle: _lightAccentTextTheme.apply().bodyMedium, titleTextStyle: _lightAccentTextTheme.apply().titleLarge,
          ),
          unselectedWidgetColor: Colors.white70,
          dividerColor: Colors.grey[800],
          scaffoldBackgroundColor: Colors.black,
          primaryIconTheme: const IconThemeData(color: Colors.white70),
          iconTheme: const IconThemeData(color: Colors.white70),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: _accentColor,
            backgroundColor: _darkAccentColor,
          ),
          canvasColor: Colors.black,
          primaryColor: Colors.grey[900],
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white10,
            selectionHandleColor: _darkAccentColor,
            selectionColor: _darkAccentColor.withOpacity(0.5),
          ),
          cardColor: Colors.black,
          cardTheme: CardTheme(
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade900, width: 2)),
            elevation: 0,
          ),
          textTheme: _lightAccentTextTheme,
          primaryTextTheme: _lightAccentTextTheme,
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
              labelStyle: _lightAccentTextTheme.bodyMedium,
              secondaryLabelStyle: _brightness == Brightness.dark
                  ? _lightAccentTextTheme.bodyMedium
                  : _darkAccentTextTheme.bodyMedium,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              brightness: _brightness),
          navigationRailTheme: NavigationRailThemeData(
              labelType: NavigationRailLabelType.selected,
              backgroundColor: Colors.transparent,
              groupAlignment: 1.0,
              selectedIconTheme: IconThemeData(color: _darkAccentColor),
              selectedLabelTextStyle: _lightAccentTextTheme.bodyMedium
                  ?.apply(color: _darkAccentColor),
              unselectedIconTheme: const IconThemeData(color: Colors.white70),
              unselectedLabelTextStyle: _lightAccentTextTheme.bodyMedium),
          sliderTheme: SliderThemeData(
            valueIndicatorColor: Color.alphaBlend(
                _darkAccentColor.withOpacity(0.36),
                _darkAccentColor.withAlpha(0xFC)),
            valueIndicatorTextStyle: _brightness == Brightness.dark
                ? _lightAccentTextTheme.bodyLarge
                : _darkAccentTextTheme.bodyLarge,
          ), checkboxTheme: CheckboxThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 ), radioTheme: RadioThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 ), switchTheme: SwitchThemeData(
 thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return _darkAccentColor; }
 return null;
 }),
 ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(secondary: _darkAccentColor).copyWith(background: Colors.black).copyWith(error: Color.fromRGBO(207, 102, 121, 1)),
        );
        break;
    }
  }

  ThemeData get light => _lightTheme;
  ThemeData get dark => _darkTheme;
}
