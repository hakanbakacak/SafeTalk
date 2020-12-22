import 'package:e2ee_messaging_app/main.dart';
import 'package:e2ee_messaging_app/model/core/chatRoomModel.dart';
import 'package:e2ee_messaging_app/view/chatPage.dart';
import 'package:flutter/material.dart';


List<ChatRoomModel> roomList = [
  ChatRoomModel(id:"1", messageIdList: ["10", "11"], name: "Data Security Chat Room", userIdList: ["30", "40"] ),
  ChatRoomModel(id:"2", messageIdList: ["11", "12"], name: "Flutter Chat Room", userIdList: ["30", "40"] ),
  ChatRoomModel(id:"3", messageIdList: ["10", "12"], name: "Machine Learning Chat Roow", userIdList: ["341", "41230"] ),
];

String lastMessage = "Last Message From Web Socket";

List<String> nameList = [
  "Semih Şentürk",
  "Hakan Bakacak",
  "Cenkay Başaran",
  "Enes Dindaş",
  "Kamil Dindaş",
  "Esra Yolaçan",
  "Zeynep Yılmaz",
  "Mehmet Çelik"
];
List<String> messageList = [
  "Thx",
  ":)",
  "Çok teşekkürler",
  "okay, I will call you",
  "Görüşürüz",
  "Teşekkürler",
  "çok güzel olmuş",
  "Mükemmel!"
];

class ChatsPage extends StatelessWidget {

  String userId;

  ChatsPage({this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Chats",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Recent",
              style: Theme.of(context).textTheme.headline6,
              textScaleFactor: 1.2,
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: roomList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CustomListTile(
                    name: roomList[index].name,
                    lastMessage: lastMessage,
                    time: "11:" + (index * 5 + 10).toString(),
                    roomId: roomList[index].id,
                  ),
                  Divider()
                ],
              );
            },
          ))
        ],
      ),
    ));
  }
}

class CustomListTile extends StatelessWidget {
  String name;
  String lastMessage;
  String time;
  String roomId;

  CustomListTile({this.name, this.lastMessage, this.time, this.roomId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen(roomId: roomId,)));
      },
          child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Text(name[0],
                style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white70), 
                textScaleFactor: 1.3,),
                maxRadius: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TODO make responsive
                  Text(
                    name,
                    style: Theme.of(context).textTheme.subtitle2,
                    textScaleFactor: 1.2,
                  ),
                  Text(
                    lastMessage,
                    style: Theme.of(context).textTheme.bodyText2,
                    textScaleFactor: 1.2,
                  )
                ],
              ),
            ),
            Spacer(),
            Text(time)
          ],
        ),
      ),
    );
  }
}
