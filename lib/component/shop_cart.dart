import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/common/global.dart';
import 'package:pc_app/component/form/form_input.dart';
import 'package:pc_app/component/form/form_input_field.dart';
import 'package:pc_app/component/product_tag.dart';
import 'package:pc_app/model/member.dart';
import 'package:pc_app/model/order.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/provider/cart.dart';
import 'package:pc_app/service/order_method.dart';
import 'package:provider/provider.dart';
import './cart_stepper.dart';

enum CartProductDialogMethod {
  Cancel,
  Submit,
}

// 获取购物车数据并匹配创建购物车详情
class ShopCart extends StatefulWidget {
  ShopCart({@required this.title, this.type = CartType.Home});

  CartType type;
  final title;

  @override
  _ShopCartState createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {
  // 选中商品的index
  int _selectedIndex = -1;

  // 触发选中商品函数
  void setSelectedIndex(value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  // 设计稿上购物车的宽高
  final cartWidth = 327;
  // 设计稿上购物车的宽高
  final cartHeight = 496;

  final biggerFont = const TextStyle(fontSize: 18);
  void onSubmit() {}

  // 下单
  createOrder() async {
    Scaffold.of(context).openEndDrawer();
  }

  // 购物车主函数
  @override
  Widget build(BuildContext context) {
    List<ProductInfo> list = [];
    if (widget.type == CartType.Home) {
      list = context.watch<CartProvider>().cart;
    } else {
      list = context.watch<CartProvider>().refundCart;
    }

    return Container(
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      padding: const EdgeInsets.only(top: 4, bottom: 4, right: 4),
      width: ScreenUtil().setWidth(cartWidth),
      child: Column(
        children: [
          // 渲染购物车标题
          _buildCartTitle(),

          // 渲染购物车
          _buildListView(list),

          // 渲染购物车底部
          _buildFooter(list),
        ],
      ),
    );
  }

  // 渲染购物车标题
  Widget _buildCartTitle() {
    // hasTitle 是否由购物车标题
    bool hasTitle = widget.title != null;
    if (hasTitle) {
      return Container(
          width: ScreenUtil().setWidth(cartWidth),
          height: ScreenUtil().setHeight(28),
          color: Colors.black54,
          child: Center(
              child: Text(
            widget.title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(12), color: Colors.white),
          )));
    } else {
      return Container(
        child: null,
      );
    }
  }

  // 渲染购物车底部
  Widget _buildFooter(List<ProductInfo> list) {
    final textStyle = TextStyle(fontSize: ScreenUtil().setSp(10));

    double cartNumber = 0;

    double cartPrice = 0;

    // 选中的会员
    MemberDetail? selectedMember = context.watch<CartProvider>().selectedMember;

    for (int i = 0; i < list.length; i++) {
      cartNumber += list[i].sellNum!;

      // 获取实际的售价
      double renderPrice = context
          .read<CartProvider>()
          .getCurrentProductPrice(list[i], selectedMember);

      cartPrice += renderPrice * list[i].sellNum!;
    }
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ))),
          height: ScreenUtil().setHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Global.selectMemberDialog(context);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: selectedMember != null
                                ? Colors.orange[100]
                                : Colors.white,
                            border: selectedMember != null
                                ? Border.all(
                                    width: 1, color: Colors.orange.shade100)
                                : Border.all(width: 1, color: Colors.blue)),
                        width: 95.w,
                        height: 30.w,
                        child: selectedMember != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Text(selectedMember.username,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.brown.shade400)),
                                    ProductTag(
                                        name: selectedMember.levelName!,
                                        color: Colors.brown.shade400)
                                  ])
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      width: 12.w,
                                      height: 12.w,
                                      image: AssetImage(
                                          'assets/icon_huiyuan.png')),
                                  Container(
                                    margin: EdgeInsets.only(left: 6),
                                    child: Text(
                                      '请选择会员',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.blue),
                                    ),
                                  )
                                ],
                              ))),
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '商品数量 $cartNumber',
                        style: textStyle,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '应收金额 ',
                            style: textStyle,
                          ),
                          Text('￥$cartPrice',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(cartWidth),
          child: ElevatedButton(
            onPressed: () => {
              if (cartNumber <= 0)
                {showToast('请选择要结算的商品')}
              else if (widget.type == CartType.Home)
                {createOrder()}
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                '结算',
                style: TextStyle(fontSize: ScreenUtil().setSp(14)),
              ),
            ),
            style: ButtonStyle(
                backgroundColor: cartNumber > 0
                    ? MaterialStateProperty.all(Colors.red)
                    : MaterialStateProperty.all(Colors.black12)),
          ),
        ),
      ],
    );
  }

  // 创建长列表
  Widget _buildListView(List<ProductInfo> list) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, i) {
          return _buildRow(list[i], i);
        },
      ),
    );
  }

  // 购物车条目
  Widget _buildRow(ProductInfo item, index) {
    // 当前条目是否选中
    final itemSelected = _selectedIndex == index;

    return MouseRegion(
        onHover: (_) => {setSelectedIndex(index)},
        child: CartItemComponent(
            item: item, selected: itemSelected, type: widget.type));
  }
}

class CartItemComponent extends StatefulWidget {
  CartItemComponent(
      {required this.item, this.selected = false, required this.type});

  ProductInfo item;

  bool selected;

  CartType type;

  @override
  createState() => _CartItemComponent();
}

class _CartItemComponent extends State<CartItemComponent> {
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    // 当前条目是否选中
    final itemSelected = widget.selected;

    final grayFontStyle =
        TextStyle(fontSize: ScreenUtil().setSp(9), color: Colors.black54);

    // 选中的会员
    MemberDetail? selectedMember = context.watch<CartProvider>().selectedMember;

    // 获取渲染时的售价
    double renderPrice = context
        .read<CartProvider>()
        .getCurrentProductPrice(item, selectedMember);

    // 商品是够改价
    bool changedPrice = false;
    if (widget.item.unitPrice != null) {
      changedPrice = true;
    }

    Widget _itemTitle = Row(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 260.w),
          child: Text(item.name,
              maxLines: 2, style: TextStyle(fontSize: ScreenUtil().setSp(11))),
        ),
        Text('  [100条]', style: grayFontStyle)
      ],
    );

    Widget _itemPrice = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 原价
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          child: Text('￥${item.price}',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.black54,
                  decoration: TextDecoration.lineThrough)),
        ),
        Row(
          children: [
            changedPrice ? ProductTag(name: '改价') : Container(),

            renderPrice == widget.item.price
                ? ProductTag(
                    name: '会员价',
                    color: Colors.orange.shade300,
                  )
                : Container(),
            // ProductTag(
            //   name: '退货',
            //   color: Colors.blue,
            // ),
            Text(
              '￥$renderPrice',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(12),
                color: Colors.black54,
              ),
            )
          ],
        )
      ],
    );

    Widget _itemCount = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 6, bottom: 12),
          child: CartStepper(
              value: item.sellNum, type: widget.type, product: item),
        ),
        Text('￥${item.sellNum! * renderPrice}',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(12), color: Colors.black))
      ],
    );

    return InkWell(
      onTap: () => openCartProductDialog(item),
      child: Container(
          decoration: BoxDecoration(
              color: itemSelected ? Colors.blue.shade50 : Colors.white,
              border: Border(
                  bottom: const BorderSide(width: 1, color: Colors.black12),
                  left: BorderSide(
                      width: 5,
                      color: itemSelected ? Colors.blue : Colors.white))),
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Column(
              children: [
                // 渲染商品名称
                _itemTitle,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 渲染商品价格
                    _itemPrice,
                    // 渲染商品数量
                    _itemCount
                  ],
                )
              ],
            ),
          )),
    );
  }

  Future openCartProductDialog(ProductInfo item) async {
    // 数量
    final TextEditingController _count =
        TextEditingController(text: '${item.sellNum}');

    // 价格
    final TextEditingController _price =
        TextEditingController(text: '${item.unitPrice ?? item.price}');

    // 折扣
    final TextEditingController _discount = TextEditingController(
        text: item.unitPrice != null
            ? Global.formatNum(item.unitPrice! / item.price * 100, 2)
            : '100');

    // 备注
    final TextEditingController _remark = TextEditingController();

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
                '蒙牛特仑苏新西兰纯牛奶',
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
                    GhFormInput(
                      controller: _count,
                      hintText: '请输入数量',
                      title: '数量',
                      textAlign: TextAlign.end,
                    ),
                    GhFormInput(
                      controller: _price,
                      title: '价格￥',
                      hintText: '请输入价格',
                      rightWidget: Text('￥'),
                      textAlign: TextAlign.end,
                      inputCallBack: (value) {
                        // _currentValue 改价价格
                        double _currentValue = double.parse(value);
                        // _currentDiscount 改价价格计算出当前折扣
                        String _currentDiscount = Global.formatNum(
                            _currentValue / widget.item.price * 100, 2);
                        setState(() {
                          _discount.text = _currentDiscount;
                        });
                      },
                    ),
                    GhFormInput(
                      title: '折扣',
                      hintText: '请输入折扣',
                      rightWidget: Text('%'),
                      textAlign: TextAlign.end,
                      controller: _discount,
                      inputCallBack: (value) {
                        // _currentDiscount 改价折扣
                        double _currentDiscount = double.parse(value);
                        // _currentPrice 根据折扣计算出当前价格
                        String _currentPrice = Global.formatNum(
                            widget.item.price * (_currentDiscount / 100), 2);
                        setState(() {
                          _price.text = _currentPrice;
                        });
                      },
                    ),
                    GhFormInput(
                      hintText: '请输入备注',
                      title: '备注',
                      textAlign: TextAlign.end,
                      inputCallBack: (value) {
                        _remark.text = value;
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
                                onPressed: () => Navigator.pop(
                                    context, CartProductDialogMethod.Cancel),
                                child: Text('取消')),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setWidth(30),
                            child: ElevatedButton(
                                onPressed: () => {
                                      Navigator.pop(context,
                                          CartProductDialogMethod.Submit)
                                    },
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
    switch (option) {
      case CartProductDialogMethod.Submit:
        context.read<CartProvider>().addProduct(
            product: widget.item,
            type: widget.type,
            sellNum: double.parse(_count.text),
            remark: _remark.text,
            unitPrice: double.parse(_price.text));
        break;
    }
  }
}
