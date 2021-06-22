/* 主页面
 * @Author: centerm.gaohan 
 * @Date: 2021-05-26 11:34:55 
 * @Last Modified by: centerm.gaohan
 * @Last Modified time: 2021-06-01 10:09:39
 */
import 'package:flutter/material.dart';
import 'package:pc_app/common/global.dart';
import 'package:pc_app/component/navbar.dart';
import 'package:pc_app/pages/refund.dart';
import 'package:pc_app/provider/route.dart';
import 'package:pc_app/pages/member.dart';
import 'package:pc_app/pages/sign/login.dart';
import 'package:pc_app/service/service_url.dart';
import 'package:provider/provider.dart';
import './home.dart';
import './order.dart';
import '../component/navbar.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
  }

  final List<Widget> bodyList = [
    HomePage(),
    OrderPage(),
    MemberPage(),
    RefundPage(),
  ];
  @override
  Widget build(BuildContext context) {
    ServiceUtil.ctx = context;
    return FutureBuilder(
      future: Global.init(context),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Scaffold(
            appBar: Navbar(),
            body: IndexedStack(
              index: context.watch<RouteProvider>().index,
              children: bodyList,
            ),
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}
