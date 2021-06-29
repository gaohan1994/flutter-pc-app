import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentItem extends StatelessWidget {
  final String title;
  final String value;
  Widget? child;

  ContentItem({required this.title, this.value = '', this.child});

  Widget build(BuildContext context) {
    Widget current = child != null
        ? child!
        : Text(value,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(12), color: Colors.black));

    return Container(
      margin: EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(12), color: Colors.black38)),
          current,
        ],
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 18, 20, 0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: child != null ? child : SizedBox.shrink(),
    );
  }

  static Widget buildSection({List<Widget> items = const []}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items
            .map((item) => Container(
                  width: 200.w,
                  child: item,
                ))
            .toList());
  }
}
