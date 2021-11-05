import 'package:chatapp/models/user.dart';
import 'package:chatapp/models/users_response.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsersService {
  Future<List<User>> getUsers() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/users'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      }
    );

    final usersResponse = usersResponseFromJson(response.body);

    if(response.statusCode == 200) {
      return usersResponse.users;
    } else {
      return [];
    }
  }
}