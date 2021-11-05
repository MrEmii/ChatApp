import 'package:chatapp/screens/users_screens.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/sockets_service.dart';
import 'package:chatapp/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _checkAuth(context),
        builder: (context, snapshot) {
          return SizedBox(
            child: Center(
              child: Logo(title: "DOTMSN"),
            ),
          );
        }
      ),
    );
  }

  // future that check for auth credentials
  Future _checkAuth(context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final isAuth = await authService.isLoggedIn();

    if(isAuth){
      socketService.connect();
      print("EY");
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => UsersScreen(),
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        }
      ));
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}