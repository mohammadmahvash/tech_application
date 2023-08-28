import 'package:dio/dio.dart';

class DioService {
  Future<dynamic> getMethod(String url) async {
    Dio dio = Dio();
    return await dio
        .get(url,
            options: Options(
              contentType: "application/json",
              responseType: ResponseType.json,
              method: "GET",
            ))
        .then((response) => response);
  }
}
