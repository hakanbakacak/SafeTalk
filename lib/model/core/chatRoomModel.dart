class ChatRoomModel {
  List<String> userIdList;
  List<String> messageIdList;
  String id;
  String name;

  ChatRoomModel({this.userIdList, this.messageIdList, this.id, this.name});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    userIdList = json['userIds'].cast<String>();
    messageIdList = json['messageIds'].cast<String>();
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userIds'] = this.userIdList;
    data['messageIds'] = this.messageIdList;
    data['_id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}