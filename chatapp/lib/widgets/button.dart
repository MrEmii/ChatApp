import 'package:flutter/material.dart';


class Button extends StatelessWidget {

  final String text;
  final Function() onTap;

  const Button({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        shadowColor: MaterialStateProperty.all(Colors.blue),
        shape: MaterialStateProperty.all(StadiumBorder())
      ),
      onPressed: this.onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(this.text, style: TextStyle(color: Colors.white, fontSize: 17),),
        ),
      ),
    );
  }
}