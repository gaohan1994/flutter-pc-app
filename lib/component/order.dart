import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/component/product_tag.dart';
import 'package:pc_app/model/order.dart';

class OrderItem extends StatelessWidget {
  OrderItem({required this.item});

  final Order item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60.h,
        padding: EdgeInsets.all(6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 6),
                  child: Image(
                    image: const AssetImage('assets/icon_alipay.png'),
                    width: 22.w,
                    height: 22.w,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(item.orderNo,
                            style: TextStyle(fontSize: ScreenUtil().setSp(12))),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          child: ProductTag(name: '全部退货', color: Colors.orange),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(item.createTime,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(11),
                              color: Colors.black45)),
                    ),
                  ],
                )
              ],
            ),
            Text('￥${item.amt}',
                style: TextStyle(fontSize: ScreenUtil().setSp(13))),
          ],
        ),
      ),
    );
  }
}
