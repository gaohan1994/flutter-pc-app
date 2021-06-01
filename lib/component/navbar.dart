/* 导航栏
 * @Author: centerm.gaohan 
 * @Date: 2021-05-26 11:16:47 
 * @Last Modified by: centerm.gaohan
 * @Last Modified time: 2021-05-26 15:25:13
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/model/route.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  // appbar 高度
  final appbarHeight = ScreenUtil().setWidth(38);

  @override
  Size get preferredSize => getSize();

  Size getSize() {
    return Size(appbarHeight, appbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    // 创建导航栏的按钮
    final List iconButtonsActionsList = [
      {"title": '收银台', "type": 0, "icon": Icons.ac_unit},
      {"title": '订单', "type": 1, "icon": Icons.baby_changing_station},
      {"title": '会员', "type": 2, "icon": Icons.cabin},
      {"title": '退货', "type": 3, "icon": Icons.dangerous},
      {"title": '进销存', "type": 4, "icon": Icons.e_mobiledata},
      {"title": '更多', "type": 5, "icon": Icons.face},
    ];

    return AppBar(
      title: Row(
        children: [
          Expanded(
              flex: 1,
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 38),
                  child: const Text(
                    '星亿腾',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                  children: iconButtonsActionsList
                      .map((item) => navButton(context, item))
                      .toList(),
                )
              ])),
          Expanded(flex: 0, child: _buildUser())
        ],
      ),
    );
  }

  @override
  Widget navButton(BuildContext context, item) {
    // 从provider 拿到当前的路由地址
    final routeInex = context.watch<RouteProvider>().index;

    // 判断路由是否选中
    final selected = item['type'] == routeInex;

    return InkWell(
      onTap: () => context.read<RouteProvider>().changeIndex(item['type']),
      child: Container(
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setWidth(appbarHeight),
        padding: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
            color: selected ? Colors.blueAccent.shade400 : Colors.blue,
            border: Border(
              top: BorderSide(
                  width: 6, color: selected ? Colors.orange : Colors.blue),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              item['icon'],
              size: ScreenUtil().setWidth(14),
            ),
            Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(
                item['title'],
                style: TextStyle(fontSize: ScreenUtil().setSp(13)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 右上角用户模块
  Widget _buildUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 12),
          margin: const EdgeInsets.only(right: 12),
          decoration: const BoxDecoration(
              border: Border(right: BorderSide(width: 1, color: Colors.white))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.chevron_right_sharp,
                size: ScreenUtil().setWidth(14),
              ),
              Container(
                margin: const EdgeInsets.only(left: 4),
                child: Text(
                  '进入后台',
                  style: TextStyle(fontSize: ScreenUtil().setSp(13)),
                ),
              ),
            ],
          ),
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '马来进口便利店',
              style: TextStyle(fontSize: ScreenUtil().setSp(11)),
            ),
            Row(
              children: [
                Icon(
                  Icons.supervised_user_circle,
                  size: ScreenUtil().setWidth(12),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  child: Text(
                    '陈先生',
                    style: TextStyle(fontSize: ScreenUtil().setSp(11)),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}