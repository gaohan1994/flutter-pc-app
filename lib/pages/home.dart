import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/provider/home.dart';
import 'package:pc_app/route/application.dart';
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
  EasyRefreshController _controller = EasyRefreshController();

  final ScrollController scrollController = new ScrollController();
  // 挂单列表
  List _delayOrderList = [
    {"time": DateTime.now(), "data": []}
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // 初始化商品列表
      context.read<HomePageProvider>().getProducts();

      // 初始化商品分类
      context.read<HomePageProvider>().getProductType();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        _buildCategory(),
      ],
    ));
  }

  Widget _buildCategory() {
    final productsType = context.watch<HomePageProvider>().productsType;
    return Align(
      alignment: Alignment.topRight,
      child: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(502),
          decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ))),
          child: ListView.builder(
              itemCount: productsType.length,
              itemBuilder: (context, i) {
                return _buildCategoryItem(productsType[i]);
              })),
    );
  }

  Widget _buildCategoryItem(ProductType item) {
    final alreadySelected = item.name == '无码商品';
    return InkWell(
      onTap: () => {Application.router?.navigateTo(context, '/login')},
      onHover: (value) => {},
      child: Container(
        decoration: BoxDecoration(
            color: alreadySelected ? Colors.blue[50] : Colors.white,
            border: alreadySelected
                ? const Border(left: BorderSide(width: 5, color: Colors.blue))
                : null),
        height: ScreenUtil().setHeight(35),
        width: ScreenUtil().setWidth(90),
        child: Center(
          child: Text(item.name,
              style: TextStyle(
                  color: alreadySelected ? Colors.blue : Colors.black,
                  fontSize: ScreenUtil().setSp(11))),
        ),
      ),
    );
  }

  // 构建主体部分搜索功能
  Widget _buildSearch() {
    final TextEditingController _controller = TextEditingController();
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                height: ScreenUtil().setHeight(30),
                color: Colors.black12,
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black26,
                      ),
                      hintText: '请输入商品条码或名称',
                      border: InputBorder.none),
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Container(
                  width: ScreenUtil().setWidth(70),
                  height: ScreenUtil().setHeight(30),
                  child: ElevatedButton(
                      onPressed: () => {}, child: const Text('搜索')),
                ),
              )
            ],
          )),
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
                onPressed: () => _buildDelayOrderDialog(context),
                child: const Text('整单删除'),
              ),
            ),
            Container(
              height: ScreenUtil().setHeight(30),
              width: ScreenUtil().setWidth(90),
              margin: const EdgeInsets.only(right: 6),
              child: OutlinedButton(
                style: buttonStyle,
                onPressed: () => {},
                child: const Text('挂单'),
              ),
            ),
          ],
        ));
  }

  Widget _buildBody() {
    final products = context.watch<HomePageProvider>().productsList;

    final Widget child;

    if (products != null && products.length != 0) {
      child = ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(4),
        children: [
          Wrap(
              children: products.map((item) {
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
                                  print('index: ${index}');
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
