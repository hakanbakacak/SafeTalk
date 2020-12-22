class ChatRoomModel{

  ChatRoomModel({this.id, this.name, this.userIdList, this.messageIdList});

  String id;
  String name;
  List<String> userIdList;
  List<String> messageIdList;

  factory ChatRoomModel.fromJson(Map<dynamic, dynamic> json) => ChatRoomModel(
        id: json["id"],
        name: json["name"],
        
    );
}