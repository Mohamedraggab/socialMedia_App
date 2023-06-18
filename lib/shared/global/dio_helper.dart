import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static initDio() {
    dio = Dio(
      BaseOptions(),
    );
  }

  Future<Response>getData({
    required String path,
    required dynamic query,
  }) async {
    return await dio!.get(path, queryParameters: query);
  }
}
