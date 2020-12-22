
class UserModel {
  String sId;
  String email;
  String password;
  String name;
  String username;
  String sharedSecretKey;

  UserModel(
      {this.sId,
      this.email,
      this.password,
      this.name,
      this.username,
      this.sharedSecretKey});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    username = json['username'];
    sharedSecretKey = json['sharedSecretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['username'] = this.username;
    data['sharedSecretKey'] = this.sharedSecretKey;
    return data;
  }
}