import 'package:flutter/material.dart';

import '../widgets/knob_slider.dart';
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
  ProblemDetails _problem;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final problemType = ModalRoute.of(context).settings.arguments as Problem;
      _problem = getProblemDetails(problemType);
      _isInit = false;
    }
  }

  Widget _buildSliderQuestion({
    @required String question,
    @required int min,
    @required int max,
    @required int initialValue,
    @required bool Function(int) onChanged,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              letterSpacing: 1.2,
            ),
          ),
        ),
        KnobSlider(
          min: min,
          initialValue: initialValue,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
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
                    child: _buildSliderQuestion(
                      question: 'How ${_problem.adjective} are you?',
                      min: 1,
                      max: 10,
                      initialValue: 1,
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
                    child: _buildSliderQuestion(
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
                onPressed: () => Navigator.of(context).pushNamed(
                  ChallengeScreen.routeName,
                  arguments: <String, dynamic>{
                    'problem': _problem,
                    'actualLevel': _selectedActualLevel,
                    'idealLevel': _selectedIdealLevel,
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
