import 'package:flutter/material.dart';

class KnobSlider extends StatefulWidget {
  final int min;
  final int max;
  final int initialValue;
  final bool Function(int) onChanged;

  KnobSlider({
    @required this.min,
    @required this.max,
    this.initialValue = 0,
    @required this.onChanged,
  });

  @override
  _KnobSliderState createState() => _KnobSliderState();
}

class _KnobSliderState extends State<KnobSlider> {
  var _isInit = true;
  double _sliderValue = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _sliderValue = widget.initialValue.toDouble();
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.min.toInt().toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            letterSpacing: 1.2,
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.grey.shade200,
              inactiveTrackColor: Colors.grey.shade100,
              trackHeight: 9.0,
              thumbColor: theme.accentColor,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 15.0,
                disabledThumbRadius: 15.0,
              ),
              overlayColor: theme.accentColor.withAlpha(32),
              inactiveTickMarkColor: Colors.grey.shade200,
              valueIndicatorColor: theme.accentColor.withOpacity(0.95),
            ),
            child: Slider(
              min: widget.min.toDouble(),
              max: widget.max.toDouble(),
              value: _sliderValue,
              divisions: widget.max,
              label: _sliderValue.floor().toString(),
              onChanged: (value) {
                if (widget.onChanged(value.toInt())) {
                  setState(() {
                    _sliderValue = value;
                  });
                }
              },
            ),
          ),
        ),
        Text(
          widget.max.toInt().toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
