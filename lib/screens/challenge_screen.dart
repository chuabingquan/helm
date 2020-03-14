import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/action_panel.dart';
import '../widgets/emoji_button.dart';

class ChallengeScreen extends StatelessWidget {
  static const routeName = '/challenge';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
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
                        'Your extra stress is converted into credits.',
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
                          'Current Stress - Ideal Stress \n= Stress Credits',
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
                        'Your objective is to spend all of it to bring your current stress level down to an ideal level before the day ends.',
                        style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
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
                              '3 Stress Credits',
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9.0,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
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
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActionPanel(
              title: 'Next',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
