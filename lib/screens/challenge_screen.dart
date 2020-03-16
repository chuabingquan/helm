import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/action_panel.dart';
import '../widgets/emoji_button.dart';
import '../widgets/custom_safe_area.dart';
import './reward_screen.dart';
import '../models/activity.dart';
import '../providers/activities.dart';

class ChallengeScreen extends StatefulWidget {
  static const routeName = '/challenge';

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  var _isInit = true;
  ProblemDetails _problem;
  int _actualLevel;
  int _idealLevel;
  Set<Activity> _selectedActivities = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final params =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      _problem = params['problem'] as ProblemDetails;
      _actualLevel = params['actualLevel'] as int;
      _idealLevel = params['idealLevel'] as int;

      _isInit = false;
    }
  }

  // Use only for non-empty strings.
  String _capitaliseFirstChar(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final equationProblemWord = _capitaliseFirstChar(_problem.noun);
    final activities =
        Provider.of<Activities>(context, listen: false).activities;

    return CustomSafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
          // title: Text('Challenge'),
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
                              'The Challenge',
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
                            'Your extra ${_problem.noun} is converted into credits.',
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14.0,
                        ),
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Current $equationProblemWord - Ideal $equationProblemWord \n= $equationProblemWord Credits',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono().copyWith(
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14.0,
                        ),
                        Flexible(
                          child: Text(
                            'Your objective is to spend all of it to bring your current ${_problem.noun} level down to an ideal level before the day ends.',
                            style: const TextStyle(
                              fontSize: 14.0,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: FittedBox(
                                  child: Text(
                                    'Spend Credits On',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: FittedBox(
                                  child: Text(
                                    '${_actualLevel - _idealLevel} $equationProblemWord Credits',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Flexible(
                            child: ListView.builder(
                                itemCount: activities.length,
                                itemBuilder: (ctx, index) {
                                  final activity = activities[index];
                                  final isSelected = _selectedActivities
                                          .where((a) => a.id == activity.id)
                                          .length >
                                      0;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4.0,
                                    ),
                                    child: EmojiButton(
                                        emoji: activity.emoji,
                                        title: activity.name,
                                        enableSubtitle: true,
                                        backgroundColor: isSelected
                                            ? Colors.greenAccent.shade100
                                            : null,
                                        outlineColor: isSelected
                                            ? Colors.greenAccent.shade200
                                            : null,
                                        subtitle:
                                            '${activity.credits} $equationProblemWord Credits',
                                        onPressed: () {
                                          if (isSelected) {
                                            setState(() {
                                              _selectedActivities.removeWhere(
                                                (a) => a.id == activity.id,
                                              );
                                            });
                                          } else {
                                            var selectedCredits = 0;

                                            if (_selectedActivities
                                                .isNotEmpty) {
                                              selectedCredits =
                                                  _selectedActivities.fold(
                                                0,
                                                (acc, a) => acc + a.credits,
                                              );
                                            }

                                            if ((selectedCredits +
                                                    activity.credits) <=
                                                (_actualLevel - _idealLevel)) {
                                              setState(() {
                                                _selectedActivities
                                                    .add(activity);
                                              });
                                            } else {
                                              showDialog(
                                                context: context,
                                                child: AlertDialog(
                                                  title: Text('Oops!'),
                                                  content: Text(
                                                    'You do not have sufficient ${_problem.noun} credits left.',
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      textColor:
                                                          theme.accentColor,
                                                      child: Text('Okay'),
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          }
                                        }),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ActionPanel(
                title: 'Next',
                onPressed: () {
                  var isValid = !(_selectedActivities.isEmpty ||
                      _selectedActivities.fold(
                              0, (acc, a) => acc + a.credits) !=
                          _actualLevel - _idealLevel);

                  if (isValid) {
                    Navigator.of(context).pushNamed(
                      RewardScreen.routeName,
                      arguments: <String, dynamic>{
                        'problem': _problem,
                        'actualLevel': _actualLevel,
                        'idealLevel': _idealLevel,
                        'activities': _selectedActivities,
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Oops!'),
                        content: Text(
                          'It appears that you have not utilised all your ${_problem.noun} credits yet.',
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Okay'),
                            textColor: theme.accentColor,
                            onPressed: () => Navigator.of(context).pop(),
                          )
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
