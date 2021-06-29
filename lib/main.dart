import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/provider/cart.dart';
import 'package:pc_app/provider/global.dart';
import 'package:pc_app/provider/home.dart';
import 'package:pc_app/provider/member.dart';
import 'package:pc_app/provider/order.dart';
import 'package:pc_app/provider/product.dart';
import 'package:pc_app/provider/report.dart';
import 'package:pc_app/provider/route.dart';
import 'package:pc_app/route/application.dart';
import 'package:fluro/fluro.dart';
import './route/routes.dart';
import './route/application.dart';
import './pages/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(const MyApp());
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

    // 创建 Provider
    // 导航index的provider
    var routeProvider = RouteProvider();
    // home 收银台页面的provider
    var homePageProvider = HomePageProvider();
    // order 页面的provider
    var orderPageProvider = OrderPageProvider();
    // 报表的 provider
    var reportProvider = ReportProvider();
    // 全局 provider
    var profileChangeNotifier = ProfileChangeNotifier();
    // 会员 provider
    var memberProvider = MemberProvider();
    // 购物车 provider
    var cartProvider = CartProvider();

    // 商品 provider
    var productProvider = ProductProvider();

    // 初始化screenUtil
    return ScreenUtilInit(
      designSize: const Size(960, 540),
      builder: () => OKToast(
          child: MultiProvider(
              providers: [
            ChangeNotifierProvider(create: (_) => routeProvider),
            ChangeNotifierProvider(
              create: (_) => homePageProvider,
            ),
            ChangeNotifierProvider(
              create: (_) => orderPageProvider,
            ),
            ChangeNotifierProvider(create: (_) => reportProvider),
            ChangeNotifierProvider(create: (_) => profileChangeNotifier),
            ChangeNotifierProvider(create: (_) => memberProvider),
            ChangeNotifierProvider(create: (_) => cartProvider),
            ChangeNotifierProvider(create: (_) => productProvider),
          ],
              child: MaterialApp(
                  title: '星亿腾',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  // 初始化loading组件
                  builder: EasyLoading.init(),
                  // 添加国际化
                  localizationsDelegates: [
                    // 本地化的代理类
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale('en', 'US'), // 美国英语
                    const Locale('zh', 'CN'), // 中文简体
                    //其它Locales
                  ],
                  navigatorKey: navigatorKey,
                  locale: const Locale('zh', 'CN'),
                  home: Container(
                    constraints: BoxConstraints(
                        maxHeight: 540.h,
                        maxWidth: 960.w,
                        minWidth: 960.w,
                        minHeight: 540.h),
                    child: IndexPage(),
                  )))),
    );
  }
}
