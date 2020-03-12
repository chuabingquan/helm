import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
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
                color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
