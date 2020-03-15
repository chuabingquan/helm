import 'package:flutter/material.dart';

class ActionPanel extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color panelColor;
  final bool enableDivider;

  ActionPanel({
    @required this.title,
    @required this.onPressed,
    this.panelColor = Colors.white,
    this.enableDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 11.0,
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        color: panelColor,
        boxShadow: enableDivider
            ? <BoxShadow>[
                BoxShadow(
                  blurRadius: 3.0,
                  offset: Offset(0.0, -4.0),
                  color: Colors.grey.shade100,
                ),
              ]
            : null,
      ),
      width: double.infinity,
      child: ButtonTheme(
        height: 45,
        child: FlatButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.5),
          ),
          color: theme.accentColor,
          textColor: Colors.white,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
