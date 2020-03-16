import 'package:flutter/material.dart';

import '../widgets/slider_question.dart';
import '../widgets/action_panel.dart';
import '../widgets/custom_safe_area.dart';
import '../screens/challenge_screen.dart';
import '../models/activity.dart';

class TriageScreen extends StatefulWidget {
  static const routeName = '/triage';

  @override
  _TriageScreenState createState() => _TriageScreenState();
}

class _TriageScreenState extends State<TriageScreen> {
  var _selectedActualLevel = 1;
  var _selectedIdealLevel = 0;
  var _initialLevel = 1;
  ProblemDetails _problem;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final params =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      _problem = getProblemDetails(params['problem'] as Problem);
      if (params.containsKey('initialLevel')) {
        _initialLevel = params['initialLevel'] as int;
        setState(() {
          _selectedActualLevel = _initialLevel;
        });
      }
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: SliderQuestion(
                      question: 'How ${_problem.adjective} are you?',
                      min: 1,
                      max: 10,
                      initialValue: _initialLevel,
                      onChanged: (value) {
                        if (_selectedIdealLevel > value) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Oops!'),
                              content: Text(
                                  'Your ideal ${_problem.noun} level cannot be more than your actual ${_problem.noun} level.'),
                              actions: <Widget>[
                                FlatButton(
                                  textColor: theme.accentColor,
                                  child: Text(
                                    'Okay',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                )
                              ],
                            ),
                          );
                          return false;
                        } else {
                          setState(() {
                            _selectedActualLevel = value;
                          });
                          return true;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Flexible(
                    child: SliderQuestion(
                        question: 'Pick an ideal ${_problem.noun} level',
                        min: 0,
                        max: _selectedActualLevel,
                        initialValue: 0,
                        onChanged: (value) {
                          setState(() {
                            _selectedIdealLevel = value;
                          });
                          return true;
                        }),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ActionPanel(
                  title: 'Next',
                  onPressed: () {
                    if (_selectedIdealLevel >= _selectedActualLevel) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Oops!'),
                          content: Text(
                            'Please pick an ideal ${_problem.noun} level that is realistically lower than your actual ${_problem.noun} level.',
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
                    } else {
                      Navigator.of(context).pushNamed(
                        ChallengeScreen.routeName,
                        arguments: <String, dynamic>{
                          'problem': _problem,
                          'actualLevel': _selectedActualLevel,
                          'idealLevel': _selectedIdealLevel,
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
