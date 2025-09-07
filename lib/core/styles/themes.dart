import 'package:flutter/material.dart';

const Color primaryColor= Color(0xFF1B5E37);
const Color secondPrimaryColor= Color(0XFFF4A91F);
const Color secondTextColor= Color(0xFF616A6B);
const Color borderColor= Color(0XFFE6E9EA);
const Color containerColor= Color(0XFFF3F5F7);

class ThemeService {

  final lightTheme = ThemeData(
    scaffoldBackgroundColor:  Color(0xFFFFFFFF),
    primaryColor: primaryColor,
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        showUnselectedLabels: false
    ),
    buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.dark(),
        buttonColor: Colors.black87
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black87,
      dividerColor: primaryColor,
    ),
  );
}