import 'package:e2ee_messaging_app/model/core/chatRoomModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';


List<String> botMessages = [
  "there will be no lesson this week",
  "Haftalık 100 DK paketimizden yararlanmak ister misiniz? ",
  "Haftalık 100 DK paketimizin ücreti 10 TL",
  "Haftalık 100 DK paketi satın alma işlemini onaylıyor musunuz?",
  "100 DK hattınıza tanımlanmıştır :)",
  "Görüşmek Üzere :)",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  ""
];
List<String> botMessages2 = [
  "Merhaba! ben dijital asistan TOT :) size nasıl yardımcı olabilirim?",
  "23/06/2020 -> 76.54TL\n22/07/2020 -> 78.23TL\nLütfen ödemesini yapmak istediğiniz faturanın tarihini ay/yıl şeklinde giriniz. (örn:07/20)",
  "Lütfen ödeme yapmak istediğiniz kredi kartının son 4 hanesini giriniz.",
  "23/06/2020 tarihli 76 lira 56 kuruş değerindeki faturayı ödeme işlemini onaylıyor musunuz?",
  "İşleminiz başarıyla tamamlandı. İyi günler dilerim :)",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  ""
];
//List<String> botMessages = ["Merhaba, bu hafta dijital asistan ile 3 işlem gerçekleştirdiniz. Türk Telekomdan hediye paket kazandınız.\nLütfen hediyenizi seçin\n1. İnternet\n2. Dakika\n3. SMS", "2 GB İnternet hattınıza tanımlanmıştır, iyi günler dilerim", "","", "", "", ""];
const String _name = "Hakan Bakacak";
int botIndex = 0;

class ChatScreen extends StatefulWidget {
 
  String roomId;
  String userId;
  ChatRoomModel chatRoom = ChatRoomModel(
      id: "3",
      messageIdList: ["10", "12"],
      name: "Machine Learning Chat Roow",
      userIdList: ["341", "41230"]);

  ChatScreen({this.roomId, this.userId});

  void getRoomInfo() {
    //TODO service'i kullanarak oda bilgilerini al
    chatRoom = ChatRoomModel(
        id: "3",
        messageIdList: ["10", "12"],
        name: "Machine Learning Chat Roow",
        userIdList: ["341", "41230"]);
  }

  @override
  _ChatScreenState createState() => _ChatScreenState("title");
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

    final _title;
  final List<ChatMessage> _messages;
  final TextEditingController _textController;
  final DatabaseReference _messageDatabaseReference;
  final StorageReference _photoStorageReference;
  final FocusNode _focusNode = FocusNode();
  int i = 0;
  bool _isComposing = false;

  _ChatScreenState(String title)
      : _title = title,
        _isComposing = false,
        _messages = <ChatMessage>[],
        _textController = TextEditingController(),
        _messageDatabaseReference =
            FirebaseDatabase.instance.reference().child("messages"),
        _photoStorageReference =
            FirebaseStorage.instance.ref().child("chat_photos") {
    _messageDatabaseReference.onChildAdded.listen(_onMessageAdded);
  }

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.getRoomInfo();
  }

  @override
  void dispose() {
    _textController.dispose();
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
  void _onMessageAdded(Event event) {
    final text = event.snapshot.value["text"];
    final imageUrl = event.snapshot.value["imageUrl"];

    ChatMessage message = imageUrl == null
        ? _createMessageFromText(text)
        : _createMessageFromImage(imageUrl);

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

   ChatMessage _createMessageFromText(String text) => ChatMessage(
        text: text,
        username: _name,
        animationController: AnimationController(
          duration: Duration(milliseconds: 180),
          vsync: this,
        ),
      );

  ChatMessage _createMessageFromImage(String imageUrl) => ChatMessage(
        imageUrl: imageUrl,
        username: _name,
        animationController: AnimationController(
          duration: Duration(milliseconds: 90),
          vsync: this,
        ),
      );

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Flexible(
            child: TextField(
              focusNode: _focusNode,
              controller: _textController,
              onSubmitted: _isComposing ? _handleSubmitted : null,
              decoration: InputDecoration.collapsed(hintText: 'Mesaj Yaz'),
              onChanged: (String text) {
                // NEW
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.pink,
                ),
                onPressed: () {
                  if (_isComposing) {
                    _handleSubmitted(_textController.text);
                  }
                }),
          ),
        ]),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    
    ChatMessage message = ChatMessage(
      username: "hakan",
      imageUrl: "https://avatars2.githubusercontent.com/u/22100241?s=460&u=fcc5bd24a8419cafaba4ab6c8507dd7defba9591&v=4",
      text: text,
      animationController: AnimationController(
        // NEW
        duration: const Duration(milliseconds: 400), // NEW
        vsync: this, // NEW
      ), // NEW
    ); // NEW
    _messageDatabaseReference.push().set(message.toMap());
    setState(() {
      _messages.insert(0, message);
      _isComposing = false;
    });

    _focusNode.requestFocus();
    message.animationController.forward();
  }

 


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: kDefaultTheme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: Align(
            alignment: Alignment.centerLeft,
            child: FloatingActionButton(
              onPressed: () {
                _handleSubmitted(DateTime.now().second.toString());
              },
            ),
          ),
          appBar: AppBar(
              //backgroundColor: Color(0xffE63323),
              title: Text(widget.chatRoom.name)),
          body: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length, // NEW
                ),
              ),
              Divider(height: 1.0), // NEW
              Container(
                // NEW
                decoration:
                    BoxDecoration(color: Theme.of(context).cardColor), // NEW
                child: _buildTextComposer(), //MODIFIED
              ), // NEW
            ], // NEW
          ), // NEW
        ));
  }
}

class Chatbot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.90),
        appBar: AppBar(
          title: Text("TOT Dijital Asistan"),
        ),
        body: Column(
          children: [BotMesagge(), UserMessage()],
        ),
      ),
    );
  }
}

class BotMesagge extends StatelessWidget {
  BotMesagge({this.message});
  String message;
  static int index = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(
              "assets/botlogo.png",
              height: 43,
            )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 50,
              //height: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  index < botMessages.length ? message : "",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class UserMessage extends StatelessWidget {
  UserMessage({this.message});
  String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                //height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white70),
              ),
            ),
          ),
          CircleAvatar(child: Text("H")),
        ],
      ),
    );
  }
}

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.pink,
  accentColor: Colors.pinkAccent[400],
);

class ChatMessage extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String username;
  final AnimationController animationController;

  ChatMessage({
    String text,
    String imageUrl,
    String username,
    AnimationController animationController,
  })  : text = text,
        imageUrl = imageUrl,
        username = username,
        animationController = animationController;

  Map<String, dynamic> toMap() => imageUrl == null
      ? {'text': text, 'username': username}
      : {'imageUrl': imageUrl, 'username': username};

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(child: Text(username[0])),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(username, style: Theme.of(context).textTheme.subhead),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: imageUrl == null
                          ? Text(text)
                          : Image.network(imageUrl),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
