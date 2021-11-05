import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatBubble extends StatefulWidget {

  final String message, uid;
  final AnimationController animationController;

  const ChatBubble({Key? key, required this.message, required this.uid, required this.animationController}) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    var isMine = widget.uid == authService.user!.id;
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset((isMine ? 1 : -1), 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Curves.easeInOut
      )),
      child: FadeTransition(
        opacity: widget.animationController,
        child: Container(
          child: isMine ? _mineBubble() : _anotherBubble(),
        ),
      ),
    );
  }

  _mineBubble() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 5, left: 50, right: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4d9ef2),
              Colors.blueAccent
            ]
          ),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text(this.widget.message, style: TextStyle(color: Colors.white),),
      ),
    );
  }

  _anotherBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 5, right: 50, left: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffe4e5e8),
              Color(0xffececec)
            ]
          ),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text(this.widget.message, style: TextStyle(color: Colors.black54),),
      ),
    );
  }
}