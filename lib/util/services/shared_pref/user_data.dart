import 'package:shared_preferences/shared_preferences.dart';

class TempStorage {



  Future putUser(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", username);
    prefs.setString("pass", password);

  }

}
