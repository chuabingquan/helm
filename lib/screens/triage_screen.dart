import 'package:flutter/material.dart';

class TriageScreen extends StatelessWidget {
  static const routeName = '/triage';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0.0,
      ),
      body: Container(),
    );
  }
}
