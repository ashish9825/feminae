import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  String _tokenString = "";
  final PublishSubject _isSessionValid = PublishSubject<String>();
  Stream<String> get isSessionValid => _isSessionValid.stream;

  void dispose() {
    _isSessionValid.close();
  }

  void restoreSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenString = prefs.get("token");

    if (_tokenString != null && _tokenString.length > 0) {
      _isSessionValid.sink.add(_tokenString);
    } else {
      _isSessionValid.sink.add("None");
    }
  }

  void openSession(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    _tokenString = token;
    _isSessionValid.sink.add(token);
  }

  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    _isSessionValid.sink.add("None");
  }

  void setNoUserFound(bool authUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("no_user", authUser);
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}

final authBloc = AuthBloc();
