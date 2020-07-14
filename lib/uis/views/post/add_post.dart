import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyapala_flutter/model/posts/post.dart';
import 'package:swasthyapala_flutter/model/posts/tag_items.dart';
import 'package:swasthyapala_flutter/stmgmt/image_progress.dart';
import 'package:swasthyapala_flutter/stmgmt/post.dart';
import 'package:swasthyapala_flutter/uis/views/post/widgets/pick_image.dart';
import 'package:swasthyapala_flutter/uis/views/post/widgets/tags.dart';
import 'package:swasthyapala_flutter/util/constants.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen>
    with SingleTickerProviderStateMixin {
  var _screenWidth;
  var titleLabelText = 'tap to write title ';
  var contentLabelText = 'tap to write content';
  var _globalKey = GlobalKey<FormState>();
  var indexList = [];
  TextEditingController _titleController;
  TextEditingController _contentController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: ChangeNotifierProvider(
            create: (_) => ImageProgress(),
            child: ListView(
              children: <Widget>[
                getTitleBar(context),
                Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: Tags.getAllTags().length,
                      itemBuilder: (context, index) {
                        var tags = Tags.getAllTags();
                        return Tag(
                          tag: tags.elementAt(index),
                          index: index,
                          color: indexList.contains(index) ? Colors.blue : null,
                          onPressed: (selectedIndex) {
                            if (indexList.contains(selectedIndex)) {
                              setState(() {
                                indexList.remove(selectedIndex);
                              });
                            } else {
                              setState(() {
                                indexList.add(selectedIndex);
                              });
                            }
                          },
                        );
                      }),
                ),
                Form(
                    key: _globalKey,
                    child: Column(
                      children: <Widget>[
                        getTitleField(),
                        getContentField(),
                      ],
                    )),
                CustomImagePicker(),
                Consumer<ImageProgress>(builder: (context, progress, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      progress.file != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 8.0, bottom: 8.0),
                              child:
                                  Text('${progress.file.path.split('/').last}'),
                            )
                          : Container(),
                      progress.file == null
                          ? Container()
                          : Stack(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: LinearProgressIndicator(
                                        backgroundColor: Colors.blueAccent,
                                        value: progress.progressValue,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.green)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment(0, 0),
                                  child: Text(progress.progressValue == 1
                                      ? 'image uploaded'
                                      : 'image uploading...'),
                                ),
                              ],
                            ),
                    ],
                  );
                }),
              ],
            )));
  }

  Widget getTitleField() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        onTap: () => setState(() => titleLabelText = 'title'),
        controller: _titleController,
        decoration: InputDecoration(
          labelText: titleLabelText,
          border: InputBorder.none,
          labelStyle: TextStyle(fontSize: Constants.MEDIUM_FONT_SIZE),
          contentPadding: EdgeInsets.all(2),
          hintStyle: TextStyle(fontSize: Constants.SMALL_FONT_SIZE),
          hintText: 'An interesting title',
        ),
        maxLines: 2,
        keyboardType: TextInputType.multiline,
      ),
    );
  }

  Widget getContentField() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SingleChildScrollView(
        child: Container(
          height: 300,
          child: TextFormField(
            onTap: () => setState(() => contentLabelText = 'content'),
            controller: _contentController,
            decoration: InputDecoration(
              labelText: contentLabelText,
              labelStyle: TextStyle(fontSize: Constants.MEDIUM_FONT_SIZE),
              contentPadding: EdgeInsets.all(2),
              hintStyle: TextStyle(fontSize: Constants.SMALL_FONT_SIZE),
              hintText: 'write your content here...',
              border: InputBorder.none,
              alignLabelWithHint: true,
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            maxLength: 1000,
          ),
        ),
      ),
    );
  }

  _handleCancel(previousContext) {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 100),
        child: new AlertDialog(
          title: Text('Confirmation'),
          content: Text('do you want to quit?'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("stay here")),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(previousContext);
                },
                child: Text("go back")),
          ],
        ),
      ),
    );
  }

  Widget getTitleBar(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.cancel,
            color: Colors.grey,
          ),
          color: null,
          onPressed: () => _handleCancel(context),
        ),
        Text('Add a New Post'),
        FlatButton(
            onPressed: null,
            child: Text(
              'save draft',
              style: TextStyle(color: Colors.redAccent),
            )),
        FlatButton(
            onPressed: _addPost,
            child: Text(
              'post',
              style: TextStyle(color: Colors.blueAccent),
            )),
      ],
    );
  }

  _addPost() {
    final newImage = Provider.of<ImageProgress>(context, listen: false);
    var allTags = Tags.getAllTags();
    var post = Post();

    post.userId = 40;
    post.imageId = 34;
    post.title = _titleController.text;
    post.content = _contentController.text;

    indexList.forEach((index) {
      if (post.tags == null) {
        post.tags = allTags.elementAt(index);
      } else {
        post.tags = '${post.tags},${allTags.elementAt(index)}';
      }
    });
    Provider.of<PostBloc>(context).addNewPost( post);
  }
}

class AddPostBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  iconSize: 44,
                  onPressed: () {
                    Navigator.of(context).push(
                      _createRoute(),
                    );
                  }),
              Text('add new post')
            ],
          )),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnim) => AddPostScreen(),
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (context, anim, secondaryAnim, child) {
        //commented code is for offset transiti//
        // var begin = Offset(1.0, 1.0);
        //        var end = Offset(0, 0);
        //        var tween = Tween<Offset>(begin: begin, end: end)
        //            .chain(CurveTween(curve: curve));
        //       return FadeTransition(
        //          opacity: anim.drive(opacityTween),
        //          child: child,
        //        );
        var curve = Curves.easeInOutSine;

        var scaleTween =
            Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: curve));

        return ScaleTransition(
          scale: anim.drive(scaleTween),
          child: child,
        );
      });
}
