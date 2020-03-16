import 'package:flutter/material.dart';

import './knob_slider.dart';

class SliderQuestion extends StatelessWidget {
  final String question;
  final int min;
  final int max;
  final int initialValue;
  final bool Function(int) onChanged;

  SliderQuestion({
    @required this.question,
    @required this.min,
    @required this.max,
    @required this.initialValue,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              letterSpacing: 1.2,
            ),
          ),
        ),
        KnobSlider(
          min: min,
          initialValue: initialValue,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
