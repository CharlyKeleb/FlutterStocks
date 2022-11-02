import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Constants {
  //App related strings
  static String appName = "Flutter Stocks";

  //Colors for theme
  static Color lightPrimary = const Color(0xfff3f4f9);
  static Color darkPrimary = const Color(0xff2B2B2B);

  static Color lightAccent = const Color(0xff0000FF);

  static Color darkAccent = const Color(0xff0000FF);

  static Color lightBG = const Color(0xfff3f4f9);
  static Color darkBG = const Color(0xff2B2B2B);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: lightAccent,
    ),
    scaffoldBackgroundColor: lightBG,
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 0.0,
      color: lightBG,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: lightBG,
      iconTheme: const IconThemeData(color: Colors.black),
      toolbarTextStyle: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: lightAccent,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    backgroundColor: darkBG,
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: Colors.white,
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    iconTheme: const IconThemeData(color: Colors.white),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: darkAccent,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 2.0,
      color: darkBG,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0.0,
      backgroundColor: darkBG,
      toolbarTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: darkAccent,
    ).copyWith(
      secondary: darkAccent,
      brightness: Brightness.dark,
    ),
  );
  String epochToString(String datee) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(datee);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var date = outputFormat.format(inputDate);
    return date;
  }

  final List<double> demoGraphData = const [
    86,
    45,
    59,
    65,
    1,
    62,
    26,
    41,
    88,
    60,
    17,
    18,
    58,
    67,
    55,
    56,
    97,
    96,
    22,
    57,
    29,
    69,
    19,
    30,
    47,
    63,
    33,
    37,
    40,
    51,
    53,
    91,
    71,
    92,
    28,
  ];
}
