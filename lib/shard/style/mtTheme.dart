import 'package:flutter/material.dart';

import 'colors.dart';

class MyTheme{
  static ThemeData myTheme=ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(fontSize: 22),
      centerTitle: true,
      backgroundColor: green,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(18),
              bottomLeft: Radius.circular(18))),
    )
  );
}