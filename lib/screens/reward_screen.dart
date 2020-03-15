import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/action_panel.dart';
import '../widgets/custom_safe_area.dart';
import '../widgets/emoji_button.dart';
import '../screens/schedule_screen.dart';
import '../models/activity.dart';
import '../models/reward.dart';
import '../providers/rewards.dart';

class RewardScreen extends StatefulWidget {
  static const routeName = '/reward';

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  var _isInit = true;
  ProblemDetails _problem;
  int _actualLevel;
  int _idealLevel;
  Set<Activity> _selectedActivities = {};
  Reward _selectedReward;

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

      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rewards = Provider.of<Rewards>(context, listen: false).rewards;

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
                              'Reward',
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
                            'We encourage you to pick a reward to award yourself with after you’ve spent your ${_problem.noun} credits. This would reinforce the positive habit of dealing with ${_problem.noun} in an actionable manner.',
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
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.loose,
                                child: FittedBox(
                                  child: Text(
                                    'Pick a Reward',
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
                          Flexible(
                            child: ListView.builder(
                                itemCount: rewards.length,
                                itemBuilder: (ctx, index) {
                                  final reward = rewards[index];
                                  final isSelected = _selectedReward != null &&
                                      reward.id == _selectedReward.id;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4.0,
                                    ),
                                    child: EmojiButton(
                                      emoji: reward.emoji,
                                      title: reward.name,
                                      backgroundColor: isSelected
                                          ? Colors.greenAccent.shade100
                                          : null,
                                      outlineColor: isSelected
                                          ? Colors.greenAccent.shade200
                                          : null,
                                      onPressed: () {
                                        setState(() {
                                          _selectedReward = reward;
                                        });
                                      },
                                    ),
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
                    if (_selectedReward != null) {
                      Navigator.of(context).pushNamed(
                        ScheduleScreen.routeName,
                        arguments: <String, dynamic>{
                          'problem': _problem,
                          'actualLevel': _actualLevel,
                          'idealLevel': _idealLevel,
                          'activities': _selectedActivities,
                          'reward': _selectedReward,
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('Oops!'),
                          content: Text(
                            'Positive reinforcement is important for making a good habit of dealing with ${_problem.noun} in an actionable manner. Please pick a reward!',
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
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
