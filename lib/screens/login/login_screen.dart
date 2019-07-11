import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:erply_clock_in/auth.dart';
import 'package:erply_clock_in/data/database_helper.dart';
import 'package:erply_clock_in/models/user.dart';
import 'package:erply_clock_in/screens/login/login_screen_presenter.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> implements LoginScreenContract, AuthStateListener {

  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password, _username;

  LoginScreenPresenter _presenter;

  _LoginScreenState() {
    _presenter = new LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  onAuthStateChanged(AuthState state) {

    if(state == AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed("/home");
  }

  final color = const Color(0xffF2CE5E);

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff2B6FF6),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _submit,
        child: Text("Log-in", textAlign: TextAlign.center),
      ),
    );

    var loginForm = new Column(
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  validator: (val) {
                    return val.length < 10
                        ? "Username must have atleast 10 chars"
                        : null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Password",
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                ),
              ),
            ],
          ),
        ),
        _isLoading ? new CircularProgressIndicator() : loginButon
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );


    return Scaffold(
        appBar: null,
        key: scaffoldKey,
        backgroundColor: color,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(36.0),
            children: <Widget> [
              SizedBox(height: 60.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/homescreen.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  loginForm,
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(User user) async {
    _showSnackBar(user.toString());
    setState(() => _isLoading = false);
    var db = new DatabaseHelper();
    await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }
}
// return Column(
//   children: <Widget>[
//   Center( child: Image.asset('assets/homescreen.png')),
// ]
// );




