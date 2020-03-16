import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import './constants.dart' as Constants;
import './screens/home_screen.dart';
import './screens/triage_screen.dart';
import './screens/challenge_screen.dart';
import './screens/reward_screen.dart';
import './screens/schedule_screen.dart';
import './screens/check_back_screen.dart';
import './providers/activities.dart';
import './providers/rewards.dart';
import './database/database.dart';
import './widgets/loading_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(App()));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _isInit = true;
  Database _database;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      connectToDB(Constants.DATABASE_NAME).then((database) {
        _database = database;
      }).catchError((err) {
        print(err);
      }).whenComplete(() {
        setState(() {
          _isInit = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_isInit
        ? MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => Activities(_database),
              ),
              ChangeNotifierProvider(
                create: (_) => Rewards(_database),
              ),
            ],
            child: MaterialApp(
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
                CheckBackScreen.routeName: (ctx) => CheckBackScreen(),
              },
            ),
          )
        : MaterialApp(
            home: Container(
              color: Constants.PRIMARY_COLOR,
              child: LoadingScreen(),
            ),
          );
  }
}
