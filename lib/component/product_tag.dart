/* 商品标签
 * @Author: centerm.gaohan 
 * @Date: 2021-05-28 11:01:22 
 * @Last Modified by:   centerm.gaohan 
 * @Last Modified time: 2021-05-28 11:01:22 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTag extends StatefulWidget {
  ProductTag({@required this.name, @required this.color});

  final name;

  final color;

  @override
  State<StatefulWidget> createState() {
    return _ProductTag();
  }
}

class _ProductTag extends State<ProductTag> {
  @override
  Widget build(BuildContext context) {
    Color tagColor;

    if (widget.color != null) {
      tagColor = widget.color;
    } else {
      tagColor = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: tagColor,
      ),
      width: ScreenUtil().setWidth(38),
      height: ScreenUtil().setHeight(12),
      child: Center(
          child: Text(widget.name,
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(9)))),
    );
  }
}
