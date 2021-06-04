import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/component/product_tag.dart';
import 'package:pc_app/model/order.dart';
import 'package:pc_app/provider/order.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  OrderItem({required this.item});

  final Order item;

  @override
  Widget build(BuildContext context) {
    // 判断当前订单是否是选中的订单
    var selectedOrderId = context.watch<OrderPageProvider>().selectedOrderId;
    bool currentOrderSelected = item.orderNo == selectedOrderId;

    // 点击订单触发请求详情函数
    var onPressedHandle = context.read<OrderPageProvider>().changeSelectedOrder;

    Widget orderTransflagTag = SizedBox.shrink();
    if (item.transFlag < 0) {
      orderTransflagTag = ProductTag(
          name: OrderPageProvider.getOrderStatus(item.transFlag),
          color: item.transFlag == -1 ? Colors.red : Colors.orange);
    }

    // 订单退货标记
    Widget orderRefundTag = SizedBox.shrink();
    if (item.refundStatus != 0) {
      orderRefundTag = ProductTag(
          name: OrderPageProvider.getOrderRefundStatus(item.refundStatus),
          color: item.refundStatus == 1 ? Colors.blue.shade300 : Colors.blue);
    }

    return InkWell(
      onTap: () {
        onPressedHandle(item);
      },
      child: Container(
        height: 60.h,
        padding: EdgeInsets.all(6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: currentOrderSelected ? Colors.blue.shade50 : Colors.white,
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
                            child: orderTransflagTag),
                        Container(
                            margin: EdgeInsets.only(left: 6),
                            child: orderRefundTag)
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
