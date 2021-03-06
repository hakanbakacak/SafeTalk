/*import 'package:e2ee_messaging_app/model/core/chatRoomModel.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

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

class ChatScreen extends StatefulWidget {
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
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
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;
  int i = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.getRoomInfo();
  }

  @override
  void dispose() {
    widget.channel.sink.close();
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
    widget.channel.sink.add(text);
    _textController.clear();

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

  void addMessageToList(String text) {
    print("AddMessageToList: " + text);
    ChatMessage message = ChatMessage(
      isBot: false,
      text: text,
      animationController: AnimationController(
        // NEW
        duration: const Duration(milliseconds: 400), // NEW
        vsync: this, // NEW
      ), // NEW
    );

    _messages.insert(0, message);
    _isComposing = false;
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
                //widget.channel.sink.add(DateTime.now().second.toString());
              },
            ),
          ),
          appBar: AppBar(
              //backgroundColor: Color(0xffE63323),
              title: Text(widget.chatRoom.name)),
          body: Column(
            children: [
              Flexible(
                child: StreamBuilder(
                  stream: widget.channel.stream,
                  builder: (context, snapshot) {
                    //_handleSubmitted(snapshot.hasData ? snapshot.data : "");
                    //if (snapshot.hasData) {
                    //var data = snapshot.data;
                    //addMessageToList(data);
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Center(child: CircularProgressIndicator());
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:
                        ChatMessage message = ChatMessage(
                          isBot: false,
                          text: snapshot.data,
                          animationController: AnimationController(
                            // NEW
                            duration: const Duration(milliseconds: 400), // NEW
                            vsync: this, // NEW
                          ), // NEW
                        );
                        return ListView.builder(
                          reverse: true,
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            return _messages[index];
                          },
                        );
                    }
                  },
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
*/