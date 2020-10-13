import 'package:flutter/material.dart';
import 'package:flutter_new/signup.dart';
import 'package:flutter_new/user.dart';
import 'package:flutter_new/login_pre.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> implements LoginContract {
  BuildContext ctx;
  bool isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password;

  LoginPre _presenter;

  _LoginState() {
    _presenter = new LoginPre(this);
  }

  void _signup() {
   // Navigator.pushNamed(context, '/signup', arguments: "test");
    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new Signup())
    );

  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        isLoading = true;
        form.save();
        _presenter.doLogin(_email, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Login"),
      color: Colors.lightBlueAccent,
    );


    var signupBtn = new RaisedButton(
      padding: const EdgeInsets.all(10.0),
      onPressed: _signup,
      child: new Text("Register"),
      color: Colors.lightBlueAccent,
    );

    var loginForm = new Column(
    crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Flutter App",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  onSaved: (val) => _email = val,
                  decoration: new InputDecoration(labelText: "Email"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(labelText: "Password"),
                ),
              )
            ],
          ),
        ),
        new Padding(
            padding: const EdgeInsets.all(10.0),
            child: loginBtn),

        signupBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),

    );
  }

  @override
  void onLoginError(String error) {
    _showSnackBar("Login not successful");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if(user.username == ""){
      _showSnackBar("Login not successful");
    }else{
      _showSnackBar(user.toString());
    }
    setState(() {
      isLoading = false;
    });
    if(user.flaglogged == "logged"){
      print("Logged");
      Navigator.of(context).pushNamed("/home");
    }else{
      print("Not Logged");
    }
  }
}