import 'dart:ffi';

import 'package:e2ee_messaging_app/model/services/authentication.dart';
import 'package:e2ee_messaging_app/model/services/messageService.dart';
import 'package:e2ee_messaging_app/view/chatPage2.dart';
import 'package:e2ee_messaging_app/view/rootPage.dart';
import 'package:e2ee_messaging_app/view/streamDeneme.dart';
import 'package:flutter/material.dart';
import 'package:e2ee_messaging_app/model/helper/messageHelper.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:web_socket_channel/io.dart';
import 'package:e2ee_messaging_app/provider/messageState.dart';

import 'login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RootPage(auth: Auth(),)));
    
    //home: ChatScreen(
      //roomId: "5fe34bc65ee89b2108769236",
      //userId: "5fe1d63ca0d4fbd2909e3057",)));
}



class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Screen"),),
      body: Center(
        child: Column(children: [
          
          IconButton(icon: Icon(Icons.add),
          onPressed: () {
            
          },
          )
        ],),
      ),
      
    );
  }
}