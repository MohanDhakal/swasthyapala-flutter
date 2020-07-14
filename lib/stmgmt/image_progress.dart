import 'dart:io';

import 'package:swasthyapala_flutter/enum/view_state.dart';
import 'package:swasthyapala_flutter/stmgmt/base.dart';
import 'package:swasthyapala_flutter/util/apis/base_api.dart';
import 'package:swasthyapala_flutter/util/apis/image.dart';

class ImageProgress extends BaseModel {
  double _progressValue;
  File _file;
  String imageUri;
  int imageId;

  double get progressValue => _progressValue;

  set progressValue(value) {
    _progressValue = value;
    notifyListeners();
  }

  set file(image) {
    _file = image;
    notifyListeners();
  }

  File get file => _file;

  void addImageUri(context, int id) async {
    setState(ViewState.active);
    imageUri = await UploadImage(context).getARow(BaseAPI.dio, id: id);
    setState(ViewState.idle);
  }
}
