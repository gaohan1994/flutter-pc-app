import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/component/drawer_modal.dart';
import 'package:pc_app/component/search.dart';
import 'package:pc_app/component/slider_type.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/pages/cashier_order.dart';
import 'package:pc_app/provider/home.dart';
import 'package:provider/provider.dart';
import '../component/shop_cart.dart';
import '../component/product.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  // 滑动的controller
  final ScrollController scrollController = ScrollController();
  // 是否显示搜索列表
  bool showSearchList = false;
  // 查询到的商品列表
  List<ProductInfo> searchProducts = [];
  // 挂单列表
  List _delayOrderList = [
    {"time": DateTime.now(), "data": []}
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      // 初始化商品分类
      await context.read<HomePageProvider>().getProductType();
      // 初始化商品列表
      await context.read<HomePageProvider>().getProducts();
    });
  }

  // 搜索商品
  void fetchProducts(String value) {
    if (value == '') {
      setState(() {
        searchProducts = [];
      });
    } else {
      var _productsList = context.read<HomePageProvider>().productsList;
      List<ProductInfo> _searchList = [];

      for (int i = 0; i < _productsList.length; i++) {
        if (_productsList[i].name.contains(value)) {
          _searchList.add(_productsList[i]);
        }
      }

      setState(() {
        searchProducts = _searchList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = context.watch<HomePageProvider>().productsType;
    final selectedTypeId =
        context.watch<HomePageProvider>().selectedProductType;
    final onPressed = context.read<HomePageProvider>().switchProductTtype;
    return Scaffold(
        endDrawer: DrawerModal(
          title: '结算',
          width: 260 + 280,
          child: CashierOrderPage(),
        ),
        body: Row(
          children: [
            ShopCart(title: '购物车'),
            Expanded(
              child: Column(
                children: [
                  // 搜索功能
                  _buildSearch(),
                  // 构建收银台中间商品部分
                  _buildBody(),
                  // 底部按钮区域
                  const Divider(),
                  _buildButtons(),
                ],
              ),
            ),
            SliderType(
                selectedTypeId: selectedTypeId,
                items: items,
                onPressed: onPressed)
          ],
        ));
  }

  // 构建主体部分搜索功能
  Widget _buildSearch() {
    return Container(
      padding: EdgeInsets.all(4),
      child: SearchCompoennt(
        inputCallback: (value) {
          setState(() {
            showSearchList = true;
          });
          fetchProducts(value);
        },
        onCancel: (value) {
          setState(() {
            showSearchList = false;
          });
          fetchProducts('');
        },
      ),
    );
  }

  Widget _buildButtons() {
    final buttonStyle = OutlinedButton.styleFrom(
        side: const BorderSide(width: 1, color: Colors.blue));

    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: ScreenUtil().setHeight(30),
              width: ScreenUtil().setWidth(90),
              margin: const EdgeInsets.only(right: 6),
              child: OutlinedButton(
                style: buttonStyle,
                onPressed: () => {},
                child: const Text('整单删除'),
              ),
            ),
            Container(
              height: ScreenUtil().setHeight(30),
              width: ScreenUtil().setWidth(90),
              margin: const EdgeInsets.only(right: 6),
              child: OutlinedButton(
                style: buttonStyle,
                onPressed: () => _buildDelayOrderDialog(context),
                child: const Text('挂单'),
              ),
            ),
          ],
        ));
  }

  Widget _buildBody() {
    final products = context.watch<HomePageProvider>().productsList;

    final renderProducts = !showSearchList ? products : searchProducts;

    final Widget child;

    if (renderProducts != null && renderProducts.length != 0) {
      child = ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(4),
        children: [
          Wrap(
              children: renderProducts.map((item) {
            return Product(item: item);
          }).toList())
        ],
      );
    } else {
      child = InkWell(
        onTap: () async {
          await context.read<HomePageProvider>().getProducts();
        },
        child: const Text('暂无商品'),
      );
    }

    return Expanded(
      child: EasyRefresh(
        onLoad: () async {
          await context.read<HomePageProvider>().loadMoreProducts();
        },
        footer: ClassicalFooter(
            bgColor: Colors.white,
            textColor: Colors.black38,
            noMoreText: '加载完成',
            loadReadyText: '上拉加载',
            loadText: '上拉加载更多',
            loadingText: '加载中...',
            loadedText: '加载成功',
            showInfo: false),
        child: child,
      ),
    );
  }

  // 挂单条目
  Widget _buildDialogRow({item, Color? color}) {
    final _textStyle = TextStyle(
        fontSize: ScreenUtil().setSp(11),
        color: color != null ? color : Colors.black);

    return Container(
      width: ScreenUtil().setWidth(345),
      height: ScreenUtil().setWidth(30),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 11),
              child: Text(
                item['name'],
                style: _textStyle,
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  item['price'],
                  style: _textStyle,
                ),
                Text(
                  item['count'],
                  style: _textStyle,
                )
              ],
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  Future _buildDelayOrderDialog(context) async {
    final option = await showDialog(
        context: context,
        builder: (BuildContext context) {
          // 选中的 挂单编号
          int _selectedDelayOrderListIndex = 0;

          List _testData = [
            {'name': '多乐食意大利威化饼干椒盐鸡蛋', "price": '10.00', "count": '5.00'},
            {'name': '多乐食意大利威化饼干椒盐鸡蛋', "price": '10.00', "count": '5.00'},
            {'name': '多乐食意大利威化饼干椒盐鸡蛋', "price": '10.00', "count": '5.00'},
            {'name': '多乐食意大利威化饼干椒盐鸡蛋', "price": '10.00', "count": '5.00'},
            {'name': '多乐食意大利威化饼干椒盐鸡蛋', "price": '10.00', "count": '5.00'},
            {'name': '多乐食意大利威化饼干椒盐鸡蛋', "price": '10.00', "count": '5.00'},
            {'name': '多乐食意大利威化饼干椒盐鸡蛋', "price": '10.00', "count": '5.00'},
          ];

          return StatefulBuilder(builder: (BuildContext context, dialogState) {
            return SimpleDialog(
              contentPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.all(0),
              title: Container(
                padding: EdgeInsets.all(12),
                color: Colors.blue,
                child: const Text(
                  '挂单',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setWidth(300),
                        margin: const EdgeInsets.only(right: 6),
                        child: ListView(
                          children: _testData.asMap().entries.map((entry) {
                            int index = entry.key;
                            final item = entry.value;

                            final _itemSelected =
                                index == _selectedDelayOrderListIndex;

                            final _textStyle = _itemSelected
                                ? const TextStyle(color: Colors.white)
                                : const TextStyle(color: Colors.black);

                            return InkWell(
                              onTap: () {
                                dialogState(() {
                                  _selectedDelayOrderListIndex = index;
                                });
                              },
                              child: Container(
                                width: ScreenUtil().setWidth(100),
                                height: ScreenUtil().setWidth(60),
                                color:
                                    _itemSelected ? Colors.blue : Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '09月20日',
                                      style: _textStyle,
                                    ),
                                    Text(
                                      '15:00',
                                      style: _textStyle,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.black12)),
                        width: ScreenUtil().setWidth(345),
                        height: ScreenUtil().setWidth(300),
                        child: Column(
                          children: [
                            Container(
                              width: ScreenUtil().setWidth(345),
                              height: ScreenUtil().setWidth(30),
                              color: Colors.blue,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                '会员：黄小姐 13305899897',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            _buildDialogRow(
                              color: Colors.blue,
                              item: {
                                "name": '商品名称',
                                "price": '原价',
                                "count": '数量'
                              },
                            ),
                            Expanded(
                              child: ListView(
                                children: _testData.map((item) {
                                  return _buildDialogRow(item: item);
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          });
        });

    switch (option) {
      case '1':
        break;
    }
  }
}
