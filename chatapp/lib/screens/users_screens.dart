import 'package:chatapp/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsersScreen extends StatefulWidget {

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    User(online: false, email: "email", nombre: "Tylor", id: "1"),
    User(online: true, email: "email", nombre: "Maradona", id: "2"),
    User(online: true, email: "email", nombre: "Shakira", id: "3"),
    User(online: false, email: "email", nombre: "Madona", id: "4")
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emir UwU", style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.chevron_back, color: Colors.black87,)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(CupertinoIcons.check_mark_circled, color: Colors.blue[400],),
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
      itemBuilder: (_, i) => _userTile(this.usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: this.usuarios.length,
    );
  }

  ListTile _userTile(User user) {
    return ListTile(
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
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}