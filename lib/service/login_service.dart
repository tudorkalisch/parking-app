import 'dart:io';
import 'package:parking_app/service/preference_settings.dart';
import 'package:requests/requests.dart';

class LoginService {
  String baseUrl = 'http://192.168.0.101:8080/api/v1/user/';
  LoginService();

  Future<bool> login(String username, String password) async {
    Response r = await Requests.post(baseUrl + 'login',
        body: {
          'username': username,
          'password': password,
        },
        bodyEncoding: RequestBodyEncoding.JSON);

    if (!r.success) {
      throw new Exception("Unauthorized");
    }

    await SharedPrefs.setUserId(r.content());
    return true;
  }

  Future<bool> registerAccount(String username, String password) async {
    Response r = await Requests.post(baseUrl + 'register',
        body: {
          'username': username,
          'password': password,
        },
        bodyEncoding: RequestBodyEncoding.JSON);

    if (r.statusCode == HttpStatus.ok) {
      return true;
    }

    return false;
  }
}
