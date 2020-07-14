import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/stmgmt/image_progress.dart';
import 'package:swasthyapala_flutter/util/services/converter.dart';
import 'package:swasthyapala_flutter/util/services/shared_pref/user_data.dart';
import 'package:swasthyapala_flutter/util/services/storage_acess.dart';

import 'base_api.dart';

class UploadImage extends BaseAPI {
  var _image;
  BuildContext context;
  var progress;

  UploadImage(context) {
    this.context = context;
    progress = Provider.of<ImageProgress>(context, listen: false);
  }

  @override
  Future insertData(Dio dio, {dynamic data}) async {
    _image = await getImageFromGallery().catchError((e) {
      print('Error picking image: ${e.error}');
    });
    progress.file = File(_image.path);

    String fileName = _image.path.split('/').last;
    FormData formData = new FormData.fromMap({
      "userId": TempStorage().getUserId(),
      "image": await MultipartFile.fromFile(_image.path, filename: fileName)
    });

    final endPoint = '/upload.php';
    try {
      final response = await dio.post(endPoint, data: formData,
          onSendProgress: (int sent, int total) {
        print('sent : $sent and total $total');
        var fraction = (sent / total);
        if (fraction < 0.2) {
          progress.progressValue = 0.2;
        } else if (fraction < 0.4) {
          progress.progressValue = 0.5;
        } else if (fraction < 0.8) {
          progress.progressValue = 0.7;
        } else if (fraction < 0.9)
          progress.progressValue = 0.9;
        else
          progress.progressValue = 1.0;
        print(fraction);
//        progress.progressValue = Util.roundThisNum(fraction, 3);
      });
      var jsonData = response.data;
      progress.imageId = jsonData["imageId"];
    } on Exception catch (exception) {
      print(' EXCEPTION CAUGHT: $exception');
    } catch (error) {
      print(' ERROR CAUGHT: $error');
    }
  }

  @override
  void updateDb(Dio dio, {data}) {
    // TODO: implement updateDb
  }

  @override
  Future<dynamic> getAllRows(Dio dio, {data}) {
    return null;
  }

  @override
  Future getARow(Dio dio, {int id}) async {
    Response response;
    var result;
    try {
      final endPoint = '/blog/get_image.php?imageId=$id';
      response = await dio.get(endPoint);
      result = jsonDecode(response.data);
    } on Exception catch (exception) {
      print('Exception in Image API: $exception');
    } catch (error) {
      print('Error in Image API: $error');
    }
    return result == null ? null : getRealUri(result['imageUri']);
  }
}
