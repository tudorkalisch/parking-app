import 'dart:convert';
import 'dart:io';
import 'package:parking_app/domain/user.dart';
import 'package:parking_app/service/preference_settings.dart';
import 'package:requests/requests.dart';

class LoginService {
  String baseUrl = 'http://192.168.0.106:8080/api/v1/user/';
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

    User user = User.fromJson(json.decode(r.content()));

    await SharedPrefs.setUserId(user.id);
    await SharedPrefs.setIsPremium(user.isPremium);
    return true;
  }

  Future<bool> registerAccount(
      String username, String password, bool isPremium) async {
    Response r = await Requests.post(baseUrl + 'register',
        body: {
          'username': username,
          'password': password,
          'premium': isPremium,
        },
        bodyEncoding: RequestBodyEncoding.JSON);

    if (r.statusCode == HttpStatus.ok) {
      return true;
    }

    return false;
  }
}
