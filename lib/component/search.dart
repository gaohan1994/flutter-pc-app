import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef _InputCallBack = void Function(String value);

class SearchCompoennt extends StatefulWidget {
  final String text;
  final String hintText;
  final Function? onCancel;
  final _InputCallBack? inputCallback;

  SearchCompoennt(
      {this.text = '',
      this.hintText = '请输入内容',
      this.inputCallback,
      this.onCancel});

  @override
  createState() => _SearchCompoennt();
}

class _SearchCompoennt extends State<SearchCompoennt> {
  // 创建 TextEditngController
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.text;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool _searchValueEmpty = _controller.value.text.isEmpty;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
            height: 30.w,
            color: Colors.black12,
            padding: EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.black26,
                ),
                Expanded(
                  child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        hintText: widget.hintText,
                        border: InputBorder.none,
                      )),
                ),
                !_searchValueEmpty
                    ? InkWell(
                        onTap: () =>
                            {_controller.clear(), widget.onCancel!('')},
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      )
                    : Text('')
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(
              width: ScreenUtil().setWidth(70),
              height: ScreenUtil().setHeight(30),
              child: ElevatedButton(
                  onPressed: () => {
                        if (widget.inputCallback != null)
                          {widget.inputCallback!(_controller.text)}
                      },
                  child: const Text('搜索')),
            ),
          )
        ],
      ),
    );
  }
}
