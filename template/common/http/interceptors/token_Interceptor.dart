// Package imports:
import 'package:dio/dio.dart';

// Project imports:

class TokenInterceptors extends InterceptorsWrapper {
  String? _token;

  @override
  onRequest(RequestOptions options, handler) async {
    if (_token == null) {
      // var authorizationCode = await Global.box.read("token");
      var authorizationCode = "token";
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    if (_token != null) {
      options.headers["token"] = _token;
    }
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, handler) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson["token"] != null) {
        _token = responseJson["token"];
        // await Global.box.write("token", _token);
      }
    } catch (e) {
      print(e);
    }
    return super.onResponse(response, handler);
  }
}
