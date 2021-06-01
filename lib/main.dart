import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/provider/home.dart';
import 'package:pc_app/route/application.dart';
import 'package:fluro/fluro.dart';
import './route/routes.dart';
import './route/application.dart';
import './pages/index.dart';
import './model/route.dart';
import 'package:provider/provider.dart';

void main() {
  // 导航index的provider
  var routeProvider = RouteProvider();
  // home 收银台页面的provider
  var homePageProvider = HomePageProvider();

  // 创建 Provider
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => routeProvider),
      ChangeNotifierProvider(
        create: (_) => homePageProvider,
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 创建路由
    final router = FluroRouter();
    Routes.configureRoute(router);
    Application.router = router;

    final GlobalKey<NavigatorState> navigatorKey = NavKey.navKey;

    // 初始化screenUtil
    return ScreenUtilInit(
        designSize: const Size(960, 540),
        builder: () => MaterialApp(
            title: '星亿腾',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            navigatorKey: navigatorKey,
            home: IndexPage()));
  }
}
