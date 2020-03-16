import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_safe_area.dart';
import '../widgets/action_panel.dart';
import '../widgets/knob_slider.dart';
import '../models/challenge.dart';
import '../providers/challenges.dart';
import './triage_screen.dart';

class ReviewScreen extends StatefulWidget {
  static const routeName = '/review';

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  var _isInit = true;
  Challenge _challenge;
  var _updatedLevel = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _challenge = ModalRoute.of(context).settings.arguments as Challenge;
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
                              'Review',
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
                            'Please rate your ${_challenge.problem.noun} levels after having spent your ${_challenge.problem.noun} credits.',
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          KnobSlider(
                            min: 0,
                            max: 10,
                            initialValue: 0,
                            onChanged: (value) {
                              _updatedLevel = value;
                              return true;
                            },
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
                onPressed: () async {
                  try {
                    await Provider.of<Challenges>(context, listen: false)
                        .endChallenge(_challenge.id, _updatedLevel);

                    var dialogMessage = '';
                    var dialogActions = <Widget>[];
                    final okayButton = FlatButton(
                      child: Text('Okay'),
                      textColor: theme.accentColor,
                      onPressed: () =>
                          Navigator.of(context).pushNamedAndRemoveUntil(
                        '/',
                        (route) => false,
                      ),
                    );
                    final tryAgainButton = FlatButton(
                      child: Text('Try Again'),
                      textColor: theme.accentColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed(
                          TriageScreen.routeName,
                          arguments: <String, dynamic>{
                            'problem': _challenge.problem.type,
                            'initialLevel': _updatedLevel,
                          },
                        );
                      },
                    );
                    final takeABreakButton = FlatButton(
                      child: Text('Take a Break'),
                      textColor: theme.accentColor,
                      onPressed: () =>
                          Navigator.of(context).pushNamedAndRemoveUntil(
                        '/',
                        (route) => false,
                      ),
                    );

                    if (_updatedLevel < 1) {
                      dialogMessage =
                          'Congratulations on getting your ${_challenge.problem.noun} levels down to zero! You rock 🤘';
                      dialogActions.add(okayButton);
                    } else if (_updatedLevel < _challenge.idealLevel) {
                      dialogMessage =
                          'Your ${_challenge.problem.noun} level seems better than ideal, keep up the good work!';
                      dialogActions.addAll([takeABreakButton, tryAgainButton]);
                    } else if (_updatedLevel == _challenge.idealLevel) {
                      dialogMessage =
                          'Good job spending all your ${_challenge.problem.noun} credits, you\'re getting better!';
                      dialogActions.addAll([takeABreakButton, tryAgainButton]);
                    } else if (_updatedLevel > _challenge.idealLevel &&
                        _updatedLevel < _challenge.initialLevel) {
                      dialogMessage =
                          'Don\'t give up, you made great effort spending your ${_challenge.problem.noun} credits!';
                      dialogActions.addAll([takeABreakButton, tryAgainButton]);
                    } else if (_updatedLevel < 7) {
                      dialogMessage =
                          'We take some steps forward, some steps backwards, but most importantly, we\'re progressing!';
                      dialogActions.addAll([takeABreakButton, tryAgainButton]);
                    } else {
                      dialogMessage =
                          'Progress takes time, you\'re putting in effort and that\'s all that matters! Do talk to someone if your ${_challenge.problem.noun} persists 💪';
                      dialogActions.addAll([takeABreakButton, tryAgainButton]);
                    }

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (ctx) => AlertDialog(
                        title: Text('Review'),
                        content: Text(
                          dialogMessage,
                          style: TextStyle(
                            height: 1.3,
                          ),
                        ),
                        actions: dialogActions,
                      ),
                    );
                  } catch (err) {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Oops!'),
                        content: Text('An unexpected error occurred.'),
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
