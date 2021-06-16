import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/component/form/form_input.dart';
import 'package:pc_app/provider/member.dart';
import 'package:pc_app/route/application.dart';
import 'package:pc_app/service/member_method.dart';
import 'package:provider/provider.dart';

class MemberEdit extends StatefulWidget {
  MemberEdit({Key? key, this.isEdit = true}) : super(key: key);

  final bool isEdit;

  createState() => _MemberEdit();
}

class _MemberEdit extends State<MemberEdit> {
  DateFormat format = DateFormat('yyyy-MM-dd');
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerBirthday = TextEditingController();
  int sex = 0;

  @override
  initState() {
    super.initState();
    var memberDetail = context.read<MemberProvider>().memberDetail;

    // 如果是修改则初始化数据
    if (widget.isEdit == true) {
      DateTime birthString = memberDetail.birthDate != null
          ? DateTime.parse(memberDetail.birthDate!)
          : DateTime(2000);

      print('memberDetail.sex${memberDetail.sex}');
      int _sex = memberDetail.sex != null ? int.parse(memberDetail.sex!) : 0;

      setState(() {
        _controllerName.text = memberDetail.username;
        _controllerId.text = '${memberDetail.cardNo}';
        _controllerPhone.text = '${memberDetail.phone}';
        _controllerBirthday.text = format.format(birthString).toString();
        sex = _sex;
      });
    }

    // 如果是新增初始化卡号
    if (widget.isEdit == false) {
      Future.microtask(() async {
        var result = await getRandomCaroNo();
        var resultMap = json.decode(result.toString());
        String randomCode = resultMap['data'];
        print('randomCode: ${randomCode}');
        setState(() {
          _controllerId.text = randomCode;
        });
      });
    }
  }

  Future<String> _showDatePicker() async {
    Locale myLocale = const Locale('zh');
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
        locale: myLocale);
    return picker != null ? picker.toString() : '';
  }

  void updateMember() async {
    if (_controllerId.text.isEmpty) {
      showToast('请输入卡号');
      return;
    }
    if (_controllerPhone.text.isEmpty) {
      showToast('请输入手机号');
      return;
    }
    if (_controllerName.text.isEmpty) {
      showToast('请输入会员名');
      return;
    }

    var memberDetail = context.read<MemberProvider>().memberDetail;

    String birthString =
        format.format(DateTime.parse(_controllerBirthday.text)).toString();

    var params = {
      "birthDate": _controllerBirthday.text.isNotEmpty ? birthString : "",
      "cardNo": _controllerId.text,
      "phone": _controllerPhone.text,
      "sex": "${sex}",
      "status": 1,
      "username": _controllerName.text
    };

    if (widget.isEdit == true) {
      params['id'] = memberDetail.id;
    }
    print('params: ${params.toString()}');

    var fetchFuction = widget.isEdit == true ? memberInfoEdit : memberInfoAdd;
    fetchFuction(params: params).then((value) {
      print('value: ${value}');
      showToast(widget.isEdit == true ? '修改成功！' : '新增成功!');

      context.read<MemberProvider>().getMemberList();
      Application.router?.pop(context);
    });
  }

  Future ftrender() async {
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.isEdit == false ? getRandomCaroNo() : ftrender(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var randomCode;
            // 如果是新增则请求接口并且赋值
            if (widget.isEdit == false) {
              var result = snapshot.data;
              var resultMap = json.decode(result.toString());
              randomCode = resultMap['data'];
            }
            return Container(
              child: Column(
                children: [
                  Container(
                    width: 960.w,
                    height: 40.w,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text(
                      '注册会员',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              _title('基本信息'),
                              GhFormInput(
                                width: 350.w,
                                text: widget.isEdit == false
                                    ? randomCode
                                    : _controllerId.text,
                                title: '卡号',
                                hintText: '请输入卡号',
                                inputCallBack: (value) =>
                                    {_controllerId.text = value},
                              ),
                              GhFormInput(
                                width: 350.w,
                                text: _controllerPhone.text,
                                title: '手机号',
                                hintText: '请输入手机号',
                                inputCallBack: (value) =>
                                    {_controllerPhone.text = value},
                              ),
                              GhFormInput(
                                text: _controllerName.text,
                                width: 350.w,
                                title: '姓名',
                                hintText: '请输入姓名',
                                inputCallBack: (value) =>
                                    {_controllerName.text = value},
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              _title('更多信息'),
                              GhFormInput(
                                width: 350.w,
                                title: '等级',
                                mainWidget: DropdownButton(
                                  underline: Container(height: 0),
                                  isExpanded: true,
                                  value: 'v1',
                                  items: [
                                    DropdownMenuItem(
                                        value: 'v1', child: Text('VIP1')),
                                    DropdownMenuItem(
                                        value: 'v2', child: Text('VIP2'))
                                  ],
                                  onChanged: (value) {
                                    print('value: ${value}');
                                  },
                                ),
                              ),
                              GhFormInput(
                                width: 350.w,
                                hiddenLine: true,
                                title: '性别',
                                mainWidget: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 8.w),
                                          child: _option(0, '先生'),
                                        )),
                                    Expanded(flex: 1, child: _option(1, '女士'))
                                  ],
                                ),
                              ),
                              GhFormInput(
                                width: 350.w,
                                title: '生日',
                                enabled: false,
                                mainWidget: TextField(
                                  decoration: InputDecoration(
                                      hintText: "请选择生日",
                                      border: InputBorder.none),
                                  controller: _controllerBirthday,
                                  enabled: false,
                                ),
                                rightWidget: InkWell(
                                  onTap: () async {
                                    var _time = await _showDatePicker();

                                    if (_time != '') {
                                      var _timeParse = DateTime.parse(_time);
                                      setState(() {
                                        _controllerBirthday.text = format
                                            .format(_timeParse)
                                            .toString();
                                      });
                                    }
                                  },
                                  child: Image(
                                      width: 12.w,
                                      height: 12.w,
                                      image:
                                          AssetImage('assets/icon_riqi.png')),
                                ),
                              ),
                            ],
                          ))
                    ],
                  )),
                  Container(
                    height: ScreenUtil().setHeight(30),
                    width: ScreenUtil().setWidth(90),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: () => updateMember(),
                      child: const Text('确定'),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        });
  }

  Widget _title(title) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        width: 350.w,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 3, color: Colors.blue))),
        child: Text(title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(12), color: Colors.blue)),
      ),
    );
  }

  Widget _option(value, title) {
    final bool _selected = value == sex;
    return InkWell(
      onTap: () {
        setState(() {
          sex = value;
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _selected ? Colors.blue[100] : Colors.transparent,
            border: Border.all(
                width: 1,
                color: _selected ? Colors.blue.shade100 : Colors.black12)),
        height: 30.w,
        child: Text(title,
            style: TextStyle(color: _selected ? Colors.blue : Colors.black)),
      ),
    );
  }
}
