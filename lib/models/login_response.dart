class LoginResponse {
  Result result;
  Api api;
  Error error;

  LoginResponse({this.result, this.api, this.error});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    api = json['api'] != null ? new Api.fromJson(json['api']) : null;
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    if (this.api != null) {
      data['api'] = this.api.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

class Result {
  String jwt;
  bool isNewUser;
  int defaultCompanyId;

  Result({this.jwt, this.isNewUser, this.defaultCompanyId});

  Result.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    isNewUser = json['isNewUser'];
    defaultCompanyId = json['defaultCompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    data['isNewUser'] = this.isNewUser;
    data['defaultCompanyId'] = this.defaultCompanyId;
    return data;
  }
}

class Api {
  int time;
  String uniqueId;
  Cache cache;
  String path;
  String generationTime;

  Api({this.time, this.uniqueId, this.cache, this.path, this.generationTime});

  Api.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    uniqueId = json['uniqueId'];
    cache = json['cache'] != null ? new Cache.fromJson(json['cache']) : null;
    path = json['path'];
    generationTime = json['generationTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['uniqueId'] = this.uniqueId;
    if (this.cache != null) {
      data['cache'] = this.cache.toJson();
    }
    data['path'] = this.path;
    data['generationTime'] = this.generationTime;
    return data;
  }
}

class Cache {
  bool cached;
  Null ttl;
  Null expires;

  Cache({this.cached, this.ttl, this.expires});

  Cache.fromJson(Map<String, dynamic> json) {
    cached = json['cached'];
    ttl = json['ttl'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cached'] = this.cached;
    data['ttl'] = this.ttl;
    data['expires'] = this.expires;
    return data;
  }
}

class Error {
  String message;
  int code;

  Error({this.message, this.code});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}