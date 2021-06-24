import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/common/global.dart';
import 'package:pc_app/component/form/form_input.dart';
import 'package:pc_app/component/product_tag.dart';
import 'package:pc_app/model/member.dart';
import 'package:pc_app/model/order.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/provider/cart.dart';
import 'package:pc_app/route/application.dart';
import 'package:pc_app/service/order_method.dart';
import 'package:pc_app/service/service_url.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

@immutable
class CashierOrderPage extends StatefulWidget {
  const CashierOrderPage({Key? key}) : super(key: key);

  @override
  createState() => _CashierOrderPage();
}

class _CashierOrderPage extends State<CashierOrderPage> {
  int selectedPayWay = 9;

  // 原金额
  double originalAmt = 0;

  // 商品优惠
  double productDiscount = 0;

  // 整单改价去除金额
  double priceDiscount = 0;

  // 积分优惠
  double pointDiscount = 0;

  // 满减优惠
  double fullDiscount = 0;

  // 优惠券优惠
  double couponDiscount = 0;

  // 商品总数量
  double totalNum = 0;

  // cashierOrderProductInfo 订单商品信息
  List<CashierOrderProductInfo> cashierOrderProductInfo = [];

  @override
  void initState() {
    super.initState();
    // 当前选择的会员(可选)
    MemberDetail? selectedMember = context.read<CartProvider>().selectedMember;
    // 初始化结算数据
    List<ProductInfo> list = context.read<CartProvider>().cart;

    // 遍历商品
    for (int i = 0; i < list.length; i++) {
      // 当前商品的数量
      double _currentSellNum = list[i].sellNum!;

      // 按照 改价/会员价/活动价 优先级计算金额

      // 获取实际售价
      double _currentSellPrice = context
          .read<CartProvider>()
          .getCurrentProductPrice(product: list[i], member: selectedMember);

      // 如果商品改了价那么计算下商品改价之后的差额 * 数量算在商品优惠之内
      if (_currentSellPrice != list[i].price) {
        productDiscount +=
            (list[i].price - _currentSellPrice) * _currentSellNum;
      }

      // 原金额加上该商品的小计 使用商品原价
      originalAmt += _currentSellNum * list[i].price;

      // 商品总数量加上该商品的数量
      totalNum += _currentSellNum;

      // 订单商品信息报文参数中加入该商品的数据
      cashierOrderProductInfo.add(CashierOrderProductInfo(
          sellNum: _currentSellNum,
          productId: list[i].id,
          unitPrice: _currentSellPrice,
          priceChangeFlag: _currentSellPrice != list[i].price));
    }
  }

  // 结算
  void onSubmit() async {
    try {
      EasyLoading.show(status: '正在下单...');
      // 计算各种优惠后的实际收款金额
      double _amt = originalAmt;

      // 如果整单改价了 则计算改价后的金额
      if (priceDiscount != 0) {
        _amt -= priceDiscount;
      }

      // 如果商品改价了 则计算商品改价后的金额
      if (productDiscount != 0) {
        _amt -= productDiscount;
      }

      // _cashierOrderInfo 订单主信息
      CashierOrderInfo _cashierOrderInfo = CashierOrderInfo(
        amt: _amt, // 订单实际支付金额
        orderSource: 0, // 订单
        payType: selectedPayWay, // 支付方式
        totalNum: totalNum, // 商品数量
        priceDiscount: priceDiscount, // 改价
        productDiscount: productDiscount, // 商品优惠
        originalAmt: originalAmt, // 原价
      );

      // CashierOrder order 下单报文
      CashierOrder order =
          CashierOrder(false, _cashierOrderInfo, cashierOrderProductInfo);

      var result = await cashierOrder(params: order.toJson());
      var resultMap = json.decode(result.toString());

      if (resultMap['code'] != successCode) {
        throw Exception(resultMap['msg']);
      }

      var orderNo = resultMap['data']['orderNo'];

      // _cashierConfirmTransaction 创建确认订单 Transaction 的接口报文
      CashierConfirmTransaction _cashierConfirmTransaction =
          CashierConfirmTransaction(
        amt: _amt,
        orderNo: '$orderNo',
        originAmount: originalAmt,
        payType: selectedPayWay,
        terminalSn: 'DDD000000001',
        transactionStatus: 1,
        transNo: '${DateTime.now().millisecondsSinceEpoch}',
      );

      // _cashierConfirm 确认订单接口参数报文
      CashierConfirm _cashierConfirm = CashierConfirm(
          orderNo: '$orderNo',
          payType: selectedPayWay,
          thirdPartFlag: 2,
          transFlag: 3,
          isCombined: false,
          transaction: _cashierConfirmTransaction);
      var confirmResult =
          await cashierConfirm(params: _cashierConfirm.toJson());
      var confirmResultMap = json.decode(confirmResult.toString());

      if (confirmResultMap['code'] == successCode) {
        EasyLoading.dismiss();
        showToast('收款成功！');
        openResultDialog(true);
      } else {
        print('confirmResultMap: ${confirmResultMap.toString()}');
        EasyLoading.dismiss();
        openResultDialog(false);
      }
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    // list 购物车商品列表
    // List<ProductInfo> list = context.watch<CartProvider>().cart;

    double renderPrice = originalAmt;

    // 如果有改价 则减去改价金额
    if (priceDiscount != 0) {
      renderPrice -= priceDiscount;
    }

    // 如果有商品优惠则减去商品优惠
    if (productDiscount != 0) {
      renderPrice -= productDiscount;
    }

    return Row(
      children: [
        Container(
          width: 260.w,
          padding: EdgeInsets.only(left: 7.w),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 7.w),
                color: Colors.white,
                width: 245.w,
                height: 70.w,
                padding: EdgeInsets.all(12),
                child: _buildMember(),
              ),
              Container(
                child: Wrap(
                  spacing: 4.w,
                  children: [
                    _buildCard('整单改价', openPriceDiscountDialog),
                    _buildCard('抹零', openPriceDiscountDialog),
                    _buildCard('优惠券', openPriceDiscountDialog),
                    _buildCard('积分', openPriceDiscountDialog),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildText(
                        title: '应收金额', value: '￥$renderPrice', main: true),
                    _buildText(title: '原价金额', value: '￥$originalAmt'),
                    _buildText(title: '商品优惠', value: '-￥$productDiscount'),
                    _buildText(title: '改价 / 抹零', value: '-￥$priceDiscount'),
                    _buildText(title: '满减优惠', value: '0.00'),
                    _buildText(title: '优惠券', value: '0.00'),
                    _buildText(title: '积分抵现', value: '0.00'),
                  ],
                ),
              )
            ],
          ),
        ),
        VerticalDivider(),
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 13.w, bottom: 13.w, left: 18.w),
                  child: Text('支付方式', style: TextStyle(color: Colors.black45)),
                ),
                Wrap(
                  children: [
                    _buildType('扫码收款', 'assets/icon_bank.png', 0),
                    _buildType('收款码', 'assets/icon_bank.png', 1),
                    _buildType('人脸支付', 'assets/icon_renlianzhifu.png', 2),
                    _buildType('现金', 'assets/icon_bank.png', 9),
                    _buildType('会员储值卡', 'assets/icon_bank.png', 4),
                    _buildType('银行卡', 'assets/icon_bank.png', 5),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.w),
                  width: 250.w,
                  child: ElevatedButton(
                    onPressed: () => onSubmit(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        '收款',
                        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                  ),
                )
              ],
            ))
      ],
    );
  }

  Widget _buildMember() {
    // selectedMember 选中的会员
    var selectedMember = context.read<CartProvider>().selectedMember;

    if (selectedMember != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(selectedMember.username),
              ProductTag(name: selectedMember.levelName, color: Colors.orange)
            ],
          ),
          Row(
            children: [
              Text('积分  ${selectedMember.accumulativePoints}'),
              Text('储值  ${selectedMember.accumulativeMoney}'),
            ],
          )
        ],
      );
    } else {
      return InkWell(
        onTap: () {
          // 选择会员
          Global.selectMemberDialog(context, selectedMember);
        },
        child: Container(
          alignment: Alignment.center,
          width: 245.w,
          height: 70.w,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '请选择会员',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(11), color: Colors.blue),
              ),
              Text('（会员可优惠￥5.00）',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(11), color: Colors.black45))
            ],
          ),
        ),
      );
    }
  }

  Widget _buildText(
      {required String title, required String value, bool? main}) {
    final textStyle = TextStyle(
        fontSize:
            main == null ? ScreenUtil().setSp(11) : ScreenUtil().setSp(13),
        color: main == null ? Colors.black45 : Colors.red);

    return Container(
      margin: EdgeInsets.only(bottom: 13.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          Text(
            value,
            style: textStyle,
          )
        ],
      ),
    );
  }

  Widget _buildCard(title, onPressed) {
    return InkWell(
        onTap: () => onPressed(),
        child: Container(
          margin: EdgeInsets.only(top: 4.w),
          color: Colors.white,
          width: 120.w,
          height: 50.w,
          alignment: Alignment.center,
          child: Text(title),
        ));
  }

  Widget _buildType(title, icon, value) {
    bool selected = selectedPayWay == value;
    return InkWell(
      onTap: () {
        setState(() {
          selectedPayWay = value;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 5.w, bottom: 5.w),
        decoration: BoxDecoration(
          border: selected == true
              ? Border.all(width: 1, color: Colors.blue)
              : Border.all(width: 1, color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
        ),
        alignment: Alignment.center,
        width: 75.w,
        height: 70.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage(icon), width: 27.w, height: 27.w),
            Container(
              margin: EdgeInsets.only(top: 8.w),
              child: Text(title,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(11), color: Colors.black45)),
            )
          ],
        ),
      ),
    );
  }

  Future openPriceDiscountDialog() async {
    // 整单改价弹窗价格的初始值 如果商品优惠 > 0 则减去商品优惠的部分
    double _originPriceDiscountAmt = originalAmt - productDiscount;

    // 如果之前改了价。则减去之前改价的
    if (priceDiscount > 0) {
      _originPriceDiscountAmt -= priceDiscount;
    }

    // 价格
    final TextEditingController _priceController =
        TextEditingController(text: '$_originPriceDiscountAmt');

    // 折扣 计算折扣初始值: 如果改价了 那么计算改价的比例
    final TextEditingController _discountController = TextEditingController(
        text: priceDiscount > 0
            ? Global.formatNum(_originPriceDiscountAmt / originalAmt * 100, 2)
            : '100');

    final option = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(12),
              color: Colors.blue,
              child: const Text(
                '整单改价',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 17.w),
                      alignment: Alignment.centerLeft,
                      child: Text('当前金额￥300.00',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: ScreenUtil().setSp(11))),
                    ),
                    GhFormInput(
                      controller: _priceController,
                      title: '应收金额',
                      hintText: '请输入应收金额',
                      rightWidget: Text('￥'),
                      textAlign: TextAlign.end,
                      inputCallBack: (value) {
                        // _currentValue 改价价格
                        double _currentValue = double.parse(value);

                        // _currentDiscount 改价价格计算出当前折扣
                        String _currentDiscount = Global.formatNum(
                            _currentValue / originalAmt * 100, 2);
                        setState(() {
                          _discountController.text = _currentDiscount;
                        });
                      },
                    ),
                    GhFormInput(
                      title: '折扣',
                      hintText: '请输入折扣',
                      rightWidget: Text('%'),
                      textAlign: TextAlign.end,
                      controller: _discountController,
                      inputCallBack: (value) {
                        // _currentDiscount 改价折扣
                        double _currentDiscount = double.parse(value);
                        // _currentPrice 根据折扣计算出当前价格
                        String _currentPrice = Global.formatNum(
                            originalAmt * (_currentDiscount / 100), 2);
                        setState(() {
                          _priceController.text = _currentPrice;
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setWidth(30),
                            child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('取消')),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setWidth(30),
                            child: ElevatedButton(
                                onPressed: () =>
                                    {Navigator.pop(context, 'confirm')},
                                child: Text('确定')),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });

    if (option == 'confirm') {
      // dialogPrice 点击确定时输入框的值
      double dialogPrice = double.parse(_priceController.text);
      if (dialogPrice != _originPriceDiscountAmt) {
        // 用户点击确定，计算价格，如果改价 > 0 则赋值给改价优惠
        setState(() {
          priceDiscount = double.parse(
              Global.formatNum(_originPriceDiscountAmt - dialogPrice, 2));
        });
      }
      // setState(() {
      //   priceDiscount = double.parse(Global.formatNum(
      //       originalAmt - double.parse(_priceController.text), 2));
      // });
    }
  }

  Future openResultDialog(bool result) async {
    final option = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(12),
              color: Colors.blue,
              child: Text(
                result == true ? '收款成功' : '收款失败',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Image(
                        width: 280.w,
                        height: 126.w,
                        image: AssetImage('assets/img_payment_success.png')),
                    Text(result == true ? '收款成功' : '收款失败',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(11),
                            color: Colors.black45)),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: result == true
                            ? [
                                Container(
                                  width: ScreenUtil().setWidth(100),
                                  height: ScreenUtil().setWidth(30),
                                  child: ElevatedButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'confirm'),
                                      child: Text('继续收银')),
                                ),
                              ]
                            : [
                                Container(
                                  width: ScreenUtil().setWidth(100),
                                  height: ScreenUtil().setWidth(30),
                                  child: OutlinedButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'back'),
                                      child: Text('返回收银机')),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(100),
                                  height: ScreenUtil().setWidth(30),
                                  child: ElevatedButton(
                                      onPressed: () =>
                                          {Navigator.pop(context, 'reorder')},
                                      child: Text('重新收银')),
                                ),
                              ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });

    if (option == 'confirm') {
      // 退出drawer
      // 清空购物车
      context.read<CartProvider>().emptyCart();
      Application.router?.pop(context);
    } else if (option == 'back') {
      // 返回收银机
      Application.router?.pop(context);
    } else if (option == 'reorder') {
      onSubmit();
    }
  }
}
