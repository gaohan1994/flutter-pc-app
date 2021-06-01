import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pc_app/route/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

const serviceUrl = 'http://124.71.129.167:21280/inventory-app';

const successCode = 'response.success';

Future requestData(String url, {data, method}) async {
  String _method = method != null ? method : 'post';

  SharedPreferences sp = await SharedPreferences.getInstance();
  var token = sp.getString('token');
  print('token:${token}');

  try {
    // 如果请求的不是登录接口且没有token则跳转到登录
    if (!url.contains('oauth/token') && token == null) {
      ServiceUtil.redirectLogin(token);
      return;
    }

    print('开始获取数据...............请求地址:${url}');
    Response response;
    Dio dio = Dio();

    Options _option = Options(headers: {"Authorization": token});

    if (_method == 'post') {
      response = await dio.post(url, data: data, options: _option);
    } else {
      response = await dio.get(url,
          queryParameters: data != null ? data : {}, options: _option);
    }
    return response;
  } catch (e) {
    print('e: ${e.toString()}');
    return '';
  }
}

class ServiceUtil {
  static dynamic ctx;

  // 黑魔法code 保存全局ctx 没有token跳转到 login
  static void redirectLogin(token) {
    Application.router?.navigateTo(ctx, '/login');
  }
}
