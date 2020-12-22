import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:e2ee_messaging_app/model/helper/messageHelper.dart';
import 'package:web_socket_channel/io.dart';

import 'login.dart';

void main() {
  /* print("------------");
  String encrypted = MessageHelper.encryptMessage("Hakan", r'''q3t6w9z$C&F)J@NcRfTjWnZr4u7x!A%D''');
  print(encrypted);
  var decript = MessageHelper.decryptMessage(encrypted, r'''q3t6w9z$C&F)J@NcRfTjWnZr4u7x!A%D''');
  print(decript);*/
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage()));
}



class TestScreen extends StatefulWidget {
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         

        ],
      ),
      
    );
  }
}