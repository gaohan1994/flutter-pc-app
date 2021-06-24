import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/component/form/form_input.dart';
import 'package:pc_app/model/user.dart';
import 'package:pc_app/pages/sign/component.dart';
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
  String _username = '18559239787';

  String _password = '111111';

  bool selected = false;

  void _login() async {
    try {
      print('_username: ${_username}');
      // if (_username.isEmpty) {
      //   throw Exception('请输入用户名');
      // }
      // if (_password.isEmpty) {
      //   throw Exception('请输入密码');
      // }

      String md5Passwrod = md5.convert(utf8.encode(_password)).toString();
      print('md5Passwrod: ${md5Passwrod}');

      var params = {"phone": _username, "password": md5Passwrod};

      var result = await oauthToken(params: params);

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
        Application.router?.navigateTo(context, '/', replace: true);
      }
    } catch (e) {
      showToast(e.toString());
      print('登录报错:${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundView(
            child: Container(
                margin: EdgeInsets.only(left: 514.w, top: 240.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GhFormInput(
                      width: 266.w,
                      hintText: '请输入账号',
                      text: _username,
                      inputCallBack: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                      leftWidget: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          child: Image(
                            width: 14.w,
                            height: 14.w,
                            image: AssetImage('assets/lo_user.png'),
                          )),
                    ),
                    GhFormInput(
                      width: 266.w,
                      obscureText: true,
                      hintText: '请输入密码',
                      text: _password,
                      inputCallBack: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      leftWidget: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          child: Image(
                            width: 14.w,
                            height: 14.w,
                            image: AssetImage('assets/lo_mima.png'),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 33.w),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selected = !selected;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              child: selected == true
                                  ? Image(
                                      width: 10.w,
                                      height: 10.w,
                                      image: AssetImage(
                                          'assets/img_checkbox_sel.png'))
                                  : Image(
                                      width: 10.w,
                                      height: 10.w,
                                      image: AssetImage(
                                          'assets/img_checkbox_nol.png')),
                            ),
                          ),
                          Text(
                            '登录代表您已同意《用户协议》和《隐私权政策》',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(11),
                                color: Colors.black45),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 22.h),
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
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 17.h),
                        width: 266.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '立即注册',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(11),
                                  color: Colors.blue),
                            ),
                            Text(
                              '忘记密码？',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(11),
                                  color: Colors.black45),
                            )
                          ],
                        )),
                  ],
                ))));
  }
}
