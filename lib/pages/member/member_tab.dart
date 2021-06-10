import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/provider/route.dart';
import 'package:provider/provider.dart';

class MemberTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var memberDetailIndex = context.watch<RouteProvider>().memberDetailIndex;

    return Container(
      margin: EdgeInsets.only(top: 6, bottom: 6, left: 13),
      child: Row(
        children: [
          _tab(context, '会员信息', 0, memberDetailIndex == 0),
        ],
      ),
    );
  }

  Widget _tab(BuildContext context, String title, int value, bool state) {
    return InkWell(
      onTap: () {
        context.read<RouteProvider>().changeMemberDetailIndex(value);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(13, 13, 13, 13),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: state == true
                        ? Colors.brown.shade300
                        : Colors.transparent))),
        child: Text(title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(13), color: Colors.brown)),
      ),
    );
  }
}
