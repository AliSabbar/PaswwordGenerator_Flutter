import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_generator/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: primaryColor,
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      color: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: primaryColor,
    elevation: 20.0,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: darkColor,
  primarySwatch: secondaryColor,
  appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      color: darkColor,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: darkColor,
          statusBarIconBrightness: Brightness.light)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkColor,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: secondaryColor,
    unselectedItemColor: Colors.grey,
    elevation: 0.0,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: darkColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
  )
);
