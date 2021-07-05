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

Future genBarcode() async {
  return requestData('${serviceUrl}/api/product/productInfo/genBarcode',
      method: 'get');
}

Future fetchSupplier() async {
  return requestData('${serviceUrl}/api/product/productInfo/supplier',
      method: 'get');
}

Future fetchProductAdd({dynamic params}) async {
  return requestData('${serviceUrl}/api/product/productInfo/add',
      data: params, method: 'post');
}

Future fetchProductEdit({dynamic params}) async {
  return requestData('${serviceUrl}/api/product/productInfo/edit',
      data: params, method: 'post');
}
