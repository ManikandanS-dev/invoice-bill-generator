import 'package:flutter/material.dart';

class Kconst {
  static ColorScheme kTheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  static TextTheme kTextTheme(BuildContext context) =>
      Theme.of(context).textTheme;

  static bool isMini(BuildContext context) =>
      MediaQuery.of(context).size.width <= 1100;

  static const borderColor = Color(0xff00497a);
  static const double borderWith = 2.5;

  static Color red = const Color(0xFFFF464F);
  static Color red2 = const Color(0xFFFF575F);
  static Color red3 = const Color(0xFF623A42);
  static Color orange = const Color(0xFFFF8A34);
  static Color orange2 = const Color(0xFFFF974A);
  static Color orange3 = const Color(0xFF624D3B);
  static Color yellow = const Color(0xFFFFBC25);
  static Color yellow2 = const Color(0xFFFFC542);
  static Color yellow3 = const Color(0xFF625B39);
  static Color green = const Color(0xFF25C685);
  static Color green2 = const Color(0xFF3DD598);
  static Color green3 = const Color(0xFF286053);
  static Color blue = const Color(0xFF005DF2);
  static Color blue2 = const Color(0xFF0062FF);
  static Color blue3 = const Color(0xFF163E72);
  static Color violet = const Color(0xFF6952DC);
  static Color violet2 = const Color(0xFF755FE2);
  static Color violet3 = const Color(0xFF393D69);
  static Color text = const Color(0xFFFFFFFF);
  static Color text2 = const Color(0xFF96A7AF);
  static Color text3 = const Color(0xFF475E69);
  static Color text4 = const Color(0xFF30444e);
  static Color backround = const Color(0xFF2A3C44);
  static LinearGradient linearBackroundGreen = const LinearGradient(
      colors: [Color(0xFF40DF9F), Color(0xFF3ED598)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static LinearGradient linearBackroundDark = const LinearGradient(
      colors: [Color(0xFF2A3C44), Color(0xFF23343C)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static LinearGradient linearBackroundDark2 = const LinearGradient(
      colors: [Color(0xFF22343C), Color(0xFF1F2E35)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
