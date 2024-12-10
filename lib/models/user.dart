// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this

class User {
  String? message;
  String? userID;
  String? userFullName;
  String? userName;
  String? userPassword;
  String? userBirthDate;
  String? userImage;

  User({
    this.message,
    this.userID,
    this.userFullName,
    this.userName,
    this.userPassword,
    this.userBirthDate,
    this.userImage,
  });

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userID = json['userID'];
    userFullName = json['userFullName'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userBirthDate = json['userBirthDate'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userID'] = this.userID;
    data['userFullName'] = this.userFullName;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userBirthDate'] = this.userBirthDate;
    data['userImage'] = this.userImage;
    return data;
  }
}