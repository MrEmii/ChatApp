import 'dart:convert';
import 'dart:developer';

import 'package:chatapp/models/login_response.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier{

  Future login({email, password}) async{

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
      return true;
    }else{
      return false;
    }
  }


}