import 'package:pc_app/service/service_url.dart';

Future productInfoList({dynamic params}) async {
  return requestData('${serviceUrl}/api/product/productInfo/list',
      data: params, method: 'get');
}

Future productInfoType({dynamic params}) async {
  return requestData('${serviceUrl}/api/product/productInfo/type',
      data: params, method: 'get');
}

Future fetchProductDetail({dynamic id}) async {
  return requestData('${serviceUrl}/api/product/productInfo/detail/$id',
      method: 'get');
}
