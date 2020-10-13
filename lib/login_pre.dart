import 'package:flutter_new/rest-data.dart';
import 'package:flutter_new/user.dart';

abstract class LoginContract{
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginPre {
  LoginContract _view;
  RestData api = new RestData();
  LoginPre(this._view);

//Simulator login
  doLogin(String username, String password){
    api
        .login(username, password)
        .then((user) => _view.onLoginSuccess(user))
        .catchError((onError) => _view.onLoginError(onError));
  }
}
