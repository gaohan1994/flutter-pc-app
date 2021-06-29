import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * ---- 
 * 
 * 页面级别的组件
 * 
 * ----
 */

enum FilterDirection {
  down,
  up,
}

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem(
      {Key? key,
      required this.title,
      required this.value,
      this.onPressed,
      this.direction = FilterDirection.down,
      this.selected = false})
      : super(key: key);

  final String title;
  final String value;
  // 方向
  final FilterDirection? direction;
  final bool selected;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    Widget _current = selected
        ? direction == FilterDirection.down
            ? Image(
                width: 7.w,
                height: 10.w,
                image: AssetImage('assets/icon_jiangxu.png'))
            : Image(
                width: 7.w,
                height: 10.w,
                image: AssetImage('assets/icon_paixu.png'))
        : Image(
            width: 7.w,
            height: 10.w,
            image: AssetImage('assets/icon_moren_paixu.png'));

    return Expanded(
        child: InkWell(
      onTap: () {
        onPressed!(value);
      },
      child: Container(
        height: 25.w,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: selected ? Colors.blue : Colors.black12)),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(color: selected ? Colors.blue : Colors.black)),
            Container(
              margin: EdgeInsets.only(left: 10.w),
              child: _current,
            ),
          ],
        ),
      ),
    ));
  }
}

class DetailCartItem {
  DetailCartItem(this.title, this.value);
  String title;
  String value;
  Color? color;
}

@immutable
class DetailCard extends StatelessWidget {
  const DetailCard({
    Key? key,
    required this.img,
    required this.title,
    required this.subTitle,
    this.items = const [],
    this.icon,
    this.neticon,
    this.tags,
  }) : super(key: key);

  final String img;
  final String title;
  final String subTitle;
  final List<DetailCartItem> items;
  final List<Widget>? tags;
  final String? icon;
  final String? neticon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: 160.w,
      padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(img),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 13),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: Row(
              children: [
                icon != null
                    ? Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Image(
                            width: 54.w,
                            height: 54.w,
                            image: AssetImage(icon!)),
                      )
                    : Container(),
                neticon != null
                    ? Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Image.network(
                          neticon!,
                          width: 54.w,
                          height: 54.w,
                        ),
                      )
                    : Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(13),
                              color: Colors.white),
                        ),
                        tags != null && tags!.isNotEmpty
                            ? Row(
                                children: tags!,
                              )
                            : Container()
                      ],
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(13),
                          color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(children: items.map((e) => _buildCardItem(e)).toList()),
          )
        ],
      ),
    );
  }

  Widget _buildCardItem(DetailCartItem item) {
    return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1, color: Colors.black12))),
          child: Column(
            children: [
              Text(
                item.title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(13), color: Colors.white70),
              ),
              Text(
                item.value,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(14), color: Colors.white),
              )
            ],
          ),
        ));
  }
}
