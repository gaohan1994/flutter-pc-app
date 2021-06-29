import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorItem extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final String detail;
  final TextStyle detailStyle;
  final Color color;
  final EdgeInsets padding;

  ColorItem({
    this.title = '',
    this.detail = '',
    this.titleStyle = const TextStyle(color: Colors.white, fontSize: 13),
    this.detailStyle = const TextStyle(color: Colors.white),
    required this.color,
    this.padding = const EdgeInsets.fromLTRB(14, 11, 14, 11),
  });

  @override
  Widget build(BuildContext conetxt) {
    return Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.only(right: 4),
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: titleStyle),
              Text(detail, style: detailStyle),
            ],
          ),
        ));
  }
}
