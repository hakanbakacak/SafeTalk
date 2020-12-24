import 'package:e2ee_messaging_app/model/core/messageModel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class MessageService{
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  static MessageService _instance;

   static MessageService get instance{
    if(_instance == null){
      _instance = MessageService._init();
    }
    
    return _instance;  
  }
  MessageService._init(){

  }
   
  Future<List<MessageModel>> getMessage(){
    
    //List<MessageModel> list = [MessageModel(encryptedText: "asdsa", roomId: "2", sId: "2", senderId: "2"), MessageModel(encryptedText: "mesaj2", roomId: "2", sId: "2", senderId: "2")]

    //Future.delayed(Duration(seconds: 2));
    //return list;
    
  }
  //state menagement ile buradan dinle diğer tarafta consume


}



/*class CatPhotoApi {
  String endpoint = "api.thecatapi.com";
  Future<Either<Exception, String>> getRandomCatPhoto() async {
    try {
      final queryParameters = {
        "api_key": "YOUR_API_HERE",
      };
      final uri = Uri.https(endpoint, "/v1/images/search", queryParameters);
      final response = await http.get(uri);
      return Right(response.body);
    } catch (e) {
      return (Left(e));
    }
  }
}*/