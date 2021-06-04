import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/model/user.dart';
import 'package:pc_app/provider/global.dart';
import 'package:pc_app/route/application.dart';
import 'package:pc_app/service/login_method.dart';
import 'dart:convert';

import 'package:pc_app/service/service_url.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  String _username = '';

  void _login() async {
    try {
      var result = await oauthToken(params: {
        "phone": "18559239787",
        "password": "96e79218965eb72c92a549dd5a330112"
      });

      var resultMap = json.decode(result.toString());
      print('登录结果: ${resultMap.toString()}');
      UserModel user = UserModel.fromJson(resultMap['data']);

      // 拿到登录信息 在 result.data 中
      // 如果登录成功则存入本地
      // 如果登录失败则报错
      if (resultMap['code'] == successCode) {
        print('user.toJson().toString(): ${json.encode(user.toJson())}');

        SharedPreferences sp = await SharedPreferences.getInstance();
        var saveTokenResult =
            await sp.setString('token', user.token.toString());
        // print('保存token是否成功: ${saveTokenResult}');
        context.read<ProfileChangeNotifier>().user = user;
        Application.router?.navigateTo(context, '/');
      }
    } catch (e) {
      print('登录报错:${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 960.w,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: 270.w,
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: '请输入手机号',
                    labelText: '手机号',
                    icon: Icon(Icons.supervised_user_circle)),
              ),
              TextFormField(
                obscureText: true,
                // keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    hintText: '请输入密码', labelText: '密码', icon: Icon(Icons.lock)),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.w),
                child: Column(
                  children: [
                    Container(
                      width: 270.w,
                      height: 35.w,
                      child: ElevatedButton(
                          onPressed: () => _login(), child: Text('登录')),
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
