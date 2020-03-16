import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/emoji_button.dart';
import '../widgets/custom_safe_area.dart';
import '../widgets/action_panel.dart';
import '../models/challenge.dart';

class CheckBackScreen extends StatelessWidget {
  static const routeName = '/check-back';
  final Challenge challenge;

  CheckBackScreen({
    @required this.challenge,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            LayoutBuilder(
                builder: (ctx, constraints) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(80.0, 0.0, 0.0, 30.0),
                      height: constraints.maxHeight - 67.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: SvgPicture.asset(
                              'assets/images/drive.svg',
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                        ],
                      ),
                    )),
            LayoutBuilder(
              builder: (ctx, constraints) => Container(
                width: double.infinity,
                height: constraints.maxHeight - 67.0,
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                // color: theme.primaryColor,
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
                              'Objective',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Flexible(
                          child: Text(
                            'Spend ${challenge.initialLevel - challenge.idealLevel} stress credits on',
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
                    Expanded(
                      child: ListView.builder(
                          itemCount: challenge.activities.length,
                          itemBuilder: (ctx, index) {
                            final activity =
                                challenge.activities.toList()[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: EmojiButton(
                                emoji: activity.emoji,
                                title: activity.name,
                                enableSubtitle: true,
                                subtitle: '${activity.credits} Stress Credits',
                                backgroundColor: Colors.white,
                                outlineColor: Colors.white,
                                onPressed: () {},
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ActionPanel(
                title: 'I\'m Done!',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
