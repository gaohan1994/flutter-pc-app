import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchCompoennt extends StatefulWidget {
  SearchCompoennt({required this.onPress, required this.onCancel});

  Function onPress;

  Function onCancel;

  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<SearchCompoennt> {
  // 创建 TextEditngController
  final TextEditingController _controller = TextEditingController();

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
                        hintText: '请输入商品条码或名称',
                        border: InputBorder.none,
                      )),
                ),
                !_searchValueEmpty
                    ? InkWell(
                        onTap: () => {
                          _controller.clear(),
                          if (widget.onCancel != null)
                            {
                              widget.onCancel(''),
                            }
                        },
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
                  onPressed: () => {widget.onPress(_controller.value.text)},
                  child: const Text('搜索')),
            ),
          )
        ],
      ),
    );
  }
}
