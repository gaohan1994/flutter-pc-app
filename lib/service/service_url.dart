import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/provider/global.dart';
import 'package:pc_app/route/application.dart';
import 'package:provider/provider.dart';

const serviceUrl = 'http://124.71.129.167:8081/inventory-app';

const successCode = 'response.success';

Future requestData(String url, {data, method}) async {
  String _method = method != null ? method : 'post';

  try {
    var token = ServiceUtil.getToken();

    // 如果请求的不是登录接口且没有token则跳转到登录
    if (!url.contains('oauth/token') && token == null) {
      ServiceUtil.redirectLogin(token);
      return;
    }
    print('开始获取数据...............请求地址:${url}');
    print('开始获取数据...............请求token:${token}');
    print('data: ${data.toString()}');
    Response response;
    Dio dio = Dio();

    var _option;
    // 如果请求的不是登录接口
    if (!url.contains('oauth/token')) {
      _option = Options(headers: {"Authorization": token});
    }

    if (_method == 'post') {
      response = await dio.post(url, data: data, options: _option);
    } else {
      response = await dio.get(url,
          queryParameters: data != null ? data : {}, options: _option);
    }

    if (response.statusCode != 200) {
      throw Exception('报错信息${response.data['msg']}');
    }
    if (response.data['code'] != successCode) {
      throw Exception('报错信息${response.data['msg']}');
    }

    return response;
  } catch (e) {
    print('报错信息：${e.toString()}');
    showToast(e.toString(), textPadding: const EdgeInsets.all(10), radius: 0);
    return null;
  }
}

class ServiceUtil {
  static dynamic ctx;

  // 黑魔法code 保存全局ctx 没有token跳转到 login
  static void redirectLogin(token) {
    Application.router?.navigateTo(ctx, '/login');
  }

  static void showMessage(message) {
    showToast(message, context: ctx);
  }

  static getToken() {
    var user = Provider.of<ProfileChangeNotifier>(ctx, listen: false).user;

    if (user != null) {
      return user.token;
    } else {
      return null;
    }
  }
}
