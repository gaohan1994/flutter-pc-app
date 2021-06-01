import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/component/product_tag.dart';
import './cart_stepper.dart';

// 获取购物车数据并匹配创建购物车详情
class ShopCart extends StatefulWidget {
  ShopCart({@required this.title});

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

  // 购物车主函数
  @override
  Widget build(BuildContext context) {
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
          _buildListView(),

          // 渲染购物车底部
          _buildFooter(),
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
  Widget _buildFooter() {
    final textStyle = TextStyle(fontSize: ScreenUtil().setSp(10));
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
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.blue)),
                  onPressed: () => {},
                  child: const Text(
                    '请选择会员',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '商品数量 7',
                        style: textStyle,
                      ),
                      Text(
                        '应收金额 117',
                        style: textStyle,
                      ),
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
            onPressed: () => {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                '结算',
                style: TextStyle(fontSize: ScreenUtil().setSp(14)),
              ),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
          ),
        ),
      ],
    );
  }

  // 创建长列表
  Widget _buildListView() {
    const data = [
      {"title": '123123123'},
      {"title": '123123123'},
      {"title": '123123123'},
    ];
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, i) {
          return _buildRow(data[i], i);
        },
      ),
    );
  }

  // 购物车条目
  Widget _buildRow(item, index) {
    // 当前条目是否选中
    final itemSelected = _selectedIndex == index;

    final grayFontStyle =
        TextStyle(fontSize: ScreenUtil().setSp(9), color: Colors.black54);

    Widget _itemTitle = Row(
      children: [
        Text('knoppers 牛奶榛子巧克力威化饼干250g/条',
            style: TextStyle(fontSize: ScreenUtil().setSp(11))),
        Text('  [100条]', style: grayFontStyle)
      ],
    );

    Widget _itemPrice = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 原价
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          child: Text('￥88.00',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.black54,
                  decoration: TextDecoration.lineThrough)),
        ),
        Row(
          children: [
            ProductTag(name: '改价'),
            ProductTag(
              name: '会员价',
              color: Colors.orange,
            ),
            ProductTag(
              name: '退货',
              color: Colors.blue,
            ),
            Text(
              '￥77.00',
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
            value: 0,
          ),
        ),
        Text('￥155.00',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(12), color: Colors.black))
      ],
    );

    return MouseRegion(
      onHover: (_) => {setSelectedIndex(index)},
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
}
