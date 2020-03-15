import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import './constants.dart' as Constants;
import './screens/home_screen.dart';
import './screens/triage_screen.dart';
import './screens/challenge_screen.dart';
import './screens/reward_screen.dart';
import './screens/schedule_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(App()));
}

class App extends StatelessWidget {
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
      home: HomeScreen(),
      routes: {
        TriageScreen.routeName: (ctx) => TriageScreen(),
        ChallengeScreen.routeName: (ctx) => ChallengeScreen(),
        RewardScreen.routeName: (ctx) => RewardScreen(),
        ScheduleScreen.routeName: (ctx) => ScheduleScreen(),
      },
    );
  }
}
