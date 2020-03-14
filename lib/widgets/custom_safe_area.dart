import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;
  final Color color;

  CustomSafeArea({
    @required this.child,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: double.infinity,
      child: SafeArea(
        top: false,
        bottom: true,
        child: child,
      ),
    );
  }
}
