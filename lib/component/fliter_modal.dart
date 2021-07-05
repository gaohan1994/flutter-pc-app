import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/component/button.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/provider/product.dart';
import 'package:provider/provider.dart';

class FilterButtonItem {
  FilterButtonItem({
    required this.title,
    required this.value,
  });
  // 标题
  final String title;
  // filter的value
  final String value;
}

class FilterSection {
  FilterSection({this.title, required this.items});
  final String? title;
  final List<FilterButtonItem> items;
}

class FilterButton extends StatelessWidget {
  FilterButton(
      {required this.onPressed,
      // this.selectedFilter,
      this.filters = const [],
      this.onClose,
      this.onCancel});

  final Function onPressed;

  // 选中的filter 没法在dialog外层传入所以只能在内部做了。
  // final List<FilterButtonItem>? selectedFilter;

  final List<FilterSection> filters;

  final Function? onClose;

  final Function? onCancel;

  @override
  Widget build(BuildContext context) {
    return GhButton(
      width: 70,
      height: 25,
      title: '筛选',
      onPressed: () {
        showFilterDialog(context);
      },
      outlined: true,
    );
  }

  Future showFilterDialog(BuildContext context) async {
    var option = await showDialog(
        context: context,
        builder: (BuildContext context) {
          List<ProductType> selectedProductType =
              context.watch<ProductProvider>().selectedFilterType;
          // 如果选中了商品分类则把选中的商品传入
          List<FilterButtonItem> selectedFilters = [];

          if (selectedProductType.isNotEmpty) {
            selectedFilters.add(FilterButtonItem(
                title: selectedProductType[0].name,
                value: '${selectedProductType[0].id}'));
          } else {
            // 如果没有选中则是全部分类
            selectedFilters.add(FilterButtonItem(title: '全部分类', value: 'all'));
          }

          return SimpleDialog(
            contentPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(12),
              color: Colors.blue,
              child: Text(
                '退款',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: filters
                        .map((item) => Column(
                              children: [
                                item.title != null
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            bottom: 8.w, left: 4.w),
                                        padding: EdgeInsets.only(left: 8.w),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    width: 3,
                                                    color: Colors.blue))),
                                        child: Text(item.title!,
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                color: Colors.blue)),
                                      )
                                    : Container(),
                                Container(
                                  constraints:
                                      BoxConstraints(maxWidth: (320 + 24).w),
                                  child: Wrap(
                                    children: item.items.map((filter) {
                                      bool selected = false;
                                      if (selectedFilters.isNotEmpty) {
                                        for (int i = 0;
                                            i < selectedFilters.length;
                                            i++) {
                                          if (selectedFilters[i].value ==
                                              filter.value) {
                                            selected = true;
                                          }
                                        }
                                      }

                                      return InkWell(
                                        onTap: () {
                                          onPressed(filter);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              right: 6.w, bottom: 6.w),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3.w)),
                                            border: Border.all(
                                                width: 1,
                                                color: selected == true
                                                    ? Colors.blue
                                                    : Colors.black45),
                                            color: selected
                                                ? Colors.blue[100]
                                                : Colors.transparent,
                                          ),
                                          width: 80.w,
                                          height: 30.w,
                                          child: Text(
                                            filter.title,
                                            style: TextStyle(
                                                color: selected
                                                    ? Colors.blue
                                                    : Colors.black45),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            ))
                        .toList(),
                  ))
            ],
          );
        });

    switch (option) {
      case 'confirm':
        break;
      case 'cancel':
        onCancel!();
        break;
      default:
        onClose!();
        break;
    }
  }
}
