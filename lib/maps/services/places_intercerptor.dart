import 'package:dio/dio.dart';


class PlacesInterceptor extends Interceptor {
  
  final accessToken = 'pk.eyJ1IjoiZGFuaW1hcnRpbmMiLCJhIjoiY2tuaW8ybTNnM2JhYjJydGFkMGFwenQ5ZyJ9.ADthkGKQIjFmeA9OilAbHg';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
    });


    super.onRequest(options, handler);
  }

}
