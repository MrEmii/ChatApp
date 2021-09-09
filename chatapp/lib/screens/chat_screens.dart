import 'package:chatapp/widgets/chat_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{

  TextEditingController _chatController = TextEditingController();
  FocusNode _chatNode = FocusNode();
  bool isTyping = false;

  List<ChatBubble> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 14,
              child: Text("Ma", style: TextStyle(fontSize: 12),),
              backgroundColor: Colors.blue[100],
            ),
            SizedBox(height: 3,),
            Text("Maradona", style: TextStyle(color: Colors.black87, fontSize: 12),)
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => this.messages[i],
                reverse: true,
                itemCount: this.messages.length,
              ),
            ),
            Divider(height: 1,),
            Container(
              color: Colors.white,
              child: _input(),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _chatController,
                onSubmitted: _handleSubmit,
                onEditingComplete: () => _handleSubmit(_chatController.text.trim()),
                onChanged: (value){
                  setState(() {
                    this.isTyping = value.trim().isNotEmpty;
                  });
                },
                decoration: InputDecoration.collapsed(hintText: "Mensaje"),
                focusNode: _chatNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: IconTheme(
                data: IconThemeData(
                  color: Colors.blue[400]
                ),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: isTyping ? () => _handleSubmit(_chatController.text.trim()) : null,
                  icon: Icon(CupertinoIcons.paperplane_fill)
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(value){
    if(value == null || value.trim().isEmpty) return;

    this.messages.insert(0, ChatBubble(message: value, uid: '0', animationController: AnimationController(
                    duration: const Duration(milliseconds: 500),
                    vsync: this,
                  )..forward()));

    _chatNode.requestFocus();
    _chatController.clear();
    setState(() {
      this.isTyping = false;
    });
  }
}