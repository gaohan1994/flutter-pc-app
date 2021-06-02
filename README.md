# pc_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Fluro

新增路由组件

- [fluro 例子](https://github.com/lukepighetti/fluro/blob/master/example/lib/config/route_handlers.dart)

第一步创建 Routes 类
定义路由地址以及未找到等 handler

```dart
class Routes {
  static String root = '/';

  // 订单主页
  static String order = '/order';

  static void configureRoute(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print('Routes was not founded');
    });
  }
}

```

第二步编写 handlers
指定每个路由地址触发的函数(跳转至指定页面或者配置参数)

```dart

// 订单主页面Handler
Handler orderHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return OrderPage();



var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeComponent();
});

var demoRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String message = params["message"]?.first;
  String colorHex = params["color_hex"]?.first;
  String result = params["result"]?.first;
  Color color = Color(0xFFFFFFFF);
  if (colorHex != null && colorHex.length > 0) {
    color = Color(ColorHelpers.fromHexString(colorHex));
  }
  return DemoSimpleComponent(message: message, color: color, result: result);
});

var demoFunctionHandler = Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String message = params["message"]?.first;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Hey Hey!",
              style: TextStyle(
                color: const Color(0xFF00D6F7),
                fontFamily: "Lazer84",
                fontSize: 22.0,
              ),
            ),
            content: Text("$message"),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 8.0, right: 8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("OK"),
                ),
              ),
            ],
          );
        },
      );
      return;
    });

var deepLinkHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String colorHex = params["color_hex"]?.first;
  String result = params["result"]?.first;
  Color color = Color(0xFFFFFFFF);
  if (colorHex != null && colorHex.length > 0) {
    color = Color(ColorHelpers.fromHexString(colorHex));
  }
  return DemoSimpleComponent(
      message: "DEEEEEP LINK!!!", color: color, result: result);
});
});

```

第三部在 configureRoute 函数中加入 router.define

```dart
  // 配置路由
  static void configureRoute(FluroRouter router) {
    // 未找到指定路由触发的handler
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print('Routes was not founded');
    });

    // 定义订单主页的路由
    router.define(order, handler: orderHandler);
  }
```

## Provider

新增 provider

- [provider 官方网站](https://pub.dev/packages/provider)

安装 flutter pub add provider
使用 import 'package:provider/provider.dart';

provider 类似 redux 是数据存储方案

目前流程大概如下，我以主页面切换导航栏的 index 为例

1、编写 model

创建一个 model，继承 ChangeNotifier，保存导航栏的 index

```dart
class RouteProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void changeIndex(value) {
    print('value:  ${value}');
    _index = value;
    notifyListeners();
  }
}

```

2、在主函数中插入 RouteProvider

```dart
// 创建 Provider
  runApp(MultiProvider(
    // 导航index的provider
    providers: [ChangeNotifierProvider(create: (_) => RouteProvider())],
    child: const MyApp(),
  ));
```

3、调取 index 的值和传递值

```dart
IndexedStack(
  index: context.watch<RouteProvider>().index,
  children: bodyList,
);

TextButton.icon(
  style: ButtonStyle(
      minimumSize: MaterialStateProperty.all(const Size(80, 38))),
  onPressed: () =>
      context.read<RouteProvider>().changeIndex(item['type']),
  icon: Icon(
    item['icon'],
    color: Colors.white,
    size: 11,
  ),
  label: Text(
    item['title'],
    style: const TextStyle(color: Colors.white, fontSize: 13),
  ));
}
```

## 和一般开发不一样的地方

1、自适应填满的 button

```dart
ElevatedButton(
  onPressed: () => {},
  child: Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    child: Text(
      '结算',
      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
    ),
  ),
  style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.red)),
)
```

2、ListView 目前一行只允许一个且填满
如果遇到一行多个且滑动的则设计成如下

```Dart
ListView(
  children: [Wrap(children: listWidget)],
)
```

```Dart

  TextFormField({
    Key key,
    controller,//常用于赋值和取值操作
    String initialValue,
    FocusNode focusNode,//用于监听焦点状态
    InputDecoration decoration = const InputDecoration(), //输入框的装饰器，用来修改外观
    TextInputType keyboardType,//设置输入类型，不同的输入类型键盘不一样
    TextCapitalization textCapitalization = TextCapitalization.none,//开启键盘选择大写或小写
        enum TextCapitalization {
          words,//默认为每个单词的第一个字母使用大写键盘。
          sentences,//默认为每个句子的第一个字母使用大写键盘。
          characters,//每个字符默认使用大写键盘。
          none,// 默认为小写键盘。
        }
    TextInputAction textInputAction, //用于控制键盘动作（一般位于右下角，默认是完成）
    TextStyle style,//输入的文本样式
    StrutStyle strutStyle,
    TextDirection textDirection,//输入的文字排列方向，一般不会修改这个属性
    TextAlign textAlign = TextAlign.start,  //输入的文本位置
    TextAlignVertical textAlignVertical,
    bool autofocus = false,//是否自动获取焦点
    bool readOnly = false,//文本是否可以更改。当设置为true时，文本不能通过任何快捷键或键盘操作进行修改。文本仍然是可选择的。
    ToolbarOptions toolbarOptions,//默认工具栏选项，当用户右键单击或长按EditableText时将显示该菜单。它包括几个选项：剪切，复制，粘贴和全选。
    bool showCursor,//是否显示光标
    bool obscureText = false,//是否隐藏正在编辑的文本 （密码）
    bool autocorrect = true,//是否启用自动效验
    bool enableSuggestions = true,//是否在输入时给出建议
    bool autovalidate = false,
    bool maxLengthEnforced = true,//配合maxLength一起使用，在达到最大长度时是否阻止输入
    int maxLines = 1,//输入文本最大显示行数
    int minLines,//输入文本最小显示行数
    bool expands = false,
    int maxLength,//输入文本可输入最长字符长度
    ValueChanged<String> onChanged,//输入文本发生变化时的回调
    GestureTapCallback onTap,//单击输入文本框时回调
    VoidCallback onEditingComplete,//点击键盘完成按钮时触发的回调，该回调没有参数，(){}
    ValueChanged<String> onFieldSubmitted,//当用户指示他们已完成字段中文本的编辑时调用。
    FormFieldSetter<String> onSaved,//配合Form使用由_formKey.currentState.save();触发保存数据，赋值操作。
    FormFieldValidator<String> validator,//配合Form使用由_formKey.currentState.validate();触发，常用检查否错误，并返回提示用户，返回内容赋值给 errorText
    List<TextInputFormatter> inputFormatters,//输入文本规则限制
              [
              WhitelistingTextInputFormatter(RegExp("[a-z]")),//只允许输入小写的a-z
              BlacklistingTextInputFormatter(RegExp("[a-z]")),除了小写的a-z都可以输入
              LengthLimitingTextInputFormatter(5)
              ]//限制输入字符长度
    bool enabled = true,
    double cursorWidth = 2.0,//光标的宽度
    Radius cursorRadius,//光标的圆角
    Color cursorColor, //光标的颜色
    Brightness keyboardAppearance,//键盘外观
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,//如果为真，则长按此文本字段将选择文本并显示剪切/复制/粘贴菜单，而轻击将移动文本插入符号。[…]
    InputCounterWidgetBuilder buildCounter,
  })
InputDecoration({
    this.icon,    //位于装饰器外部和输入框前面的图片
    this.labelText,  //用于描述输入框，例如这个输入框是用来输入用户名还是密码的，当输入框获取焦点时默认会浮动到上方，
    this.labelStyle,  // 控制labelText的样式,接收一个TextStyle类型的值
    this.helperText, //辅助文本，位于输入框下方，如果errorText不为空的话，则helperText不会显示
    this.helperStyle, //helperText的样式
    this.hintText,  //提示文本，位于输入框内部
    this.hintStyle, //hintText的样式
    this.hintMaxLines, //提示信息最大行数
    this.errorText,  //错误信息提示
    this.errorStyle, //errorText的样式
    this.errorMaxLines,   //errorText最大行数
    this.hasFloatingPlaceholder = true,  //labelText是否浮动，默认为true，修改为false则labelText在输入框获取焦点时不会浮动且不显示
    this.isDense,   //改变输入框是否为密集型，默认为false，修改为true时，图标及间距会变小
    this.contentPadding, //内间距
    this.prefixIcon,  //位于输入框内部起始位置的图标。
    this.prefix,   //预先填充的Widget,跟prefixText同时只能出现一个
    this.prefixText,  //预填充的文本，例如手机号前面预先加上区号等
    this.prefixStyle,  //prefixText的样式
    this.suffixIcon, //位于输入框后面的图片,例如一般输入框后面会有个眼睛，控制输入内容是否明文
    this.suffix,  //位于输入框尾部的控件，同样的不能和suffixText同时使用
    this.suffixText,//位于尾部的填充文字
    this.suffixStyle,  //suffixText的样式
    this.counter,//位于输入框右下方的小控件，不能和counterText同时使用
    this.counterText,//位于右下方显示的文本，常用于显示输入的字符数量
    this.counterStyle, //counterText的样式
    this.filled,  //如果为true，则输入使用fillColor指定的颜色填充
    this.fillColor,  //相当于输入框的背景颜色
    this.errorBorder,   //errorText不为空，输入框没有焦点时要显示的边框
    this.focusedBorder,  //输入框有焦点时的边框,如果errorText不为空的话，该属性无效
    this.focusedErrorBorder,  //errorText不为空时，输入框有焦点时的边框
    this.disabledBorder,  //输入框禁用时显示的边框，如果errorText不为空的话，该属性无效
    this.enabledBorder,  //输入框可用时显示的边框，如果errorText不为空的话，该属性无效
    this.border, //正常情况下的border
    this.enabled = true,  //输入框是否可用
    this.semanticCounterText,
    this.alignLabelWithHint,
  })
```

### 注意 Flutter 中的 dialog 和父 widget 不是同一个页面

所以调用父 setstate 不起作用具体参考
https://blog.csdn.net/yumi0629/article/details/81939936
或者参考 home.dart \_buildDelayOrderDialog

### 接口请求

flutter 的接口请求比较扯淡、非常扯淡 不是比价扯淡
flutter 不识别 json 所以请求到数据之后先把请求结果 toString()，在用 fromJson 转成 flutter 能够识别的 json 格式

### 格式化字符串形式的日期

```dart
DateFormat format = DateFormat('yyyy-MM-dd');
var currentOrderTime = format.format(DateTime.parse(currentOrder.createTime)).toString();
```
