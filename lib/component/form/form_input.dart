/**
 *
 *  Created by iotjin on 2020/04/06.
 *  description:  输入行样式，左侧title,右侧输入框，可加自定义widget
 */

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:pc_app/component/form/form_input_field.dart';

const Color _bgColor = Colors.transparent; //背景色
const double _titleSpace = 100.0; //左侧title默认宽
const double _cellHeight = 50.0; //输入、选择样式一行的高度
const int _maxLength = 100; //最大录入长度
const Color _textColor = Colors.black;
const TextStyle _titleStyle = TextStyle(fontSize: 15.0, color: _textColor);
const TextStyle _textStyle = TextStyle(fontSize: 15.0, color: _textColor);
const TextStyle _hintTextStyle =
    TextStyle(fontSize: 15.0, color: Color(0xFFBBBBBB)); //187
const double _lineHeigth = 0.6; //底部线高
const Color _lineColor = Color(0xFFE6E6E6); //线 230

typedef _InputCallBack = void Function(String value);

class GhFormInput extends StatefulWidget {
  final String title;
  final TextAlign titleAlign;
  final String text;
  final double width;
  final String hintText;
  final TextInputType keyboardType; //键盘类型，默认文字
  final bool showRedStar; //显示左侧小红星，默认不显示
  final Widget? mainWidget;
  final Widget? leftWidget; //左侧widget ，默认隐藏
  final Widget? rightWidget; //右侧widget ，默认隐藏
  final int? maxLines; //最大行数，默认显示一行，自动换行，最多展示_maxLines 行
  final int maxLength; //最大长度，默认_maxLength
  final bool showMaxLength; //是否显示右侧最大长度文字，默认不显示
  final bool enabled; //是否可编辑，默认true
  final List<TextInputFormatter>? inputFormatters;
  final _InputCallBack? inputCallBack;
  final double space; //标题宽度
  final TextStyle titleStyle;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;
  final TextAlign textAlign; //输入文字对齐方式，默认左对齐
  final InputBorder border; //输入边框样式，默认无边框
  final bool hiddenLine; //隐藏底部横线
  final bool topAlign; //左侧标题顶部对齐，默认居中
  final Color bgColor; //背景颜色，默认白色
  final TextEditingController? controller;
  final bool obscureText;

  const GhFormInput({
    this.title: '',
    this.titleAlign = TextAlign.left,
    this.text: '',
    this.width = double.infinity,
    this.keyboardType: TextInputType.text,
    this.hintText: '请输入',
    this.showRedStar: false,
    this.mainWidget,
    this.leftWidget,
    this.rightWidget,
    this.maxLines,
    this.maxLength: _maxLength,
    this.showMaxLength: false,
    this.enabled: true,
    this.inputFormatters,
    this.inputCallBack,
    this.space = _titleSpace,
    this.titleStyle = _titleStyle,
    this.textStyle = _textStyle,
    this.hintTextStyle = _hintTextStyle,
    this.textAlign = TextAlign.left,
    this.border = InputBorder.none, //去掉下划线
    this.hiddenLine = false,
    this.topAlign = false,
    this.bgColor = _bgColor,
    this.controller = null,
    this.obscureText = false,
  });

  @override
  _GhFormInputCellState createState() => _GhFormInputCellState();
}

class _GhFormInputCellState extends State<GhFormInput> {
  @override
  Widget build(BuildContext context) {
    double _starW = widget.showRedStar == false && widget.title.isEmpty ? 0 : 8;
    double _topSpace = 0; //title 顶对齐 间距

    return Material(
        color: widget.bgColor,
        child: Container(
            width: widget.width,
            constraints: BoxConstraints(
                // minWidth: widget.width, //宽度尽可能大
                minHeight: _cellHeight //最小高度为50像素
                ),
            padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
            decoration: UnderlineTabIndicator(
                borderSide: BorderSide(
                    width: _lineHeigth,
                    color: widget.hiddenLine == true
                        ? Colors.transparent
                        : _lineColor),
                insets: EdgeInsets.fromLTRB(_starW, 0, 0, 0)),
            child: Row(
                crossAxisAlignment: widget.topAlign == true
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: <Widget>[
                  widget.leftWidget != null ? widget.leftWidget! : Container(),
                  Container(
                    width: _starW,
                    padding: EdgeInsets.fromLTRB(
                        0, widget.topAlign == true ? _topSpace : 0, 0, 0),
                    child: Text(widget.showRedStar ? "*" : " ",
                        style: TextStyle(fontSize: 18.0, color: Colors.red)),
                  ),
                  Offstage(
                    offstage: widget.title.isEmpty ? true : false,
                    child: Container(
                      width: widget.space - _starW,
                      padding: EdgeInsets.fromLTRB(
                          0, widget.topAlign == true ? _topSpace : 0, 14, 0),
                      child: Text(
                        widget.title,
                        style: widget.titleStyle,
                        textAlign: widget.titleAlign,
                      ),
                    ),
                  ),
                  Expanded(
                      child: widget.mainWidget != null
                          ? widget.mainWidget!
                          : GHTextField(
                              text: widget.text,
                              keyboardType: widget.keyboardType,
                              obscureText: widget.obscureText,
                              hintText: widget.hintText,
                              maxLines: widget.maxLines,
                              maxLength: widget.maxLength,
                              showMaxLength: widget.showMaxLength,
                              enabled: widget.enabled,
                              inputFormatters: widget.inputFormatters,
                              inputCallBack: widget.inputCallBack,
                              textStyle: widget.textStyle,
                              hintTextStyle: widget.hintTextStyle,
                              textAlign: widget.textAlign,
                              border: widget.border,
                              controller: widget.controller,
                            )),
                  widget.rightWidget != null
                      ? widget.rightWidget!
                      : Container(),
                ])));
  }
}
