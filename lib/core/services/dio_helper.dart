import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://codingarabic.online/api/',
    ));
    dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    dio!.options.headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "authorization": "Bearer {Token.getToken()}",
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    dynamic data,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "authorization": "Bearer {Token.getToken()}",
    };
    return await dio!.post(url, data: data);
  }
}
