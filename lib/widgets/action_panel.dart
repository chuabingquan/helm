import 'package:flutter/material.dart';

class ActionPanel extends StatelessWidget {
  final String title;
  final Function onPressed;

  ActionPanel({
    @required this.title,
    @required this.onPressed,
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
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 3.0,
            offset: Offset(0.0, -4.0),
            color: Colors.grey.shade100,
          ),
        ],
      ),
      width: double.infinity,
      child: ButtonTheme(
        height: 45,
        child: FlatButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
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
