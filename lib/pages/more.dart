import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/route/application.dart';

class MoreItem {
  MoreItem(this.title, this.icon);
  String title;
  String icon;
}

class MorePage extends StatefulWidget {
  @override
  createState() => _MorePage();
}

class _MorePage extends State<MorePage> {
  void onItemPress(MoreItem item) {
    if (item.title == '商品') {
      print('sp');
      Application.router?.navigateTo(context, '/product');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MoreItem> _items1 = [MoreItem('商品', 'assets/icon_more_shop.png')];

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(20.w, 22.w, 20.w, 22.w),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSection('商品', _items1),
        ],
      ),
    ));
  }

  Widget _buildSection(title, List<MoreItem> items) {
    return Container(
      alignment: Alignment.topLeft,
      width: 910.w,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.w),
            decoration: BoxDecoration(
                border:
                    Border(left: BorderSide(width: 1, color: Colors.black38))),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(13), color: Colors.black38),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 21.w),
            child: Wrap(
              children: items
                  .map((item) => InkWell(
                        onTap: () {
                          onItemPress(item);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.black12)),
                            alignment: Alignment.center,
                            width: 100.w,
                            height: 30.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 4.w),
                                  child: Image(
                                      width: 13.w,
                                      height: 13.w,
                                      image: AssetImage(item.icon)),
                                ),
                                Text(item.title,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(13),
                                        color: Colors.black38))
                              ],
                            )),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
