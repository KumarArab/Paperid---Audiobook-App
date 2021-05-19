import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  Color primaryColor = Color(0xff455A6F);
  Color secondaryColor = Color(0xffFFEFA1);
  Color canvasColor = Color(0xffF1F6F9);
  Color hintColor = Color(0xffAAAAAA);
  ThemeData buildLightTheme() {
    return ThemeData.light().copyWith(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        accentColor: secondaryColor,
        hintColor: hintColor,
        textTheme: GoogleFonts.openSansTextTheme(),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.openSans(color: hintColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: canvasColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: hintColor.withOpacity(0.3),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
            minimumSize: Size(double.infinity, 60),
            textStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          primary: Colors.lightBlueAccent,
          shadowColor: Colors.pink,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )));
  }

  ThemeData buildDarkTheme() {
    return ThemeData.dark()
        .copyWith(textTheme: GoogleFonts.openSansTextTheme());
  }
}
