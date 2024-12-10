// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this

class Money {
  String? message;
  String? moneyID;
  String? userID;
  String? moneyDetail;
  String? moneyDate;
  double? moneyInOut;
  int? moneyType;

  Money({
    this.message,
    this.moneyID,
    this.userID,
    this.moneyDetail,
    this.moneyDate,
    this.moneyInOut,
    this.moneyType,
  });

  Money.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    moneyID = json['moneyID'];
    userID = json['userID'];
    moneyDetail = json['moneyDetail'];
    moneyDate = json['moneyDate'];
    moneyInOut = json['moneyInOut'] != null
        ? double.tryParse(json['moneyInOut'].toString())
        : null;
    moneyType = json['moneyType'] != null
        ? int.tryParse(json['moneyType'].toString())
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['moneyID'] = this.moneyID;
    data['userID'] = this.userID;
    data['moneyDetail'] = this.moneyDetail;
    data['moneyDate'] = this.moneyDate;
    data['moneyInOut'] = this.moneyInOut;
    data['moneyType'] = this.moneyType;
    return data;
  }
}