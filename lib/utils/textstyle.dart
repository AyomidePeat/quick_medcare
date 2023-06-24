import 'package:flutter/material.dart';

import 'colors.dart';

headline1(context) {
  final headline1 = Theme.of(context).textTheme.displayLarge;
  return headline1;
}

headline2(context) {
  final headline2 = Theme.of(context).textTheme.displayMedium;
  return headline2;
}

headline3(context) {
  final headline3 = Theme.of(context).textTheme.displaySmall;
  return headline3;
}
headLineText4() {
  return TextStyle(fontFamily:'Poppins-Regular' ,fontSize: 12, fontWeight: FontWeight.bold, color: black);
}
bodyText1(context) {
  final bodyText1 = Theme.of(context).textTheme.bodyLarge;
  return bodyText1;
}

bodyText2(context) {
  final bodyText2 = Theme.of(context).textTheme.bodyMedium;
  return bodyText2;
}

bodyText3(context) {
  final bodyText3 = Theme.of(context).textTheme.bodySmall;
  return bodyText3;
}

bodyText4(context) {
  final bodyText4 = Theme.of(context).textTheme.titleMedium;
  return bodyText4;
}

bodyText5(context) {
  final bodyText5 = Theme.of(context).textTheme.titleSmall;
  return bodyText5;
}
bodyText6() {
  return TextStyle(fontFamily:'Poppins-Regular' ,fontSize: 12,  color: Color.fromARGB(255, 167, 164, 164));
}

