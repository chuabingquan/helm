import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final double height;
  final bool enableSubtitle;
  final Function onPressed;

  EmojiButton({
    @required this.emoji,
    @required this.title,
    this.subtitle = '',
    this.height = 55.0,
    this.enableSubtitle = false,
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
            enableSubtitle
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      )
                    ],
                  )
                : Text(
                    title,
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
