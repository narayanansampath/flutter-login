import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext _ctx;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _ctx = context;

    final submitButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff2B6FF6),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8.0),
        onPressed: (){},//_submit,
        child: Text("Submit", textAlign: TextAlign.center),
      ),
    );

    var homeForm = new Column(
      children: <Widget>[
        new Padding(
          //Add padding around textfield
          padding: const EdgeInsets.all(8.0),
          child: new TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Enter Email",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Enter Name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          ),
        ),

      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
        actions: <Widget>[
          FlatButton(
            onPressed: logout,
            child: Text(
              "Logout",
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: new Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
          homeForm,
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: submitButon,
          ),

          ],
        ),
      ),
    );
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', null);
    Navigator.of(_ctx).pushReplacementNamed("/");
  }
}
