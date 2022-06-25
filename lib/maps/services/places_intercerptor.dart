import 'package:dio/dio.dart';


class PlacesInterceptor extends Interceptor {
  
  final accessToken = 'pk.eyJ1IjoiZGFuaW1hcnRpbmMiLCJhIjoiY2w0dTIyYzRoMGs3ejNkcGhienZnbXBxdCJ9.xnJnHGoayLy9B79G0PZ4Iw';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
    });


    super.onRequest(options, handler);
  }

}
