import 'dart:ui';

import 'package:erply_clock_in/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:erply_clock_in/auth.dart';
import 'package:erply_clock_in/data/database_helper.dart';
import 'package:erply_clock_in/models/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:erply_clock_in/screens/login/login_screen_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginScreen extends StatefulWidget {

  //LoginScreen();
  @override
  State<StatefulWidget> createState() {
    return new _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> implements LoginScreenContract {

  BuildContext _ctx;

  bool isLoggedIn = false;
  String name = '';

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('username');
    print(userId);
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        name = userId;
      });
      Navigator.of(_ctx).pushReplacementNamed("/home");
      return;
    }
  }


  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password, _username;

  LoginScreenPresenter _presenter;

  _LoginScreenState() {

    _presenter = new LoginScreenPresenter(this);

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

 /* @override
  onAuthStateChanged(AuthState state) {
    print("authentication called");
    if(state == AuthState.LOGGED_IN) {
      Navigator.of(_ctx).pushReplacementNamed("/home"); }
  }*/

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
                    return !EmailValidator.validate(val, true)
                        ? "Please enter a valid email"
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
                  obscureText: true,
                  onSaved: (val) => _password = val,
                  validator: (val) {
                    return val.length < 1
                        ? "Please enter password"
                        : null;
                  },
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
        _isLoading ? new CircularProgressIndicator(  backgroundColor: color, valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),) : loginButon
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
    //_onHideLoading();
    setState(() => _isLoading = false);
    _showSnackBar(errorTxt);

  }

  @override
  void onLoginSuccess(LoginResponse response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _isLoading = false);
    // _onHideLoading();
    _showSnackBar("Login successful!");
    Navigator.of(_ctx).pushReplacementNamed("/home");
    setState(() {
      name = prefs.getString('username');
      isLoggedIn = true;
    });
//    var db = new DatabaseHelper();
//    await db.saveUser(response);
//    var authStateProvider = new AuthStateProvider();
//    authStateProvider.notify(AuthState.LOGGED_IN);
  }
  // user defined function
  void _showDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text("$message"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onLoading() {
    showDialog(
      context: scaffoldKey.currentState.context,
      barrierDismissible: false,
      child: new SimpleDialog(
        title: Container(
          child: Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                  child: new Text("Loading"),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onHideLoading() {
    Navigator.pop(scaffoldKey.currentState.context); //pop dialog
  }

  Future<bool> getLoginState() async{
    SharedPreferences pf =  await SharedPreferences.getInstance();
    bool loginState = pf.getBool('loginState');
    return loginState;
    // return pf.commit();
  }
}
// return Column(
//   children: <Widget>[
//   Center( child: Image.asset('assets/homescreen.png')),
// ]
// );




