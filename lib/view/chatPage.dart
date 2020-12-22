
import 'package:e2ee_messaging_app/model/core/chatRoomModel.dart';
import 'package:flutter/material.dart';


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

int botIndex = 0;


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

class ChatScreen extends StatefulWidget {

  String roomId;
  ChatRoomModel chatRoom;

  ChatScreen({this.roomId});
  
  
  void getRoomInfo(){
    //TODO service'i kullanarak oda bilgilerini al
    chatRoom = ChatRoomModel(id:"3", messageIdList: ["10", "12"], name: "Machine Learning Chat Roow", userIdList: ["341", "41230"] ); 
  }

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

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
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null),
          ),
        ]),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    if (text == "selam") {
      botMessages = botMessages2;
      BotMesagge.index = 0;
    }
    ChatMessage message = ChatMessage(
      isBot: false,
      text: text,
      animationController: AnimationController(
        // NEW
        duration: const Duration(milliseconds: 400), // NEW
        vsync: this, // NEW
      ), // NEW
    ); // NEW
    setState(() {
      _messages.insert(0, message);
      _isComposing = false;
    });
    _focusNode.requestFocus();
    message.animationController.forward();
    _handleBotMessage();
  }

  void _handleBotMessage() {
    /////////////////////////////
    ChatMessage botMessage = ChatMessage(
      isBot: true,
      text: botMessages[BotMesagge.index++],
      animationController: AnimationController(
        // NEW
        duration: const Duration(milliseconds: 400), // NEW
        vsync: this, // NEW
      ), // NEW
    );
    setState(() {
      _messages.insert(0, botMessage);
    });
    _focusNode.requestFocus();
    botMessage.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: kDefaultTheme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                ), // NEW
              ), // NEW
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

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController, this.isBot});
  final AnimationController animationController;
  final String text;
  bool isBot;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: isBot
          ? BotMesagge(
              message: text,
            )
          : UserMessage(message: text),
    );
  }
}
