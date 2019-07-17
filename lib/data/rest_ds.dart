import 'dart:async';
import 'dart:convert';

import 'package:erply_clock_in/utils/network_util.dart';
import 'package:erply_clock_in/models/user.dart';
import 'package:erply_clock_in/models/login_response.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://id-api-sb.erply.com/V1/Launchpad";
  static final LOGIN_URL = BASE_URL + "/login";
  //static final _API_KEY = "somerandomkey";

  Future<LoginResponse> login(String username, String password) {
    String jwt;
    return _netUtil.post(LOGIN_URL, body: {
      "parameters[email]": username,
      "parameters[password]": password
    }).then((dynamic res) {
      print(res.toString());
      LoginResponse response = new LoginResponse.fromJson(res);
      //int statusCode = res["status_code"];
      //if (statusCode < 200 || statusCode > 400 || res == null) {
      if(response.error.message != 'OK'){
        print("error" + res['message'].toString());
        throw new Exception(response.error.message);
      }
      else {
        print("succeeded");
        return new LoginResponse.fromJson(res);
      }
      //var body = json.decode(res.body);
      //print(res.toString());
      //if(res["error"]) throw new Exception(res["error_msg"]);
      //return new User.map(res["user"]);
      //return new User(username,password);
      //return new User.map(res["user"]);
      //return new Future.value(new User(username, password));
  });
  }
}
