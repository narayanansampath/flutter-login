
class User {
  String jwt;
  //String _username;
  //String _password;

  User(this.jwt);
  //User(this._username, this._password);

  User.map(dynamic obj) {
    this.jwt = obj['jwt'];
    //this._username = obj['username'];
    //this._password = obj['password'];
  }

  String get _jwt => jwt;
  //String get username => _username;
  //String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["jwt"] = jwt;
    //map["username"] = _username;
    //map["password"] = _password;
    return map;
  }
}