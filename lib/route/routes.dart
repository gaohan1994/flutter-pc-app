/* 
 * 创建路由
 * @Author: centerm.gaohan 
 * @Date: 2021-05-26 10:55:38 
 * @Last Modified by: centerm.gaohan
 * @Last Modified time: 2021-05-31 12:12:10
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import "./route_handlers.dart";

class Routes {
  static String root = '/';

  // 订单主页
  static String order = '/order';

  static String login = '/login';

  // 配置路由
  static void configureRoute(FluroRouter router) {
    // 未找到指定路由触发的handler
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print('Routes was not founded');
    });

    router.define(root, handler: rootHandler);

    // 定义订单主页的路由
    router.define(order, handler: orderHandler);

    // 登录页面
    router.define(login, handler: loginHandler);

    // 更多->商品
    router.define('/product', handler: handlerProduct);
  }
}
