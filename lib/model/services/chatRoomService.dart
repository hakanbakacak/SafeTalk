import 'dart:async' show Future;
import 'dart:convert';
import 'package:e2ee_messaging_app/model/core/chatRoomModel.dart';
import 'package:http/http.dart';

class ChatRoomService{
  List<ChatRoomModel> roomList = new List<ChatRoomModel>();

  static ChatRoomService _instance;

  static ChatRoomService get instance{
    if(_instance == null){
      _instance = ChatRoomService._init();
    }
    
    return _instance;  
  }

  ChatRoomService._init(){
    initClass();
  }

  Future initClass() async{
    await loadChatRooms();
  }

  Future<Response> getRooms() async {
    Response response =
        await get('http://10.0.2.2:8000/api/rooms'); //to connect localhost
    //cities = List<String>.from(json.decode(response.body));
    //String jsonString = await rootBundle.loadString(response);
    //var responseTr = json.decode(utf8.decode(response.bodyBytes));
    return response;
    //print(responseTr);
  }

  Future loadChatRooms() async {
    Response response = await getRooms();
    final jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    for (var j = 0; j < jsonResponse.length; j++) {

      ChatRoomModel tempChatRoom = new ChatRoomModel.fromJson(jsonResponse[j]);
      roomList.add(tempChatRoom);
    }
    return roomList;

    
  }
}

/*

class DistrictService extends Service{


  DistrictService._init(){
    super.name = "DistrictService";
    initClass();
  }
  Future <List<District>> getDistrictNames() async{
    final districts = await loadDistricts();
    for (var i = 0; i < districts.length; i++) {
      districtNames.add(districts[i].name);
    }
    
  }
  /*CityService() {
    initClass();
  }*/
  Future initClass() async{
    await loadDistricts();
    for (var i = 0; i < districts.length; i++) {
      districtNames.add(districts[i].name);
    }
  }


  Future<Response> getDistricts() async {
    Response response =
        await get('http://10.0.2.2:8000/districts/24'); //to connect localhost
    //cities = List<String>.from(json.decode(response.body));
    //String jsonString = await rootBundle.loadString(response);
    //var responseTr = json.decode(utf8.decode(response.bodyBytes));
    return response;
    //print(responseTr);
  }

  Future loadDistricts() async {
    Response response = await getDistricts();
    final jsonResponse = json.decode(utf8.decode(response.bodyBytes));

    for (var j = 0; j < jsonResponse.length; j++) {

      District tempDistrict = new District.fromJson(jsonResponse[j]);
      districts.add(tempDistrict);
    }
    return districts;

    
  }
}

*/