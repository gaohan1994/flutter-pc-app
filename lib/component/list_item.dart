import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/component/product_tag.dart';
import 'package:pc_app/model/member.dart';
import 'package:pc_app/model/order.dart';
import 'package:pc_app/provider/member.dart';
import 'package:pc_app/provider/order.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String detail;
  final String suffix;
  final bool selected;
  final Function? onPress;
  final String? img;
  final List<Widget>? tags;

  ListItem(
      {this.title = '',
      this.detail = '',
      this.suffix = '',
      this.selected = false,
      this.img,
      this.onPress,
      this.tags = const []});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress!();
      },
      child: Container(
        height: 60.h,
        padding: EdgeInsets.all(6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: selected ? Colors.blue.shade50 : Colors.transparent,
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
                    image: AssetImage(img ?? 'assets/icon_alipay.png'),
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
                        Text('${title}',
                            style: TextStyle(fontSize: ScreenUtil().setSp(12))),
                        Row(
                          children: tags!,
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text('${detail}',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(11),
                              color: Colors.black45)),
                    ),
                  ],
                )
              ],
            ),
            Text('${suffix}',
                style: TextStyle(fontSize: ScreenUtil().setSp(13))),
          ],
        ),
      ),
    );
  }
}

class MemberItem extends StatelessWidget {
  MemberItem({required this.item});

  final Member item;

  @override
  Widget build(BuildContext context) {
    // 判断当前订选中
    var selectedId = context.watch<MemberProvider>().selectedId;
    bool currentOrderSelected = item.id == selectedId;

    // 点击订单触发请求详情函数
    var onPressedHandle = context.read<MemberProvider>().changeSelectedMember;

    Widget itemTag =
        ProductTag(name: item.levelName, color: Colors.orange.shade200);
    // 订单退货标记

    return ListItem(
      onPress: () => onPressedHandle(item),
      selected: currentOrderSelected,
      title: item.username,
      tags: [itemTag],
      detail: item.phone,
      suffix: '￥${item.totalAmount}',
      img: 'assets/huiyuan_user.png',
    );
  }
}

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

    return ListItem(
      onPress: () => onPressedHandle(item),
      selected: currentOrderSelected,
      title: item.orderNo,
      tags: [orderTransflagTag, orderRefundTag],
      detail: item.createTime,
      suffix: '￥${item.amt}',
    );
  }
}
