import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/component/drawer_modal.dart';
import 'package:pc_app/component/order.dart';
import 'package:pc_app/component/search.dart';
import 'package:pc_app/model/order.dart';
import 'package:pc_app/provider/home.dart';
import 'package:pc_app/provider/order.dart';
import 'package:pc_app/provider/report.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // 主页面 stateful 在这里接入state
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  // Scaffold key 用来打开 drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateFormat format = DateFormat('yyyy-MM-dd');

  // 创建搜索订单单号或者退货单号的 TextEditingController
  final TextEditingController _controller = TextEditingController();
  // 订单检索开始日期 默认为空
  String _startTime = '';
  // 订单检索结束日期 默认为空
  String _endTime = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      // 初始化订单列表
      context.read<OrderPageProvider>().getOrderList();

      // 初始化今日报表
      context.read<ReportProvider>().getReportToday(context);
    });
  }

  void fetchOrderList() {
    context.read<OrderPageProvider>().getOrderList();
  }

  void searchOrderList(value) {}

  // 筛选订单
  void onFilterOrderList() {
    try {
      if (_startTime.isEmpty) {
        throw Exception('请选择起始日期');
      }
      if (_endTime.isEmpty) {
        throw Exception('请选择结束日期');
      }

      DateTime startTime = DateTime.parse(_startTime);
      DateTime endTime = DateTime.parse(_endTime);

      if (startTime.isAfter(endTime)) {
        throw Exception('结束日期不能早于起始日期');
      }

      // 通过校验，设置时间格式
      context.read<OrderPageProvider>().startTime =
          format.format(startTime).toString();

      context.read<OrderPageProvider>().endTime =
          format.format(endTime).toString();

      fetchOrderList();
    } catch (e) {
      showToast(e.toString());
    }
  }

  Future<String> _showDatePicker() async {
    Locale myLocale = const Locale('zh');
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
        locale: myLocale);
    return picker != null ? picker.toString() : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: _buildRefundDrawer(),
        body: Row(
          children: [
            Container(
              width: 330.w,
              child: Column(
                children: [
                  _buildSearchHeader(),
                  _buildOrderList(),
                ],
              ),
            ),
            const VerticalDivider(),
            Expanded(
                child: Column(
              children: [
                _buildOrderDetailInfo(),
                _buildOrderListItem([
                  {"name": '名称'},
                  {"name": '单价'},
                  {"name": '数量'},
                  {"name": '小计'},
                ], color: Colors.black12),
                Expanded(child: _buildOrderListView()),
                _buildOrderDetailBar(),
              ],
            )),
            const VerticalDivider(),
            Container(
              width: 220.w,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: _buildOrderPriceCard(),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 11, right: 11),
                    child: _buildOrderPrice(),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildColorItem({title, detail, color, padding}) {
    return Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.only(right: 4),
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title,
              detail,
            ],
          ),
        ));
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildColorItem(
                  title: Text('今日销售 2 数',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(10))),
                  detail: Text(
                    '￥ 200.00',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orange,
                  padding: EdgeInsets.fromLTRB(14, 11, 14, 11)),
              _buildColorItem(
                  title: Text('今日销售 2 数',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(10))),
                  detail: Text(
                    '￥ 200.00',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  padding: EdgeInsets.fromLTRB(14, 11, 14, 11)),
              _buildColorItem(
                  title: Text('今日销售 2 数',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(10))),
                  detail: Text(
                    '￥ 200.00',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                  padding: EdgeInsets.fromLTRB(14, 11, 14, 11)),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: SearchCompoennt(
              onPress: (value) {
                context.read<OrderPageProvider>().searchValue = value;
                fetchOrderList();
              },
              onCancel: (value) {
                // scrollController.jumpTo(0);
                context.read<OrderPageProvider>().searchValue = '';
                fetchOrderList();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: _buildOrderTimeItem(_startTime, () async {
                    var _time = await _showDatePicker();

                    if (_time != '') {
                      setState(() {
                        _startTime = _time;
                      });
                    }
                  }),
                ),
                Container(
                  margin: EdgeInsets.only(right: 4),
                  child: _buildOrderTimeItem(_endTime, () async {
                    var _time = await _showDatePicker();
                    if (_time != '') {
                      setState(() {
                        _endTime = _time;
                      });
                    }
                  }, placeholder: '请选择结束日期'),
                ),
                Container(
                  width: ScreenUtil().setWidth(70),
                  height: ScreenUtil().setHeight(25),
                  child: OutlinedButton(
                      onPressed: () => {onFilterOrderList()},
                      child: const Text('筛选')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    int total = context.watch<OrderPageProvider>().total;
    List<Order> orderList = context.watch<OrderPageProvider>().orderList;

    bool _loadMore = total < orderList.length;

    List<OrderByTime> orderListByTime =
        context.watch<OrderPageProvider>().orderListByTime;

    Widget child;
    if (orderListByTime != null && orderListByTime.length > 0) {
      child = ListView.builder(
        shrinkWrap: true,
        itemCount: orderListByTime.length,
        padding: const EdgeInsets.all(4),
        itemBuilder: (BuildContext context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 12),
                alignment: Alignment.centerLeft,
                width: 330.w,
                height: 25.w,
                color: Colors.black12,
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(width: 5, color: Colors.blue))),
                  child: Text(
                    orderListByTime[index].title,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              Column(
                  children: orderListByTime[index].data.map((_dataItem) {
                return OrderItem(item: _dataItem);
              }).toList())
            ],
          );
        },
      );
    } else {
      child = InkWell(
        onTap: () async {
          await context.read<HomePageProvider>().getProducts();
        },
        child: _buildEemptyView(emptyText: '暂无订单数据'),
      );
    }

    return Expanded(
      child: EasyRefresh(
        onLoad: _loadMore
            ? () async {
                await context.read<OrderPageProvider>().loadMoreOrder();
              }
            : null,
        footer: ClassicalFooter(
            bgColor: Colors.white,
            textColor: Colors.black38,
            noMoreText: '已经到底啦',
            loadReadyText: '上拉加载',
            loadText: '上拉加载更多',
            loadingText: '加载中...',
            loadedText: '加载成功',
            showInfo: false),
        child: child,
      ),
    );
  }

  Widget _buildOrderTimeItem(
    String value,
    Function onPressed, {
    placeholder,
  }) {
    final _style =
        TextStyle(fontSize: ScreenUtil().setSp(10), color: Colors.black45);

    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.all(9),
        width: 115.w,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(3))),
        alignment: Alignment.center,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 11),
                child: value != null && value != ''
                    ? Text(
                        format.format(DateTime.parse(value)).toString(),
                        style: _style,
                      )
                    : Text(
                        placeholder ?? '请选择起始日期',
                        style: _style,
                      ),
              ),
              Image(
                  image: AssetImage('assets/icon_riqi.png'),
                  width: 12.w,
                  height: 12.w),
            ]),
      ),
    );
  }

  Widget _buildOrderDetailInfoItem({img, title, value, color, onPressed}) {
    return InkWell(
      onTap: () => {
        if (onPressed != null) {onPressed()}
      },
      child: Container(
        width: 180.w,
        padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              child: Image(
                image: AssetImage(img),
                width: 13.w,
                height: 13.w,
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(11),
                        color: Colors.black45)),
                Text(value,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(11),
                        color: color != null ? color : Colors.black45))
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailInfo() {
    var orderDetail = context.watch<OrderPageProvider>().orderDetail;

    if (orderDetail != null) {
      return Container(
        padding: EdgeInsets.only(top: 11),
        child: Wrap(
          spacing: 11,
          children: [
            _buildOrderDetailInfoItem(
                img: 'assets/icon_cashier.png',
                title: '订单状态',
                value: OrderPageProvider.getOrderStatus(orderDetail.transFlag),
                color: Colors.blue),
            _buildOrderDetailInfoItem(
                img: 'assets/icon_cashier.png',
                title: '收银员',
                value: orderDetail.cashierName),
            _buildOrderDetailInfoItem(
                img: 'assets/icon_cashier.png',
                title: '单号',
                value: orderDetail.orderNo,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: orderDetail.orderNo));
                }),
            _buildOrderDetailInfoItem(
                img: 'assets/icon_cashier.png',
                title: '时间',
                value: orderDetail.createTime),
          ],
        ),
      );
    } else {
      return Text('null');
    }
  }

  Widget _buildOrderDetailBar() {
    final buttonStyle = OutlinedButton.styleFrom(
        side: const BorderSide(width: 1, color: Colors.blue));
    return Padding(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: ScreenUtil().setHeight(30),
              width: ScreenUtil().setWidth(90),
              margin: const EdgeInsets.only(right: 6),
              child: OutlinedButton(
                style: buttonStyle,
                onPressed: () => {_scaffoldKey.currentState!.openDrawer()},
                child: const Text('退货'),
              ),
            )
          ],
        ));
  }

  Widget _buildOrderListItem(List renderList, {color, bordered}) {
    var textStyle =
        TextStyle(fontSize: ScreenUtil().setSp(11), color: Colors.black45);

    return Container(
      alignment: Alignment.center,
      height: 32.w,
      decoration: BoxDecoration(
          color: color != null ? color : Colors.transparent,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
          children: renderList.map((item) {
        return Expanded(
          flex: 1,
          child: Text(
            item['name'],
            textAlign: item['align'] != null ? item['align'] : TextAlign.center,
            style: textStyle,
          ),
        );
      }).toList()),
    );
  }

  Widget _buildOrderListView() {
    var orderDetail = context.watch<OrderPageProvider>().orderDetail;

    if (orderDetail != null && orderDetail.productList.length > 0) {
      return ListView.builder(
          itemCount: orderDetail.productList.length,
          itemBuilder: (BuildContext context, index) {
            return _buildOrderListItem([
              {"name": orderDetail.productList[index].productName},
              {"name": '￥${orderDetail.productList[index].sendUnitPrice}'},
              {"name": '${orderDetail.productList[index].num}'},
              {"name": '￥${orderDetail.productList[index].totalAmount}'},
            ]);
          });
    } else {
      return _buildEemptyView();
    }
  }

  Widget _buildOrderPriceCard() {
    var orderDetail = context.watch<OrderPageProvider>().orderDetail;

    var textStyle =
        TextStyle(fontSize: ScreenUtil().setSp(13), color: Colors.white);

    if (orderDetail != null) {
      return Container(
        width: 205.w,
        height: 80.w,
        decoration: BoxDecoration(
            color: Colors.red.shade400,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '应收金额',
                    style: textStyle,
                  ),
                  Text(
                    '￥${orderDetail.amt}',
                    style: textStyle,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '应收金额',
                    style: textStyle,
                  ),
                  Text(
                    '￥${orderDetail.amt}',
                    style: textStyle,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Text('null');
    }
  }

  Widget _buildOrderPrice() {
    var orderDetail = context.watch<OrderPageProvider>().orderDetail;
    if (orderDetail != null) {
      return Column(
        children: [
          _buildOrderListItem([
            {"name": '商品数量', "align": TextAlign.start},
            {"name": '${orderDetail.totalNum}', "align": TextAlign.end},
          ]),
          _buildOrderListItem([
            {"name": '原价金额', "align": TextAlign.start},
            {"name": '￥${orderDetail.originalAmt}', "align": TextAlign.end},
          ]),
          _buildOrderListItem([
            {"name": '商品优惠', "align": TextAlign.start},
            {
              "name": '-￥${orderDetail.productDiscount}',
              "align": TextAlign.end
            },
          ]),
          _buildOrderListItem([
            {"name": '整单优惠', "align": TextAlign.start},
            {"name": '-￥${orderDetail.priceDiscount}', "align": TextAlign.end},
          ])
        ],
      );
    } else {
      return Text('');
    }
  }

  // 退货 弹窗
  Widget _buildRefundDrawer() {
    return DrawerModal(
      buttons: [DrawerButton('退货')],
      title: '退货',
      child: ListView(
        children: [Text('data')],
      ),
    );
  }

  Widget _buildEemptyView({emptyText = ''}) {
    return Center(
      child: Column(
        children: [
          Image(
            width: 190.w,
            height: 190.w,
            image: AssetImage('assets/img_no_goods.png'),
          ),
          emptyText != null
              ? Text(emptyText,
                  style: TextStyle(
                      color: Colors.black45, fontSize: ScreenUtil().setSp(12)))
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
