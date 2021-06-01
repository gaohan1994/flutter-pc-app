/* 主页面
 * @Author: centerm.gaohan 
 * @Date: 2021-05-26 11:34:55 
 * @Last Modified by: centerm.gaohan
 * @Last Modified time: 2021-06-01 10:09:39
 */
import 'package:flutter/material.dart';
import 'package:pc_app/component/navbar.dart';
import 'package:pc_app/model/route.dart';
import 'package:pc_app/provider/home.dart';
import 'package:pc_app/route/application.dart';
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
  final List<Widget> bodyList = [
    HomePage(),
    OrderPage(),
  ];
  @override
  Widget build(BuildContext context) {
    ServiceUtil.ctx = context;
    // final index = context.read<RouteProvider>().index;
    // print("${index}");
    return Scaffold(
      appBar: Navbar(),
      body: IndexedStack(
        index: context.watch<RouteProvider>().index,
        children: bodyList,
      ),
    );
  }
}
