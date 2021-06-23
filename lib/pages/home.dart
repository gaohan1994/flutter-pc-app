import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pc_app/component/drawer_modal.dart';
import 'package:pc_app/component/empty_view.dart';
import 'package:pc_app/component/search.dart';
import 'package:pc_app/component/slider_type.dart';
import 'package:pc_app/model/cart.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/pages/cashier_order.dart';
import 'package:pc_app/provider/cart.dart';
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
  DateFormat format1 = DateFormat('MM月dd日');
  DateFormat format2 = DateFormat('HH:ss');
  // 滑动的controller
  final ScrollController scrollController = ScrollController();
  // 是否显示搜索列表
  bool showSearchList = false;
  // 查询到的商品列表
  List<ProductInfo> searchProducts = [];

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
                  _buildSecondCate(),
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

  Widget _buildSecondCate() {
    var types = context.watch<HomePageProvider>().productsType;
    var selectedTypeId = context.watch<HomePageProvider>().selectedProductType;
    var selectedSecondType =
        context.watch<HomePageProvider>().selectedSecondType;

    ProductType selectedType =
        types.firstWhere((element) => element.id == selectedTypeId);

    final selectedBorder =
        BoxDecoration(border: Border.all(width: 1, color: Colors.blue));
    final normalBorder =
        BoxDecoration(border: Border.all(width: 1, color: Colors.black12));

    final selectedTextStyle =
        TextStyle(fontSize: ScreenUtil().setSp(11), color: Colors.blue);
    final normalTextStyle =
        TextStyle(fontSize: ScreenUtil().setSp(11), color: Colors.black26);

    if (selectedType.subCategory!.isNotEmpty) {
      List<Widget> renderSelctedTypes = [
        InkWell(
          onTap: () {
            // 如果选择全部则把选中的二级分类置空
            context.read<HomePageProvider>().switchSecondProductType();
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 3.w),
            decoration:
                selectedSecondType != null ? normalBorder : selectedBorder,
            width: 80.w,
            height: 20.h,
            child: Text('全部',
                style: selectedSecondType != null
                    ? normalTextStyle
                    : selectedTextStyle),
          ),
        ),
      ];

      for (int i = 0; i < selectedType.subCategory!.length; i++) {
        renderSelctedTypes.add(InkWell(
          onTap: () {
            // 如果选中当前二级分类则传入
            context.read<HomePageProvider>().switchSecondProductType(
                secondType: selectedType.subCategory![i]);
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 3.w),
            decoration: selectedSecondType != null &&
                    selectedSecondType.id == selectedType.subCategory![i].id
                ? selectedBorder
                : normalBorder,
            width: 80.w,
            height: 20.h,
            child: Text(selectedType.subCategory![i].name,
                style: selectedSecondType != null &&
                        selectedSecondType.id == selectedType.subCategory![i].id
                    ? selectedTextStyle
                    : normalTextStyle),
          ),
        ));
      }

      return Container(
        padding: EdgeInsets.only(left: 4.w, right: 4.w),
        margin: EdgeInsets.only(top: 10.w, bottom: 10.w),
        child: Row(
          children: renderSelctedTypes,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildButtons() {
    final buttonStyle = OutlinedButton.styleFrom(
        side: const BorderSide(width: 1, color: Colors.blue));

    List<ProductInfo> cart = context.watch<CartProvider>().cart;

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
                onPressed: () => {context.read<CartProvider>().emptyCart()},
                child: const Text('整单删除'),
              ),
            ),
            Container(
              height: ScreenUtil().setHeight(30),
              width: ScreenUtil().setWidth(90),
              margin: const EdgeInsets.only(right: 6),
              child: OutlinedButton(
                style: buttonStyle,
                onPressed: () => {
                  if (cart.isEmpty)
                    {_buildDelayOrderDialog()}
                  else
                    {context.read<CartProvider>().addDelay()}
                },
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
  Widget _buildDialogRow({required ProductInfo item, Color? color}) {
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
                item.name,
                maxLines: 1,
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
                  '${item.price}',
                  style: _textStyle,
                ),
                Text(
                  '${item.sellNum}',
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

  Future _buildDelayOrderDialog() async {
    final _textStyle =
        TextStyle(fontSize: ScreenUtil().setSp(11), color: Colors.blue);

    final option = await showDialog(
        context: context,
        builder: (BuildContext context) {
          // 选中的 挂单编号
          int _selectedDelayOrderListIndex = 0;
          List<CartDelay> dalayList = context.watch<CartProvider>().delayList;

          return StatefulBuilder(builder: (BuildContext context, dialogState) {
            // 选中的挂单
            CartDelay? currentDelay;

            if (dalayList.isNotEmpty &&
                dalayList[_selectedDelayOrderListIndex] != null) {
              currentDelay = dalayList[_selectedDelayOrderListIndex];
            }
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
                dalayList.isNotEmpty && currentDelay != null
                    ? Container(
                        padding: EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
                              width: ScreenUtil().setWidth(100),
                              height: ScreenUtil().setWidth(300),
                              margin: const EdgeInsets.only(right: 6),
                              child: ListView(
                                children:
                                    dalayList.asMap().entries.map((entry) {
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
                                      color: _itemSelected
                                          ? Colors.blue
                                          : Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            format1
                                                .format(DateTime
                                                    .fromMicrosecondsSinceEpoch(
                                                        int.parse(item.time)))
                                                .toString(),
                                            style: _textStyle,
                                          ),
                                          Text(
                                            format2
                                                .format(DateTime
                                                    .fromMicrosecondsSinceEpoch(
                                                        int.parse(item.time)))
                                                .toString(),
                                            style: _textStyle,
                                          )
                                          // Text(item.time, style: _textStyle)
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
                              width: ScreenUtil().setWidth(345),
                              height: ScreenUtil().setWidth(300),
                              child: Column(
                                children: [
                                  currentDelay.member != null
                                      ? Container(
                                          width: ScreenUtil().setWidth(345),
                                          height: ScreenUtil().setWidth(30),
                                          color: Colors.blue,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            '会员：${currentDelay.member!.username} ${currentDelay.member?.phone}',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                      : Container(),
                                  Container(
                                    width: ScreenUtil().setWidth(345),
                                    height: ScreenUtil().setWidth(30),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.black12))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 11),
                                            child: Text(
                                              '商品名称',
                                              style: _textStyle,
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                '原价',
                                                style: _textStyle,
                                              ),
                                              Text(
                                                '数量',
                                                style: _textStyle,
                                              )
                                            ],
                                          ),
                                          flex: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView(
                                      children: currentDelay.list.map((item) {
                                        return _buildDialogRow(item: item);
                                      }).toList(),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 6.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<CartProvider>()
                                                .removeDelay();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1, color: Colors.blue),
                                              color: Colors.white,
                                            ),
                                            margin: EdgeInsets.only(right: 6.w),
                                            width: 100.w,
                                            height: 30.w,
                                            child: Text(
                                              '全部清空',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // 删除当前挂单
                                            context
                                                .read<CartProvider>()
                                                .removeDelay(
                                                    index:
                                                        _selectedDelayOrderListIndex);

                                            // 重设 _selectedDelayOrderListIndex = 0;
                                            dialogState(() {
                                              _selectedDelayOrderListIndex = 0;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1, color: Colors.blue),
                                              color: Colors.white,
                                            ),
                                            margin: EdgeInsets.only(right: 6.w),
                                            width: 100.w,
                                            height: 30.w,
                                            child: Text(
                                              '删除',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            context
                                                .read<CartProvider>()
                                                .choiceDelay(
                                                    _selectedDelayOrderListIndex);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1, color: Colors.blue),
                                              color: Colors.blue,
                                            ),
                                            margin: EdgeInsets.only(right: 6.w),
                                            width: 100.w,
                                            height: 30.w,
                                            child: Text(
                                              '下单',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        width: 450.w,
                        child: EmptyView(),
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
