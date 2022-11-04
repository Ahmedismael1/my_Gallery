import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://technichal.prominaagency.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String? url,
    Map<String, dynamic>? query,
    String? token,
  }) async
  {
    dio!.options.headers =
    {
      'Authorization': 'Bearer $token'
    };

    return await dio!.get(
      url!,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
   required String url,
   required  data,
    String? token
  }) async
  {
    dio!.options.headers =
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return await dio!.post(
      url,
      data: data,
    ).catchError((error) {
      print('error in Post Data Dio ${error.toString()}');
    });
  }

  static Future<Response> putData({
    @required String? url,
    @required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async
  {
    dio!.options.headers =
    {

    };

    return dio!.put(
      url!,
      queryParameters: query,
      data: data,
    );
  }


}