import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_safe_area.dart';
import '../widgets/action_panel.dart';
import '../widgets/emoji_button.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule';

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  TimeOfDay _scheduledTime = TimeOfDay(
    hour: TimeOfDay.now().hour + 1,
    minute: TimeOfDay.now().minute,
  );

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
                            'Set a time today to spend your stress credits by and check back in with us! We’ll help to re-evaluate your stress levels again.',
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
