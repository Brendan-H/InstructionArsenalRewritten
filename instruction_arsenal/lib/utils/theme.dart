/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (theme.dart) Last Modified on 12/30/22, 3:46 PM
 *
 */

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';


class CustomTheme {
  // static TextStyle get title1 => GoogleFonts.getFont(
  //   'Poppins',
  //   color: const Color(0xFF303030),
  //   fontWeight: FontWeight.w600,
  //   fontSize: 24,
  // );
  static ThemeData get lightTheme {
    return ThemeData( //2
      brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat', //3
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
          centerTitle: false),

        buttonTheme: ButtonThemeData( // 4
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.blueAccent,
        ),
        iconTheme: const IconThemeData(
        color: Colors.black
    ),

    );

  }


  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue[900],
    scaffoldBackgroundColor: Colors.grey[800],
    fontFamily: 'Montserrat', //3
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade700,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
        centerTitle: false),

    buttonTheme: ButtonThemeData( // 4
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      buttonColor: Colors.blueAccent.shade700,
    ),
    iconTheme: const IconThemeData(
        color: Colors.black
    ),

  );
}
// TODO actually use theme