import 'package:dio/dio.dart';
import 'package:kemet/core/utils/shared_data.dart';

class ApiService {
  final baseUrl = 'https://kemet.onrender.com/';
  final Dio dio;

  ApiService(this.dio);

  Future<Map<String, dynamic>> getData({required String endPoint}) async {
    dio.options.headers = {'token': SharedData.getToken()};
    dio.options.queryParameters = {'lang': SharedData.getUserLan()};
    final response = await dio.get('$baseUrl$endPoint');

    return response.data;
  }
  Future<Map<String, dynamic>> deleteData({required String endPoint}) async {
    dio.options.headers = {'token': SharedData.getToken()};
    dio.options.queryParameters = {'lang': SharedData.getUserLan()};
    final response = await dio.delete('$baseUrl$endPoint');

    return response.data;
  }

  Future<Map<String, dynamic>> postData(
      {required String endPoint, required Object? data}) async {
    dio.options.headers = {
      'token': SharedData.getToken(),
    };
    final response = await dio.post('$baseUrl$endPoint', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> putData(
      {required String endPoint, required Object? data}) async {
    dio.options.headers = {
      'token': SharedData.getToken(),
    };
    final response = await dio.put('$baseUrl$endPoint', data: data);
    return response.data;
  }
}
