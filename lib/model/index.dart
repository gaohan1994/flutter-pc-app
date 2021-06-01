// abstract

class ResponseModel<T> {
  String code;
  String msg;
  T? data;
  ResponseModel({this.code = '', this.msg = '', this.data});

  factory ResponseModel.fromJson(json) {
    return ResponseModel(
        code: json['code'], msg: json['msg'], data: json['data']);
  }
}
