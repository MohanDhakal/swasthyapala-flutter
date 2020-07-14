import 'package:flutter/material.dart';
import 'package:swasthyapala_flutter/enum/view_state.dart';
import 'package:swasthyapala_flutter/model/posts/post.dart';
import 'package:swasthyapala_flutter/stmgmt/base.dart';
import 'package:swasthyapala_flutter/util/apis/base_api.dart';
import 'package:swasthyapala_flutter/util/apis/post.dart';

class PostBloc extends BaseModel {
  List<Post> postList=[];

//will be called once all the post are fetched from the api

  void addPostListToUi() async {
    setState(ViewState.active);
    postList = await UploadPost().getAllRows(
      BaseAPI.dio,
    );

    setState(ViewState.idle);
  }

  List<Post> get getAllPost => postList;

  //will be called once a new post is added
  Future addNewPost( Post newPost) async {
    //uploads post through api
    setState(ViewState.active);
    await UploadPost().insertData(BaseAPI.dio, data: newPost);
    postList.add(newPost);
    setState(ViewState.idle);
  }

}
