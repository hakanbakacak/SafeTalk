import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:e2ee_messaging_app/model/helper/messageHelper.dart';
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
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String text = "";
  String text2 = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(),
            Text(text),
            Text(text2),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  String encrypted = MessageHelper.encryptMessage(
                      "eda", r'''q3t6w9z$C&F)J@NcRfTjWnZr4u7x!A%D''');
                  text = encrypted;
                });
                var decrypt = MessageHelper.decryptMessage(
                    text, r'''q3t6w9z$C&F)J@NcRfTjWnZr4u7x!A%D''');
                text2 = decrypt;
                //print(decript);
              },
            )
          ],
        ),
      ),
    );
  }
}
