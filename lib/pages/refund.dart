import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/component/color_item.dart';
import 'package:pc_app/component/drawer_modal.dart';
import 'package:pc_app/component/empty_view.dart';
import 'package:pc_app/component/list_item.dart';
import 'package:pc_app/component/product.dart';
import 'package:pc_app/component/search.dart';
import 'package:pc_app/component/shop_cart.dart';
import 'package:pc_app/component/slider_type.dart';
import 'package:pc_app/model/order.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/pages/cashier_order.dart';
import 'package:pc_app/provider/cart.dart';
import 'package:pc_app/provider/home.dart';
import 'package:pc_app/provider/order.dart';
import 'package:pc_app/provider/report.dart';
import 'package:provider/provider.dart';

class RefundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // 主页面 stateful 在这里接入state
    return _RefundPageState();
  }
}

class _RefundPageState extends State<RefundPage> {
  // 是否显示搜索列表
  bool showSearchList = false;
  // 查询到的商品列表
  List<ProductInfo> searchProducts = [];

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
    final products = context.watch<HomePageProvider>().productsList;
    final renderProducts = !showSearchList ? products : searchProducts;

    final Widget _child;

    if (renderProducts != null && renderProducts.length != 0) {
      _child = ListView(
        padding: const EdgeInsets.all(4),
        children: [
          Wrap(
              children: renderProducts.map((item) {
            return Product(
              item: item,
              type: CartType.Refund,
            );
          }).toList())
        ],
      );
    } else {
      _child = InkWell(
        onTap: () async {
          await context.read<HomePageProvider>().getProducts();
        },
        child: const Text('暂无商品'),
      );
    }

    return Scaffold(
        body: Row(
      children: [
        ShopCart(
          title: '退货商品',
          type: CartType.Refund,
        ),
        Expanded(
          child: Column(
            children: [
              // 搜索功能
              Container(
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
                  )),
              // 构建收银台中间商品部分

              Expanded(
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
                  child: _child,
                ),
              ),
              // 底部按钮区域
              const Divider(),
              // _buildButtons(),
            ],
          ),
        ),
        SliderType(
            selectedTypeId: selectedTypeId, items: items, onPressed: onPressed)
      ],
    ));
  }
}
