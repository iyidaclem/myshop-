import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import "dart:convert";
import "dart:async";
import 'dart:math';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  DateTime _expiryDate = DateTime.now().subtract(Duration(days: 360));
  late String _userId = "";
  late Timer _authTimer;
  int luck = 0;
  

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
      luck = await getLuckNumber();

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


  Future<int> getLuckNumber() async {
    SharedPreferences _prefs =  await SharedPreferences.getInstance();
    var myNum =  _prefs.getInt("lucky");
    return myNum!;
  }

  Future<void> lucky() async {
    SharedPreferences _prefs =  await SharedPreferences.getInstance();
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    await _prefs.setInt("lucky", randomNumber);
    luck = randomNumber;
    print(random.nextInt(100)+1);
    notifyListeners();
    
  }
}
