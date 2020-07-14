import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:swasthyapala_flutter/model/user/user.dart';
import 'package:swasthyapala_flutter/util/apis/base_api.dart';

class UserApi extends BaseAPI {
  @override
  Future getAllRows(Dio dio, {data}) {
    // TODO: get all the user from the api
    throw UnimplementedError();
  }

  @override
  Future insertData(Dio dio, {data}) async {
    Response response;
    var user;
    try {
      final endPoint = '/user/insert_user.php';
      final jsonData = jsonEncode(data);
      response = await dio.post(endPoint, data: jsonData);
    } on Exception catch (exception) {
      print('Exception in User API: $exception');
    } catch (error) {
      print('Error in User API: $error');
    }
    return response.data["userId"];
  }

  @override
  void updateDb(Dio dio, {data}) {
    // TODO: update the user data
  }

  @override
  Future<dynamic> getARow(Dio dio, {int id}) async {
    // TODO: get an user with provided id
    Response response;
    var user;
    try {
      final endPoint = '/user/get_user.php?userId=$id';
      response = await dio.get(endPoint);
      var decodedJson = json.decode(response.data);
      user = User.fromJson(decodedJson);
    } on Exception catch (exception) {
      print('Exception in User API: $exception');
    } catch (error) {
      print('Error in User API: $error');
    }
    return user;
  }

  Future validateUser({String username, String password}) async {
    Response response;
    var user = {"userName": username, "password": password};
    var result;
    Dio dio = BaseAPI.dio;

    try {
      final endPoint = '/user/validate_user.php';
      response = await dio.post(endPoint, data: user);
      result = jsonDecode(response.data);
    } on Exception catch (exception) {
      print('Exception in Post API: $exception');
    } catch (error) {
      print('Error in Post API: $error');
    }
    return result;
  }
}
