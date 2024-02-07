import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart';

enum ThemeStateEnum { customColor1, customColor2, customColor3 }

class ThemeState extends ChangeNotifier {
  SharedPreferences? _sharedPreferences;
  ThemeData _themeData = kLightTheme;

  ThemeData get themeData => _themeData;
  set themeData(ThemeData val) {
    _themeData = val;
    notifyListeners();
  }

  // Colores personalizados
  static const Color customColor1 = Color(0xffe1ecd6);
  static const Color customColor2 = Color(0xffaee1d3);
  static const Color customColor3 = Color(0xff7cd7cf);

  ThemeState() {
    _initSharedPrefs();
  }

  _initSharedPrefs() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    ThemeStateEnum val = _getOption();
    _switchTheme(val);
  }

  void _switchTheme(ThemeStateEnum selected) {
    switch (selected) {
      case ThemeStateEnum.customColor1:
        themeData = ThemeData(
          primaryColor: customColor1,
          // Agrega otros colores personalizados según sea necesario
        );
        break;
      case ThemeStateEnum.customColor2:
        themeData = ThemeData(
          primaryColor: customColor2,
          // Agrega otros colores personalizados según sea necesario
        );
        break;
      case ThemeStateEnum.customColor3:
        themeData = ThemeData(
          primaryColor: customColor3,
          // Agrega otros colores personalizados según sea necesario
        );
        break;
    }
  }

  void saveOptionValue(ThemeStateEnum optionValue) {
    _switchTheme(optionValue);
    _sharedPreferences?.setInt('theme_option', optionValue.index);
  }

  ThemeStateEnum _getOption() {
    int option = _sharedPreferences?.getInt('theme_option') ?? 1;
    return ThemeStateEnum.values[option];
  }
}
