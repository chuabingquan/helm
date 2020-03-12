import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './constants.dart' as Constants;
import './screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Constants.PRIMARY_COLOR,
        accentColor: Constants.ACCENT_COLOR,
        textTheme: GoogleFonts.karlaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Home(),
    );
  }
}
