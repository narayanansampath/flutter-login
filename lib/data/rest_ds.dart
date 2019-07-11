import 'dart:async';
import 'dart:convert';

import 'package:erply_clock_in/utils/network_util.dart';
import 'package:erply_clock_in/models/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://id-api-sb.erply.com/V1/Launchpad";
  static final LOGIN_URL = BASE_URL + "/login";
  //static final _API_KEY = "somerandomkey";

  Future<User> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "parameters[email]": username,
      "parameters[password]": password
    }).then((dynamic res) {
      //var body = json.decode(res.body);
      print(res.toString());
      if(res["error"]!= null) throw new Exception(res["error_msg"]);
      return new User.map(res["user"]);
      //return new User(username,password);
      //return new User.map(res["user"]);
      //return new Future.value(new User(username, password));
  });
  }
}
