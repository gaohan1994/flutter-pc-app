import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyView extends StatelessWidget {
  final String emptyText;

  EmptyView({this.emptyText = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image(
            width: 190.w,
            height: 190.w,
            image: AssetImage('assets/img_no_goods.png'),
          ),
          emptyText != null
              ? Text(emptyText,
                  style: TextStyle(
                      color: Colors.black45, fontSize: ScreenUtil().setSp(12)))
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
