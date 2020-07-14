import 'package:swasthyapala_flutter/enum/view_state.dart';
import 'package:swasthyapala_flutter/model/user/user.dart';
import 'package:swasthyapala_flutter/stmgmt/base.dart';
import 'package:swasthyapala_flutter/util/apis/base_api.dart';
import 'package:swasthyapala_flutter/util/apis/user.dart';
import 'package:swasthyapala_flutter/util/services/shared_pref/user_data.dart';

class UserBloc extends BaseModel {
  User user;

  Future addNewUser(User user) async {
    setState(ViewState.active);
    await UserApi().insertData(BaseAPI.dio, data: user);
    await TempStorage().putUser(user.userName, user.password);
    setState(ViewState.idle);
  }

  void setUserWithId(id) async {
    setState(ViewState.active);
    user = await UserApi().getARow(BaseAPI.dio, id: id);
    setState(ViewState.idle);
  }


  void validateUser(String userName, String password) async {
    setState(ViewState.active);
    bool validated =
        await UserApi().validateUser(username: userName, password: password);
    await TempStorage().putUser(userName, password);
    validated ? setState(ViewState.idle) : setState(ViewState.active);
  }
}
