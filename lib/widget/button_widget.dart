import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const Button({ Key? key, required this.text, required this.onClicked }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: const StadiumBorder(),
      ),
      child: FittedBox(
        child: Text(text,
        style: const TextStyle(fontSize: 20, color: Colors.white),
        ), 
      ),
      onPressed: onClicked,
    );
  }
}