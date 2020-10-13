import 'package:flutter/material.dart';
import 'package:flutter_new/database-helper.dart';
import 'package:flutter_new/login.dart';
import 'package:flutter_new/user.dart';

class Signup extends StatefulWidget {
  @override
  SignupState createState() => new SignupState();

}

class SignupState  extends State<Signup> {
  BuildContext cont;
  bool isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name, _username, _password;



  @override

  Widget build(BuildContext context) {
    context = cont;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Signup"),
      color: Colors.lightBlueAccent,
    );



    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Flutter App ",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _name = val,
                  decoration: new InputDecoration(labelText: "Name"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(labelText: "Email"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(labelText: "Password"),
                ),
              )
            ],
          ),
        ),
        loginBtn
      ],
    );

    return new Scaffold(

      appBar: new AppBar(
        title: new Text("SignUp"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),

    );

  }

  void showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));

  }

  void _submit(){
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        isLoading = true;
        form.save();
        var user = new User(_name, _username, _password, null);
        var db = new DatabaseHelper();
        db.saveUser(user);
        isLoading = false;
       // Navigator.of(context).pushNamed("/login");
      //  Navigator.pushNamed(context, '/login', arguments: "test");
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) =>
            new Login())
        );
        

      });
    }
  }


}

