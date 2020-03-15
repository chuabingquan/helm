import 'package:flutter/material.dart';

import '../widgets/action_panel.dart';
import '../widgets/custom_safe_area.dart';
import '../widgets/emoji_button.dart';
import '../screens/schedule_screen.dart';

class RewardScreen extends StatelessWidget {
  static const routeName = '/reward';

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
                            'We encourage you to pick a reward to award yourself with after you’ve spent your stress credits. This would reinforce the positive habit of dealing with stress in an actionable manner.',
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
                              itemCount: 50,
                              itemBuilder: (ctx, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
                                child: EmojiButton(
                                  emoji: '🏃',
                                  title: 'Go for a 1/2 hour jog',
                                  enableSubtitle: true,
                                  subtitle: '2 Stress Credits',
                                  onPressed: () {},
                                ),
                              ),
                            ),
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
                onPressed: () => Navigator.of(context).pushNamed(
                  ScheduleScreen.routeName,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
