import 'package:shared_preferences/shared_preferences.dart';

class TempStorage {
  Future putUser(String username, String password, [int id]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", username);
    prefs.setString("password", password);
    prefs.setInt('userId', id);
  }

  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("userName") ?? null;
    return user;
  }

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('userId');
    return id;
  }
}
