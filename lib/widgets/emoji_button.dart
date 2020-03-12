import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  final String emoji;
  final String text;
  final double height;
  final Function onPressed;

  EmojiButton({
    @required this.emoji,
    @required this.text,
    this.height = 55.0,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: height,
      child: OutlineButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        borderSide: BorderSide(
          color: Colors.grey.shade100,
        ),
        highlightColor: Colors.grey.shade100,
        highlightedBorderColor: Colors.grey.shade100,
        child: Row(
          children: <Widget>[
            Text(
              emoji,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
