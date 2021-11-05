import 'package:chatapp/models/messages_response.dart';
import 'package:chatapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class ChatService extends ChangeNotifier{

  User? user;

  Future<List<Message>> getMessages(String chatId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/messages/$chatId'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      }
    );

    final usersResponse = messagesResponseFromJson(response.body);

    if(response.statusCode == 200) {
      return usersResponse.messages;
    } else {
      return [];
    }
  }

}