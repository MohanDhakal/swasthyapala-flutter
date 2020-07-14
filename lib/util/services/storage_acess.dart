import 'dart:io';

import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();

Future<PickedFile> getImageFromGallery() async {
  print('entered');
  var pickedFile =
      await picker.getImage(source: ImageSource.gallery).catchError((error) {
    print("Image Picker Error: $error");
  });
  print(
      pickedFile == null ? "path is null" : 'from galley: ${pickedFile.path}');
  ;
  if ((File(pickedFile.path).lengthSync()) / (1024 * 1024) > 3) {
    pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 70);
  }
  return pickedFile;
}

Future<PickedFile> retrieveLostData(context) async {
  final LostData response = await picker.getLostData();
  if (response.isEmpty) {
    print('Error: response not preserved');
  }
  if (response.file != null) {
    if (response.type == RetrieveType.image) {
      return response.file;
    } else {
      print('Error: file is of video type');
    }
  } else {
    print('Error: ${response.exception.code}');
  }
  return null;
}
