import 'dart:async';

import 'package:e2ee_messaging_app/model/core/messageModel.dart';
import 'package:e2ee_messaging_app/model/services/messageService.dart';
import 'package:flutter/material.dart';


class StreamDeneme extends StatefulWidget {
  

  @override
  _StreamDenemeState createState() => _StreamDenemeState();
}

class _StreamDenemeState extends State<StreamDeneme> {

  StreamController<List<MessageModel>> _streamController = StreamController();
  MessageService messageService;
  List<MessageModel> messages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchMessages();
  }


  @override
  void dispose(){
    _streamController.close();
    super.dispose();
  }

  Future<void> _fetchMessages()async{
    var messages = await MessageService.instance.getMessage();

    if(messages.length == 0){
      return;
    }
    _streamController.add(messages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StreamBuilder Deneme"),),
      body: Column(
        children: [
          Expanded(
            child:StreamBuilder<List<MessageModel>>(
              stream: _streamController.stream ,

              builder: (BuildContext context, AsyncSnapshot snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    return ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return ListTile(leading: CircleAvatar(), title: Text("Mesaj"),);
                  },
                ); 
                    
                }
                
              },
            ),)
        ],
      ),
    );
  }
}