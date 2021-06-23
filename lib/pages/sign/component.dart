import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundView extends StatelessWidget {
  BackgroundView({required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 960.w,
      height: 540.h,
      child: child,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/Background_login.png'))),
    );
  }
}
