import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_safe_area.dart';
import '../widgets/action_panel.dart';
import '../widgets/emoji_button.dart';
import '../models/activity.dart';
import '../models/reward.dart';
import '../models/challenge.dart';
import '../providers/challenges.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule';
  final Future<void> Function(DateTime, String, String) scheduleNotification;

  ScheduleScreen(this.scheduleNotification);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var _isInit = true;
  ProblemDetails _problem;
  int _actualLevel;
  int _idealLevel;
  Set<Activity> _selectedActivities = {};
  Reward _selectedReward;

  TimeOfDay _scheduledTime = TimeOfDay(
    hour: TimeOfDay.now().hour + 1,
    minute: TimeOfDay.now().minute,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final params =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      _problem = params['problem'] as ProblemDetails;
      _actualLevel = params['actualLevel'] as int;
      _idealLevel = params['idealLevel'] as int;
      _selectedActivities = params['activities'] as Set<Activity>;
      _selectedReward = params['reward'] as Reward;

      _isInit = false;
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final today = DateTime.now();
    final dateTime =
        DateTime(today.year, today.month, today.day, time.hour, time.minute);
    return DateFormat.jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _timePickerThemeData = ThemeData(
      primaryColor: theme.primaryColor,
      accentColor: theme.accentColor,
      colorScheme: ColorScheme(
        background: Colors.white,
        brightness: Brightness.light,
        error: Colors.red,
        onBackground: Colors.black87,
        onError: Colors.red,
        onSurface: Colors.black87,
        onSecondary: Colors.black87,
        onPrimary: Colors.black,
        primary: theme.accentColor,
        primaryVariant: theme.accentColor,
        secondary: Colors.black,
        secondaryVariant: Colors.black,
        surface: Colors.white,
      ),
    );

    return CustomSafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: <Widget>[
            LayoutBuilder(
              builder: (ctx, constraints) => Container(
                width: double.infinity,
                height: constraints.maxHeight - 67.0,
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              'Check Back With Us',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Flexible(
                          child: Text(
                            'Set a time today to spend your ${_problem.noun} credits by and check back in with us! We’ll help to re-evaluate your ${_problem.noun} levels again.',
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.loose,
                              child: FittedBox(
                                child: Text(
                                  'Set a Time Today',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        EmojiButton(
                          emoji: '📅',
                          title: _formatTimeOfDay(_scheduledTime),
                          subtitle: 'Select to change time',
                          enableSubtitle: true,
                          onPressed: () async {
                            try {
                              final selectedTime = await showTimePicker(
                                context: context,
                                builder: (ctx, child) => Theme(
                                  data: _timePickerThemeData,
                                  child: child,
                                ),
                                initialTime: _scheduledTime,
                              );

                              if (selectedTime == null) return;

                              if (selectedTime.hour < TimeOfDay.now().hour ||
                                  (selectedTime.hour == TimeOfDay.now().hour &&
                                      selectedTime.minute <=
                                          TimeOfDay.now().minute + 5)) {
                                final minimumTimeOfDay = _formatTimeOfDay(
                                    TimeOfDay(
                                        hour: TimeOfDay.now().hour,
                                        minute: TimeOfDay.now().minute + 5));
                                showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    title: Text('Oops!'),
                                    content: Text(
                                        'Please schedule for a time past $minimumTimeOfDay today.'),
                                    actions: <Widget>[
                                      FlatButton(
                                        textColor: theme.accentColor,
                                        child: Text('Okay'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                setState(() {
                                  _scheduledTime = selectedTime;
                                });
                              }
                            } catch (err) {
                              showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text(
                                    'Oops!',
                                  ),
                                  content:
                                      Text('An unexpected error occurred!'),
                                  actions: <Widget>[
                                    FlatButton(
                                      textColor: theme.accentColor,
                                      child: Text(
                                        'Okay',
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ActionPanel(
                title: 'Start Challenge',
                onPressed: () {
                  final timeNow = TimeOfDay.now();
                  final isValid = !(_scheduledTime.hour < timeNow.hour ||
                      (_scheduledTime.hour == timeNow.hour &&
                          _scheduledTime.minute <= timeNow.minute));
                  if (isValid) {
                    final dateTimeNow = DateTime.now();
                    final reminderDateTime = DateTime(
                      dateTimeNow.year,
                      dateTimeNow.month,
                      dateTimeNow.day,
                      _scheduledTime.hour,
                      _scheduledTime.minute,
                    );

                    final newChallenge = Challenge(
                      initialLevel: _actualLevel,
                      idealLevel: _idealLevel,
                      activities: _selectedActivities,
                      reward: _selectedReward,
                      remindAt: reminderDateTime,
                      problem: _problem,
                    );

                    Provider.of<Challenges>(context, listen: false)
                        .create(newChallenge)
                        .then((_) {
                      return widget.scheduleNotification(
                          reminderDateTime, 'Check In', 'Let\'s re-evaluate your ${_problem.noun} levels again!');
                    }).then((_) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/',
                        (route) => false,
                      );
                    }).catchError((err) {
                      print(err);
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('Oops!'),
                          content: Text('An unexpected error occurred!'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Okay'),
                              textColor: theme.accentColor,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                    });
                  } else {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Oops!'),
                        content: Text(
                          'It appears that you\'ve picked a time that is over, please pick another time to check back in with us.',
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Okay'),
                            textColor: theme.accentColor,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
