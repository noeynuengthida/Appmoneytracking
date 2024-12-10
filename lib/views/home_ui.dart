import 'dart:convert';
import 'dart:typed_data';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moneytracking1/models/money.dart';
import 'package:moneytracking1/models/user.dart';
import 'package:moneytracking1/services/call_api.dart';
import 'package:moneytracking1/views/inside_views/add_income_ui.dart';
import 'package:moneytracking1/views/inside_views/add_outmoney_ui.dart';
import 'package:moneytracking1/views/inside_views/list_money_ui.dart';

class HomeUI extends StatefulWidget {
  User? user;
  HomeUI({
    this.user,
    super.key,
  });

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
 int _currentIndex = 1;
  Uint8List? _imageBytes;
  double _totalBalance = 0.0;
  double _totalExpense = 0.0;
  double _totalIncome = 0.0;
  late List<Widget> _currentSo;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.user?.userImage != null && widget.user!.userImage!.isNotEmpty) {
      _imageBytes = base64Decode(widget.user!.userImage!);
    }
    fetchMoneyList();
    _currentSo = [
      AddIncomeUI(
        user: widget.user,
      ),
      ListMoneyUI(
        user: widget.user,
      ),
      AddOutMoneyUI(
        user: widget.user,
      ),
    ];
  }

  Future<void> fetchMoneyList() async {
    try {
      List<Money> moneyList = await CallApi.GetAllMoneyAPI(widget.user!.userID);
      setState(() {
        // คำนวณยอดเงินคงเหลือ
        _totalBalance = moneyList.fold(0.0, (sum, item) {
          double amount = item.moneyInOut ??
              0.0; // กำหนดค่าเริ่มต้นหาก moneyInOut เป็น null
          return item.moneyType == 1 ? sum + amount : sum - amount;
        });

        // คำนวณยอดเงินออก
        _totalExpense = moneyList.fold(0.0, (sum, item) {
          double amount = item.moneyInOut ?? 0.0;
          return item.moneyType == 2 ? sum + amount : sum;
        });

        // คำนวณยอดเงินเข้า
        _totalIncome = moneyList.fold(0.0, (sum, item) {
          double amount = item.moneyInOut ?? 0.0;
          return item.moneyType == 1 ? sum + amount : sum;
        });

        _isLoading = false; // เปลี่ยนสถานะการโหลด
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // เปลี่ยนสถานะการโหลดในกรณีเกิดข้อผิดพลาด
      });
      print("Error fetching money list: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              CustomPaint(
                painter: CurvedPainter(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.user?.userFullName ?? "Unknown User",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.height * 0.05,
                              backgroundColor: Colors.transparent,
                              child: _imageBytes != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.memory(
                                        _imageBytes!,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                      ),
                                    )
                                  : Container(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              Color.fromARGB(255, 0, 196, 147),
                                          width: 3,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.person_outline,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: _currentSo[_currentIndex],
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.02,
              // ),
            ],
          ),
          Align(
            alignment:
                AlignmentDirectional.topCenter + AlignmentDirectional(0, 0.45),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.all(20),
                color: Color(0xFF368983),
                child: Center(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Column(
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "ยอดเงินคงเหลือ",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        NumberFormat('#,##0.00 บาท').format(_totalBalance),
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        fetchMoneyList();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.rotate_left_rounded,
                                      color: Colors.white,
                                    ),
                                    iconSize:
                                        MediaQuery.of(context).size.height *
                                            0.03,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "ยอดเงินเข้า",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                         NumberFormat('#,##0.00 บาท').format(_totalIncome),
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "ยอดเงินออก",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        NumberFormat('#,##0.00 บาท').format(_totalExpense),
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(
            icon: FontAwesomeIcons.handHoldingDollar,
            title: 'เงินเข้า',
          ),
          TabItem(
            icon: FontAwesomeIcons.houseChimney,
            title: 'หน้าหลัก',
          ),
          TabItem(
            icon: FontAwesomeIcons.moneyBillWave,
            title: 'เงินออก',
          ), //handHoldingHand
        ],
        backgroundColor: Colors.teal,
        curveSize: MediaQuery.of(context).size.width * 0.88,
        // top: -30,
        cornerRadius: 0,
        style: TabStyle.reactCircle,
        initialActiveIndex: _currentIndex,
        onTap: (value) async {
          setState(() {
            _currentIndex = value;
            fetchMoneyList();
          });
        },
      ),
    );
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}