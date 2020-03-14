import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/emoji_button.dart';
import '../screens/triage_screen.dart';
import '../widgets/custom_safe_area.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4.0,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/yoga.svg',
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          child: FittedBox(
                            child: Text(
                              'I\'m feeling . . .',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 2.0,
                  ),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      EmojiButton(
                        height: 50.0,
                        emoji: '😰',
                        title: 'Anxious',
                        onPressed: () => Navigator.of(context).pushNamed(
                          TriageScreen.routeName,
                        ),
                      ),
                      EmojiButton(
                        height: 50.0,
                        emoji: '😫',
                        title: 'Stressed',
                        onPressed: () {},
                      ),
                      EmojiButton(
                        height: 50.0,
                        emoji: '😞',
                        title: 'Depressed',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
