import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/common/global.dart';
import 'package:pc_app/component/button.dart';
import 'package:pc_app/component/color_item.dart';
import 'package:pc_app/component/empty_view.dart';
import 'package:pc_app/component/fliter_modal.dart';
import 'package:pc_app/component/form/form_input.dart';
import 'package:pc_app/component/list_item.dart';
import 'package:pc_app/component/search.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/pages/component.dart';
import 'package:pc_app/pages/member/member_content.dart';
import 'package:pc_app/pages/more/product_edit.dart';
import 'package:pc_app/provider/home.dart';
import 'package:pc_app/provider/product.dart';
import 'package:pc_app/service/product_method.dart';
import 'package:pc_app/service/service_url.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      // 初始化列表
      context.read<ProductProvider>().getProducts();
    });
  }

  void onFilterClick(value) {
    var filterWay = context.read<ProductProvider>().filterWay;
    var filterBy = context.read<ProductProvider>().filterBy;
    // print('value: ${value}');
    // print('filterWay: ${filterWay}');
    // print('value == filterWay: ${value == filterWay}');
    if (value == filterWay) {
      // 如果已经是当前选中的分类则翻转排序方式
      context
          .read<ProductProvider>()
          .setFilterBy(filterBy == 'desc' ? 'asc' : 'desc');
    } else {
      // 如果不是选中状态则选中
      context.read<ProductProvider>().setFilterWay(value);
      context.read<ProductProvider>().setFilterBy('desc');
    }
  }

  // 重置筛选
  void resetFilters() {
    context.read<ProductProvider>().resetSelectedFilterType();
  }

  // 修改商品type
  void onChangeProductType(FilterButtonItem item) {
    var productsType = context.read<HomePageProvider>().productsType;
    ProductType selectedType = productsType
        .firstWhere((element) => element.id == int.parse(item.value));
    context.read<ProductProvider>().changeSelectedFilterType(selectedType);
  }

  @override
  Widget build(BuildContext context) {
    ProductInfo? productDetail = context.watch<ProductProvider>().productDetail;

    return Scaffold(
      appBar: AppBar(
        title: Text('商品'),
      ),
      body: Row(
        children: [
          Container(
            width: 330.w,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ColorItem(
                              title: '新增会员数',
                              detail: '0',
                              color: Colors.orange),
                          ColorItem(
                              title: '总会员数', detail: '0', color: Colors.red),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: SearchCompoennt(
                          hintText: '请输入商品条码或名称',
                          inputCallback: (value) {
                            context.read<ProductProvider>().searchValue = value;
                            context.read<ProductProvider>().getProducts();
                          },
                          onCancel: (value) {
                            context.read<ProductProvider>().searchValue = '';
                            context.read<ProductProvider>().getProducts();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.w),
                        child: _buildFilter(),
                      )
                    ],
                  ),
                ),
                Expanded(child: _buildList()),
                Container(
                  height: 40.w,
                  width: 330.w,
                  child: ElevatedButton(
                    onPressed: () => {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ProductEdit(isEdit: false);
                          })
                    },
                    child: Text('新增商品'),
                  ),
                )
              ],
            ),
          ),
          VerticalDivider(),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                DetailCard(
                  img: 'assets/img_shop.png',
                  neticon: productDetail?.pic,
                  title: productDetail!.name,
                  subTitle: productDetail.barcode ?? '',
                  items: [
                    DetailCartItem("库存", '${productDetail.number ?? 0}'),
                    DetailCartItem("库存金额", '￥ 0'),
                    DetailCartItem("近30天销量", '0'),
                    DetailCartItem("累计销量", '0'),
                  ],
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(13),
                      child: _buildDetail(),
                    )
                  ],
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: GhButton(
                      title: '调整库存',
                      onPressed: () {
                        editNumberDialog();
                      }),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildList() {
    List<ProductInfo> productList =
        context.watch<ProductProvider>().productList;
    ProductInfo? productDetail = context.watch<ProductProvider>().productDetail;

    if (productList.isNotEmpty) {
      return EasyRefresh(
          onLoad: () async {
            await context.read<ProductProvider>().loadMoreProducts();
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
          child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (BuildContext context, index) {
                bool selected = false;

                if (productDetail != null &&
                    productDetail.id == productList[index].id) {
                  selected = true;
                }

                return ProductRowItem(
                  item: productList[index],
                  selected: selected,
                );
              }));
    } else {
      return EmptyView(emptyText: '暂无数据');
    }
  }

  Widget _buildFilter() {
    var filterWay = context.watch<ProductProvider>().filterWay;
    var filterBy = context.watch<ProductProvider>().filterBy;

    // 选中的商品分类
    List<ProductType> selectedProductType =
        context.watch<ProductProvider>().selectedFilterType;
    List<ProductType> productTypes =
        context.read<HomePageProvider>().productsType;

    List<FilterButtonItem> _filters = [
      FilterButtonItem(title: '全部分类', value: 'all')
    ];

    for (int i = 0; i < productTypes.length; i++) {
      _filters.add(FilterButtonItem(
          title: productTypes[i].name, value: '${productTypes[i].id}'));
    }
    return Row(
      children: [
        FilterItem(
            title: '累计消费',
            value: 'totalAmount',
            onPressed: (value) {
              onFilterClick(value);
            },
            direction:
                filterBy == 'desc' ? FilterDirection.down : FilterDirection.up,
            selected: filterWay == 'totalAmount'),
        FilterItem(
            title: '上次消费时间',
            value: 'lastPayTime',
            onPressed: (value) {
              onFilterClick(value);
            },
            direction:
                filterBy == 'desc' ? FilterDirection.down : FilterDirection.up,
            selected: filterWay == 'lastPayTime'),
        Container(
          margin: EdgeInsets.only(left: 8.w),
          child: FilterButton(
            onCancel: () {
              resetFilters();
            },
            onClose: () {
              resetFilters();
            },
            onPressed: (item) {
              onChangeProductType(item);
            },
            filters: [FilterSection(items: _filters, title: '商品分类')],
          ),
        )
      ],
    );
  }

  Widget _buildDetail() {
    ProductInfo? productDetail = context.watch<ProductProvider>().productDetail;
    return Column(
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return ProductEdit(isEdit: true);
                });
          },
          child: Container(
            padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
            child: Row(
              children: [
                Text(
                  '商品编辑',
                  style: TextStyle(fontSize: 12),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.w),
                  child: Image(
                      width: 12.w,
                      height: 12.w,
                      image: AssetImage('assets/icon_bianji.png')),
                )
              ],
            ),
          ),
        ),
        DetailContent(
          child: Column(
            children: [
              DetailContent.buildSection(items: [
                ContentItem(title: '售价', value: '￥${productDetail!.price}'),
                ContentItem(title: '品类', value: productDetail.typeName ?? '')
              ]),
              DetailContent.buildSection(items: [
                ContentItem(title: '进价', value: '￥${productDetail.cost ?? 0}'),
                ContentItem(title: '规格', value: productDetail.standard ?? '')
              ]),
              DetailContent.buildSection(items: [
                ContentItem(
                    title: '会员价', value: '￥${productDetail.memberPrice ?? 0}'),
                ContentItem(title: '单位', value: productDetail.unit ?? '')
              ]),
              DetailContent.buildSection(items: [
                ContentItem(title: '品牌', value: productDetail.brand ?? ''),
              ]),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: DetailContent(
            child: Column(
              children: [
                ContentItem(
                    title: '供应商', value: productDetail.supplierName ?? ''),
                ContentItem(
                    title: '销售状态',
                    value: productDetail.saleType != null &&
                            productDetail.saleType == 0
                        ? '按件售卖'
                        : '称重商品'),
                ContentItem(
                    title: '商品状态',
                    value: productDetail.status != null &&
                            productDetail.status == 1
                        ? '上架'
                        : '下架'),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future editNumberDialog() async {
    ProductInfo? productDetail = context.read<ProductProvider>().productDetail;

    // 现有库存
    final TextEditingController cNumber =
        TextEditingController(text: '${productDetail?.saleNumber ?? ''}');

    // 库存差额
    final TextEditingController cCount = TextEditingController(
        text: productDetail?.saleNumber != null && productDetail?.number != null
            ? '${productDetail!.number! - productDetail.saleNumber!}'
            : '0');

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
                '调整库存',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '现有库存： ${productDetail?.number}',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      GhFormInput(
                        width: 285.w,
                        title: '现有库存',
                        controller: cNumber,
                        hintText: '请输入名称',
                        textAlign: TextAlign.right,
                        inputCallBack: (value) {
                          // _currentDiscount 改价折扣
                          double _currentNumber = double.parse(value);
                          double _currentCount =
                              _currentNumber - (productDetail?.number ?? 0);

                          String _currentCountValue =
                              Global.formatNum(_currentCount, 2);

                          setState(() {
                            cCount.text = _currentCountValue;
                          });
                        },
                      ),
                      GhFormInput(
                        width: 285.w,
                        title: '库存差额',
                        controller: cCount,
                        hintText: '请输入名称',
                        textAlign: TextAlign.right,
                        inputCallBack: (value) {
                          // _currentDiscount 改价折扣
                          double _currentCount = double.parse(value);
                          double _currentValue =
                              _currentCount + (productDetail?.number ?? 0);

                          String _currentValueString =
                              Global.formatNum(_currentValue, 2);

                          setState(() {
                            cNumber.text = _currentValueString;
                          });
                        },
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 30, left: 30, right: 30),
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
                                  onPressed: () async {
                                    ProductInfo info = ProductInfo(
                                        id: productDetail?.id,
                                        name: productDetail!.name,
                                        price: productDetail.price,
                                        saleNumber: double.parse(cNumber.text));

                                    EasyLoading.show(status: '请稍候');

                                    var result = await fetchProductEdit(
                                        params: info.toJson());
                                    var resultMap =
                                        json.decode(result.toString());

                                    EasyLoading.dismiss();
                                    if (resultMap['code'] == successCode) {
                                      showToast('修改成功！');

                                      context
                                          .read<ProductProvider>()
                                          .getProducts();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('确定')),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          );
        });
    switch (option) {
      case 'confirm':
        break;
    }
  }
}
