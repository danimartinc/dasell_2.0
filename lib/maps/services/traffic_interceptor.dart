import 'package:dio/dio.dart';


class TrafficInterceptor extends Interceptor {

  final accessToken = 'pk.eyJ1IjoiZGFuaW1hcnRpbmMiLCJhIjoiY2w0dTIyYzRoMGs3ejNkcGhienZnbXBxdCJ9.xnJnHGoayLy9B79G0PZ4Iw';
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });


    super.onRequest(options, handler);
  }


}
