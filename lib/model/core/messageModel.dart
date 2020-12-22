class MessageModel {
  String sId;
  String encryptedText;
  String senderId;
  String roomId;

  MessageModel({this.sId, this.encryptedText, this.senderId, this.roomId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    encryptedText = json['encryptedText'];
    senderId = json['senderId'];
    roomId = json['roomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['encryptedText'] = this.encryptedText;
    data['senderId'] = this.senderId;
    data['roomId'] = this.roomId;
    return data;
  }
}