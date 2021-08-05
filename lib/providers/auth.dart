import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "dart:async";

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  DateTime _expiryDate = DateTime.now().subtract(Duration(days: 360));
  late String _userId ="";
  late Timer _authTimer;

  bool get isAuth {
    return token != "";
  }

  String get token {
    // ignore: unnecessary_null_comparison
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != "") {
      return _token;
    }
    return "";
  }

  Future<void> _authenticate(
      String email, String password, String urlSegement) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegement?key=AIzaSyBHe-0Hrw9I2z-9r5pFYuekOMugmlALbSo");

    try {
      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));

      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData['error']["message"]);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
        
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> logout() async {
    _token = "";
    _userId = "";
    _expiryDate.subtract(Duration(days: 360));
    notifyListeners();
  }


}
