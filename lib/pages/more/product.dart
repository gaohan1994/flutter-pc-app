import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/component/color_item.dart';
import 'package:pc_app/component/empty_view.dart';
import 'package:pc_app/component/list_item.dart';
import 'package:pc_app/component/search.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/pages/component.dart';
import 'package:pc_app/pages/member/member_content.dart';
import 'package:pc_app/provider/product.dart';
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
                            return Container();
                            // return MemberEdit(isEdit: false);
                          })
                    },
                    child: Text('新增会员'),
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
                    DetailCartItem("库存金额", '￥ ${productDetail.number ?? 0}'),
                    DetailCartItem(
                        "近30天销量", '${productDetail.saleNumber ?? 0}'),
                    DetailCartItem("累计销量", '${productDetail.saleNumber ?? 0}'),
                  ],
                ),
                Expanded(
                    child: Column(
                  children: [
                    // MemberTabbar(),
                    Container(
                      padding: EdgeInsets.all(13),
                      child: _buildDetail(),
                    )
                  ],
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  // child: _buildButtons(context),
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
        FilterItem(
            title: '注册时间',
            value: 'createTime',
            onPressed: (value) {
              onFilterClick(value);
            },
            direction:
                filterBy == 'desc' ? FilterDirection.down : FilterDirection.up,
            selected: filterWay == 'createTime'),
      ],
    );
  }

  Widget _buildDetail() {
    ProductInfo? productDetail = context.watch<ProductProvider>().productDetail;
    return Column(
      children: [
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
}
