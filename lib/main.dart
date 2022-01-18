import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:traveller/splash.dart';
import 'package:traveller/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const int _blackPrimaryValue = 0xff0644E2;

    const MaterialColor primaryBlack = MaterialColor(
      _blackPrimaryValue,
      <int, Color>{
        50: Color(0xff0644E2),
        100: Color(0xff0644E2),
        200: Color(0xff0644E2),
        300: Color(0xff0644E2),
        400: Color(0xff0644E2),
        500: Color(_blackPrimaryValue),
        600: Color(0xff0644E2),
        700: Color(0xff0644E2),
        800: Color(0xff0644E2),
        900: Color(0xff0644E2),
      },
    );
    return MaterialApp(
      title: 'Traveller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: primaryBlack,
          scaffoldBackgroundColor: white,
          fontFamily: "RedHatDisplay"),
      home: const Splash(),
      builder: EasyLoading.init(),
    );
  }
}
