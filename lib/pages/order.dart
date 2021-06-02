import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pc_app/component/order.dart';
import 'package:pc_app/component/search.dart';
import 'package:pc_app/model/order.dart';
import 'package:pc_app/provider/home.dart';
import 'package:pc_app/provider/order.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // 主页面 stateful 在这里接入state
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  DateFormat format = DateFormat('yyyy-MM-dd');

  // 创建搜索订单单号或者退货单号的 TextEditingController
  final TextEditingController _controller = TextEditingController();
  // 订单检索开始日期 默认为空
  String _startTime = '';
  // 订单检索结束日期 默认为空
  String _endTime = '';
  // 是否显示搜索列表
  bool showSearchList = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      // 初始化订单列表
      context.read<OrderPageProvider>().getOrderList();
    });
  }

  void fetchOrderList(value) {
    context.read<OrderPageProvider>().getOrderList();
  }

  void searchOrderList(value) {}

  Future<String> _showDatePicker() async {
    Locale myLocale = const Locale('zh');
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
        locale: myLocale);
    return picker != null ? picker.toString() : '';
    // return picker.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        const Expanded(child: Text('data')),
        Container(
          width: 220.w,
          child: Text('data'),
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
                  title: Text('今日销售笔数',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(10))),
                  detail: Text(
                    'data',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orange,
                  padding: EdgeInsets.fromLTRB(14, 11, 14, 11)),
              _buildColorItem(
                  title: Text('今日销售笔数',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(10))),
                  detail: Text(
                    'data',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  padding: EdgeInsets.fromLTRB(14, 11, 14, 11)),
              _buildColorItem(
                  title: Text('今日销售笔数',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(10))),
                  detail: Text(
                    'data',
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
                // scrollController.jumpTo(0);
                setState(() {
                  showSearchList = true;
                });
                fetchOrderList(value);
              },
              onCancel: (value) {
                // scrollController.jumpTo(0);
                setState(() {
                  showSearchList = false;
                });
                fetchOrderList('');
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
                  }),
                ),
                Container(
                  width: ScreenUtil().setWidth(70),
                  height: ScreenUtil().setHeight(25),
                  child: OutlinedButton(
                      onPressed: () => {}, child: const Text('筛选')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    // List<Order> orderList = context.watch<OrderPageProvider>().orderList;

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
        child: const Text('暂无商品'),
      );
    }

    return Expanded(
      child: EasyRefresh(
        onLoad: () async {
          await context.read<OrderPageProvider>().loadMoreOrder();
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
        // height: 25.w,
        width: 115.w,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
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
}
