
import 'package:flutter/material.dart';

showAlert(BuildContext context, title, subtitle){
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        MaterialButton(
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context),
          child: Text("Ok :c"),
        )
      ],
    )
  );
}