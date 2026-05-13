import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),

      headers: {
        "Accept": "application/json",
      },
    ),
  );
}
