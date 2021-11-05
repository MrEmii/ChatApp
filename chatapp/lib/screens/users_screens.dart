import 'package:chatapp/models/user.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/sockets_service.dart';
import 'package:chatapp/services/users_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsersScreen extends StatefulWidget {

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<User> users = [];

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(authService.user!.nombre, style: TextStyle(color: Colors.black87),),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () async{
            await AuthService.removeToken();
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, "login");
          }, icon: Icon(Icons.exit_to_app, color: Colors.black87,),),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online ? Icon(CupertinoIcons.check_mark_circled, color: Colors.blue[400],) : Icon(CupertinoIcons.circle, color: Colors.red,),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blue[400],),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _contactList(),
      )
    );
  }

  ListView _contactList() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _userTile(this.users[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: this.users.length,
    );
  }

  ListTile _userTile(User user) {
    return ListTile(
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.user = user;
        Navigator.pushNamed(context, "chat");
      },
      title: Text(user.nombre),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green[300] : Colors.red,
          shape: BoxShape.circle
        ),
      ),
    );
  }

  _loadUsers() async{

    final usersService = UsersService();

    users = await usersService.getUsers();

    setState(() {});

    _refreshController.refreshCompleted();
  }
}