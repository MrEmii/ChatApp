import 'package:chatapp/screens/chat_screens.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:chatapp/screens/users_screens.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'chat':         (_) => ChatScreen(),
  'login':        (_) => LoginScreen(),
  'usuarios':     (_) => UsersScreen(),
  'splash':       (_) => SplashScreen(),
  'register':     (_) => RegisterScreen(),
};