import 'package:chatapp/routes/routes.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/sockets_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<SocketService>(create: (_) => SocketService()),
        ChangeNotifierProvider<ChatService>(create: (_) => ChatService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DotMsn',
        initialRoute: 'splash',
        routes: appRoutes,
      ),
    );
  }
}
