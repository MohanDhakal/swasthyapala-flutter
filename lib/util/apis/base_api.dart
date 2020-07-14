import 'package:dio/dio.dart';

abstract class BaseAPI {
  static const baseUri = 'http://swasthyapala.com/swasthyapala';
  static Dio dio = Dio(BaseOptions(
      baseUrl: baseUri,
      connectTimeout: 10000,
      sendTimeout: 15000,
      receiveTimeout: 5000));

  Future insertData(Dio dio,{dynamic data});
  Future getARow(Dio dio,{int id});

  void updateDb(Dio dio,{dynamic data});
  Future<dynamic> getAllRows(Dio dio,{dynamic data});

}
