// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytracking1/models/money.dart';
import 'package:moneytracking1/models/user.dart';
import 'package:moneytracking1/services/call_api.dart';

class ListMoneyUI extends StatefulWidget {
  User? user;

  ListMoneyUI({
    this.user,
    super.key,
  });

  @override
  State<ListMoneyUI> createState() => _ListMoneyUIState();
}

class _ListMoneyUIState extends State<ListMoneyUI> {
  bool _isLoading = true;
  String _errorMessage = '';
  List<Money> _moneyList = [];
  final formatter = NumberFormat("#,##0.00");

  @override
  void initState() {
    fetchMoneyList();
    super.initState();
  }

  Future<void> fetchMoneyList() async {
    try {
      List<Money> moneyList = await CallApi.GetAllMoneyAPI(widget.user!.userID);
      setState(() {
        _moneyList = moneyList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Error fetching data: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15,
        ),
        width: double.infinity,
        color: Colors.white,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : _moneyList.isEmpty
                    ? Center(
                        child: Text(
                          'ไม่มีข้อมูลการเงิน',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _moneyList.length,
                        itemBuilder: (context, index) {
                          final money = _moneyList[index];
                          
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  money.moneyDetail ?? "ไม่มีข้อมูล",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  money.moneyDate ?? "ไม่ระบุวันที่",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                ),
                                trailing: Text(
                                  "${formatter.format(money.moneyInOut ?? 0.0)} บาท",
                                  style: TextStyle(
                                    color: money.moneyType == 1
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                ),
                                leading: Icon(
                                  money.moneyType == 1
                                      ? Icons.arrow_circle_up_sharp
                                      : Icons.arrow_circle_down_sharp,
                                  color: money.moneyType == 1
                                      ? Colors.green
                                      : Colors.red,
                                  size:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
      ),
    );
  }
}
