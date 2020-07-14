import 'dart:io';
import 'package:flutter/material.dart';
import 'package:swasthyapala_flutter/util/apis/image.dart';
import 'package:swasthyapala_flutter/util/apis/base_api.dart';
import 'package:swasthyapala_flutter/util/services/connection.dart';
import 'package:swasthyapala_flutter/util/utilmethods.dart';

class CustomImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('add a photo',
                    style: TextStyle(
                      color: Colors.blueAccent,
                    )),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10),
                child: Builder(builder: (context) {
                  return GestureDetector(
                      onTap: () async {
                        if (Platform.isAndroid) {
                          if (await Util.storagePermissionAvailable(context)) {
                            if (await Connection.isConnected() == true) {
                              await UploadImage(context).insertData(BaseAPI.dio);
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("no internet connection"),
                              ));
                            }
                          }
                        }
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        size: 30,
                      ));
                }),
              )),
        ],
      ),
    );
  }
}
