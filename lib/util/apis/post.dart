import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:swasthyapala_flutter/model/posts/post.dart';
import 'package:swasthyapala_flutter/util/apis/base_api.dart';

class UploadPost extends BaseAPI {


  @override
  Future insertData(Dio dio, {dynamic data}) async {
    Response response;
    String jsonData = jsonEncode(data);
    try {
      final endPoint = '/blog/insert_post.php';
      response = await dio.post(endPoint, data: jsonData);
      print(response.statusCode);
      print(response.data);
    } on Exception catch (exception) {
      print('Exception in Post: $exception');
    } catch (error) {
      print('Error in Post: $error');
    }
  }

  @override
  void updateDb(Dio dio,{data}) {
    // TODO: implement updateDb
  }
  @override
  Future<dynamic> getAllRows(Dio dio, {data}) async {
    Response response;
    List<Post> postList = [];

    try {
      final endPoint = '/blog/get_posts.php';

      response = await dio.get(endPoint);
      var parsedList = json.decode(response.data);

      parsedList['posts'].forEach((element) {
        postList.add(Post.fromJson(element));
      });
    } on Exception catch (exception) {
      print('Exception in Post API: $exception');
    } catch (error) {
      print('Error in Post API: $error');
    }
    return postList;
  }

  @override
  Future getARow(Dio dio, {int id}) {
    // TODO: implement getARow
    throw UnimplementedError();
  }
}
