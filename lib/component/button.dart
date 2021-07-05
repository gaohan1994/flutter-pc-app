import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GhButton extends StatelessWidget {
  GhButton({
    required this.title,
    required this.onPressed,
    this.width = 140,
    this.height = 40,
    this.outlined = false,
  });

  final String title;
  final Function onPressed;
  final int width;
  final int height;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = OutlinedButton.styleFrom(
        side: const BorderSide(width: 1, color: Colors.blue));

    return Container(
      height: ScreenUtil().setHeight(height),
      width: ScreenUtil().setWidth(width),
      margin: const EdgeInsets.only(right: 6),
      child: outlined == true
          ? OutlinedButton(
              style: buttonStyle,
              onPressed: () {
                onPressed();
              },
              child: Text(title),
            )
          : ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                onPressed();
              },
              child: Text(title),
            ),
    );
  }
}
