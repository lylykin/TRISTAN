import 'package:flutter/material.dart';

class NotificationBubble extends StatelessWidget {
  final bool display;
  const NotificationBubble({super.key, required this.display});

  @override
  Widget build(BuildContext context) {
    if (display) {
      return Positioned(
        right: 0,
        child: Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(6),
          ),
          constraints: BoxConstraints(
            minWidth: 12,
            minHeight: 12,
          ),
          child: Icon(Icons.plus_one, size: 9)
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}