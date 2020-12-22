import 'dart:async' show Future;
import 'dart:convert';
import 'package:e2ee_messaging_app/model/core/userModel.dart';
import 'package:http/http.dart';

class UserService{
  List<UserModel> roomList = new List<UserModel>();

  static UserService _instance;

  static UserService get instance{
    if(_instance == null){
      _instance = UserService._init();
    }
    
    return _instance;  
  }

  UserService._init(){
    initClass();
  }

  Future initClass() async{
    
  }

  Future<Response> getUser(String username) async {
    Response response =
        await get('http://10.0.2.2:8000/api/users/login?username=${username}'); //to connect localhost
    //cities = List<String>.from(json.decode(response.body));
    //String jsonString = await rootBundle.loadString(response);
    //var responseTr = json.decode(utf8.decode(response.bodyBytes));
    return response;
    //print(responseTr);
  }

  Future login(String username ) async {
    Response response = await getUser(username);
    final jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    UserModel user = new UserModel.fromJson(jsonResponse);

    return user;
  }
}

