import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  Color primaryColor = Color.lerp(Color(0xff4274fe), Color(0xff9571F6), 0.3);
  Color secondaryColor = Color.lerp(Color(0xffff6227), Color(0xfffbaa1f), 0.5);
  Color tertiaryColor = Color(0xfffbaa1f);
  Color canvasColor = Color(0xffF1F6F9);
  Color hintColor = Color(0xffAAAAAA);
  Color voiletColor = Color(0xff140730);
  Color mulledWineColor = Color(0xff4f446a);
  Color dolphinColor = Color(0xff6f6A7b);
  Color silverColor = Color(0xffcbcbcb);

  // Other Colors in consideration
  Color blueColor = Color(0xfff4274fe);
  Color orangeColor = Color(0xffff6227);
  Color purpleColor = Color(0xff9571F6);
  Color pinkColor = Color(0xffE38DDD);
  ThemeData buildLightTheme() {
    return ThemeData(
        fontFamily: "Axiforma",
        primaryColor: primaryColor,
        accentColor: primaryColor,
        sliderTheme: SliderThemeData(
          activeTrackColor: primaryColor,
          activeTickMarkColor: primaryColor,
          thumbColor: primaryColor,
          inactiveTrackColor: silverColor,
          disabledThumbColor: primaryColor,
          inactiveTickMarkColor: primaryColor,
        )).copyWith(
      primaryColor: primaryColor,
      canvasColor: Colors.white,
      accentColor: secondaryColor,
      hintColor: hintColor,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: hintColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: silverColor.withOpacity(0.5), width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: mulledWineColor.withOpacity(0.2),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.3),
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
        ),
      ),
    );
  }

  // ThemeData buildDarkTheme() {
  //   return ThemeData.dark().copyWith(
  //     textTheme: GoogleFonts.openSansTextTheme(),
  //   );
  // }
}
