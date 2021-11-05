import 'dart:convert';

import 'package:chatapp/models/login_response.dart';
import 'package:chatapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier{

  User? user;
  bool _isLoading = false;
  final _storage = FlutterSecureStorage();

  // get static token
  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    String? token = await _storage.read(key: 'token');

    return token!;
  }

  // static remove token
  static Future<void> removeToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login({email, password}) async{
    _isLoading = true;
    final payload = {
      'email': email,
      'password': password
    };

    var response = await http.post(Uri.parse("http://10.0.2.2:3000/auth/login"),
      body: jsonEncode(payload),
      headers: {
        'content-Type': 'application/json'
      }
    );
    if(response.statusCode == 200){
      final success = LoginResponse.fromRawJson(response.body);
      this.user = success.user;
      await this.saveToken(success.token);
      _isLoading = false;
      return true;
    }else{
      _isLoading = false;
      return false;
    }
  }

  //Register
  Future<String> register({username, email, password}) async{

    _isLoading = true;
    final payload = {
      "nombre": username,
      "email": email,
      "password": password
    };

    var response = await http.post(Uri.parse("http://10.0.2.2:3000/auth/new"),
      body: jsonEncode(payload),
      headers: {
        'content-Type': 'application/json'
      }
    );
    _isLoading = false;
    if(response.statusCode == 200){
      return '';
    }else{
      return json.decode(response.body)['msg'];
    }
  }

  //Logout
  Future<void> logout() async{

    await this.deleteToken();
  }

  //is logged in
  Future<bool> isLoggedIn() async{
    final token = await this._storage.read(key: 'token');
    print(token);
    if(token != null){
      var response = await http.post(Uri.parse("http://10.0.2.2:3000/auth/renew"),
        headers: {
          'content-Type': 'application/json',
          'x-token': token
        }
      );

      if(response.statusCode == 200){
        final success = LoginResponse.fromRawJson(response.body);
        this.user = success.user;
        await this.saveToken(success.token);
        _isLoading = false;
        return true;
      }else{
        _isLoading = false;
        this.deleteToken();
        return false;
      }
    }else{
      return false;
    }
  }


  //Save token
  Future<void> saveToken(String token) async{
    await _storage.write(key: 'token', value: token);
    return;
  }

  //Delete token
  Future<void> deleteToken() async{
    await _storage.delete(key: 'token');
    return;
  }

}