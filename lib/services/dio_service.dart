// ignore_for_file: body_might_complete_normally_catch_error

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import 'package:get_storage/get_storage.dart';
import 'package:tech_application/component/constant/my_storage.dart';

class DioService {
  Dio dio = Dio();
  Future<dynamic> getMethod(String url) async {
    return await dio
        .get(url,
            options: Options(
              contentType: "application/json",
              responseType: ResponseType.json,
              method: "GET",
            ))
        .then((response) => response);
    //     .catchError((err) {
    //   if (err is DioException) {
    //     return throw err.response.toString();
    //   }
    // });
  }

  Future<dynamic> postMethod(Map<String, dynamic> map, String url) async {

    var token = GetStorage().read(MyStorage.token);
    dio.options.headers['Authorization'] = "$token";


    return await dio
        .post(url,
            data: dio_service.FormData.fromMap(map),
            options: Options(
                contentType: "application/json",
                responseType: ResponseType.json,
                method: "POST"))
        .then((response) => response)
        .catchError((err) {
      if (err is DioException) {
        return throw err.response!;
      }
    });
  }
}
