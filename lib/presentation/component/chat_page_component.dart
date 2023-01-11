import 'package:chatapp/Models/messages.dart';
import 'package:chatapp/core/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget chatBubble({required Message message})=>Align(
  alignment: Alignment.centerLeft,
  child:   Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.only(left: 30,right: 30,top:30 ,bottom: 30),//لي جوه الكونتينر
    decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32)
        )

    ),
    child: Text(
      message.message,
      style: TextStyle(color: Colors.white),
    ),
  ),
);
Widget chatBubbleForFriend({required Message message})=>Align(
  alignment: Alignment.centerRight,
  child:   Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.only(left: 30,right: 30,top:30 ,bottom: 30),//لي جوه الكونتينر
    decoration: const BoxDecoration(
        color: Color(0xff006D84),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32)
        )

    ),
    child: Text(
      message.message,
      style: TextStyle(color: Colors.white),
    ),
  ),
);