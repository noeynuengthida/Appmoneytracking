// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moneytracking1/models/money.dart';
import 'package:moneytracking1/models/user.dart';
import 'package:moneytracking1/utils/evn.dart';


class CallApi {
  static Future<List<User>> CheckLogInApi(User user) async {
    final responseData = await http.post(
      Uri.parse("${Env.baseUrl}/moneytracking/apis/check_login.php"),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (responseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาจาก JSON เพื่อใช้ในแอปฯ
      final responseDataDecode = jsonDecode(responseData.body);
      List<User> data = await responseDataDecode
          .map<User>((json) => User.fromJson(json))
          .toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้เมธอด
      return data;
    } else {
      throw Exception('Failed to .... login');
    }
  }

  static Future<List<User>> RegisterNewUserAPI(User user) async {
    final responseData = await http.post(
      Uri.parse(
          "${Env.baseUrl}/moneytracking/apis/register.php"),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (responseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาจาก JSON เพื่อใช้ในแอปฯ
      final responseDataDecode = jsonDecode(responseData.body);
      List<User> data = await responseDataDecode
          .map<User>((json) => User.fromJson(json))
          .toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้เมธอด
      return data;
    } else {
      throw Exception('Failed to .... login');
    }
  }

  static Future<List<Money>> GetAllMoneyAPI(String? userID) async {
    final responseData = await http.post(
      Uri.parse("${Env.baseUrl}/moneytracking/apis/get_all_money.php"),
      body: jsonEncode(
        {"userID": userID},
      ),
      headers: {"Content-Type": "application/json"},
    );

    if (responseData.statusCode == 200) {
      // แปลงข้อมูล JSON เป็น List<Money>
      // print(responseData.body);
      final responseDataDecode = jsonDecode(responseData.body);
      List<Money> data = responseDataDecode
          .map<Money>((json) => Money.fromJson(json))
          .toList();
      return data;
    } else {
      throw Exception('Failed to fetch money data');
    }
  }

  static Future<List<Money>> AddTharckingApi(Money money) async {
    final responseData = await http.post(
      Uri.parse("${Env.baseUrl}/moneytracking/apis/add_thracking.php"),
      body: jsonEncode(money.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (responseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาจาก JSON เพื่อใช้ในแอปฯ
      final responseDataDecode = jsonDecode(responseData.body);
      List<Money> data = await responseDataDecode
          .map<Money>((json) => Money.fromJson(json))
          .toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้เมธอด
      return data;
    } else {
      throw Exception('Failed to .... login');
    }
  }
}