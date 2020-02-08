import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const lightColor = const MaterialColor(
  0xFFC91B3A,
  <int, Color>{
    50: Color(0xFFF9E4E7),
    100: Color(0xFFEFBBC4),
    200: Color(0xFFE48D9D),
    300: Color(0xFFD95F75),
    400: Color(0xFFD13D58),
    500: Color(0xFFC91B3A),
    600: Color(0xFFC91B3A),
    700: Color(0xFFBC142C),
    800: Color(0xFFB51025),
    900: Color(0xFFA90818),
  },
);
const lightAccentColor = const MaterialAccentColor(
  0xFFffa1a8,
  <int, Color>{
    100: Color(0xFFFFD4D7),
    200: Color(0xFFFFA1A8),
    400: Color(0xFFFF6E79),
    700: Color(0xFFFF5561),
  },
);

Future<Map<String,dynamic>> getTheme() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final String themeMode = preferences.getString('Theme') ?? 'Auto';
  return {'Theme' : themeMode};
}

class ThemeProvider with ChangeNotifier{
  String _savedTheme;
  ThemeMode preferredTheme;

  ThemeProvider(this._savedTheme) : preferredTheme = _switchPreferredTheme(_savedTheme);

  String get savedTheme => _savedTheme;

  themePreference(String value) async {
    if(value != _savedTheme){
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      _savedTheme = value;
      await preferences.setString('Theme', value);
      preferredTheme = _switchPreferredTheme(_savedTheme);
      notifyListeners();
    }
  }

  static ThemeMode _switchPreferredTheme(String theme){
    switch(theme){
      case 'Light':
        return ThemeMode.light;
      case 'Dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

class Themes{
  static const Color _darkAccentColor = const Color.fromRGBO(207, 102, 121, 1);
  static final ThemeData _lightTheme = ThemeData(
    textSelectionHandleColor: lightColor[300],
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: lightColor,
      textTheme: TextTheme(
        title: TextStyle(color: Colors.white, fontSize: 20),
        subtitle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      iconTheme: IconThemeData(
          color: Colors.white
      ),
    ),
    dividerColor: lightColor,
    scaffoldBackgroundColor: Colors.grey[300],
    accentColor: lightAccentColor,
    accentIconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    iconTheme: const IconThemeData(color: Colors.black),
    errorColor: lightAccentColor[700],
    canvasColor: Colors.white,
    primarySwatch: lightColor,
    primaryColor: lightColor,
    cursorColor: Colors.black12,
    backgroundColor: lightColor[50],
    cardTheme: CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    textTheme: TextTheme(
      title: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w400),
      subtitle: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w400),
      body1: TextStyle(color: Colors.black87),
      body2: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w400),
      display1: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600),
      subhead: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w400),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600),
      backgroundColor: lightColor[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    snackBarTheme: SnackBarThemeData(
      //backgroundColor: lightColor[100],
      /*
      contentTextStyle: TextStyle(
          color: Colors.black
      ),

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: lightAccentColor)
      ),
      */
      behavior: SnackBarBehavior.fixed,
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      layoutBehavior: ButtonBarLayoutBehavior.constrained,
      buttonColor: lightColor[100],
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      height: 48,
      highlightColor: Colors.white70,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    ),
    toggleableActiveColor: lightAccentColor,
    indicatorColor: lightColor[100],
    buttonColor: lightColor[100],
  );
  static final ThemeData _darkTheme = ThemeData(
    splashFactory: InkRipple.splashFactory,
    primaryColorDark: _darkAccentColor,
    textSelectionHandleColor: _darkAccentColor,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Colors.blueGrey[900],
      textTheme: TextTheme(
        title: TextStyle(color: const Color(0xFFB2B2B2), fontSize: 20),
        subtitle: TextStyle(color: const Color(0xFFB2B2B2), fontSize: 16),
      ),
      iconTheme: const IconThemeData(color: Colors.white54),
    ),
    brightness: Brightness.dark,
    unselectedWidgetColor: Colors.white54,
    dividerColor: Colors.blueGrey[700],
    scaffoldBackgroundColor: Colors.blueGrey[900],
    accentColor: _darkAccentColor,
    accentIconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Colors.white54),
    iconTheme: const IconThemeData(color: Colors.white54),
    errorColor: _darkAccentColor,
    primaryColorLight: Colors.blueGrey[800],
    canvasColor: Colors.blueGrey[900],
    primarySwatch: Colors.blueGrey,
    primaryColor: Colors.blueGrey[900],
    cursorColor: Colors.white10,
    backgroundColor: Colors.blueGrey[800],
    selectedRowColor: Colors.blueGrey[700],
    cardTheme: CardTheme(
      color: Colors.blueGrey[800],
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 8,
    ),
    textTheme: TextTheme(
      title: TextStyle(color: const Color(0xFFB2B2B2), fontSize: 18, fontWeight: FontWeight.w400),
      subtitle: TextStyle(color: const Color(0xFFB2B2B2), fontSize: 12, fontWeight: FontWeight.w400),
      body1: TextStyle(color: const Color(0xFFB2B2B2)),
      body2: TextStyle(color: const Color(0xFFB2B2B2), fontSize: 16, fontWeight: FontWeight.w400),
      display1: TextStyle(color: const Color(0xFFB2B2B2), fontSize: 18, fontWeight: FontWeight.w600),
      subhead: TextStyle(color: const Color(0xFFB2B2B2), fontSize: 14, fontWeight: FontWeight.w400),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
        color: Colors.transparent,
        elevation: 0.0
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(color: const Color(0xFFB2B2B2), fontSize: 18, fontWeight: FontWeight.w600),
      backgroundColor: Colors.blueGrey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.blueGrey[800],
      contentTextStyle: TextStyle(
          color: const Color(0xFFB2B2B2)
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: _darkAccentColor)
      ),
      behavior: SnackBarBehavior.floating,
    ),
    buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        layoutBehavior: ButtonBarLayoutBehavior.constrained,
        buttonColor: Colors.grey[900],
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: 48
    ),
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    ),
    toggleableActiveColor: _darkAccentColor,
    indicatorColor: Colors.blueGrey[700],
    buttonColor: Colors.blueGrey[800],
    chipTheme: ChipThemeData(
      brightness: Brightness.dark,
      backgroundColor: Colors.blueGrey[800],
      selectedColor: _darkAccentColor,
      secondarySelectedColor: _darkAccentColor,
      disabledColor: Colors.grey,
      labelPadding: const EdgeInsetsDirectional.only(start: 8, end: 8),
      padding: const EdgeInsets.all(4),
      labelStyle: TextStyle(color: const Color(0xFFB2B2B2), fontSize: 16, fontWeight: FontWeight.w300),
      secondaryLabelStyle: TextStyle(color: const Color(0xFFB2B2B2), fontSize: 16, fontWeight: FontWeight.w300),
      shape: StadiumBorder(),
    )
  );

  static ThemeData get light => _lightTheme;
  static ThemeData get dark => _darkTheme;
}