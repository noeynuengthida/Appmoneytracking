import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moneytracking1/models/money.dart';
import 'package:moneytracking1/models/user.dart';
import 'package:moneytracking1/services/call_api.dart';

class AddIncomeUI extends StatefulWidget {
   User? user;
  AddIncomeUI({
    this.user,
    super.key,
  });

  @override
  State<AddIncomeUI> createState() => _AddIncomeUIState();
}

class _AddIncomeUIState extends State<AddIncomeUI> {
  TextEditingController _moneyDetailController =
      TextEditingController(text: "");
  TextEditingController _moneyInOutController = TextEditingController(text: "");
  TextEditingController _moneyDateController = TextEditingController(text: "");
  TextEditingController _moneyTimeController = TextEditingController(text: "");

  DateTime initDate = DateTime(1900);
  DateTime lastDate = DateTime(2100);
  DateTime defaultDate = DateTime.now();
  TimeOfDay defaultTime = TimeOfDay.now();

  Future displayCalendar(BuildContext context) async {
    return await showDatePicker(
      context: context,
      firstDate: initDate,
      lastDate: lastDate,
      initialDate: defaultDate,
    );
  }

  Future<TimeOfDay?> displayTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: defaultTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  Future<void> showDialogMassage(context, titleText, msg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            titleText,
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'เพิ่มรายการเงินเข้า',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                TextField(
                  controller: _moneyDetailController,
                  decoration: InputDecoration(
                    labelText: 'รายการเงินเข้า',
                    hintText: "DETAILS",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                TextField(
                  controller: _moneyInOutController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'จํานวนเงิน',
                    hintText: "0.00",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                TextField(
                  controller: _moneyDateController,
                  decoration: InputDecoration(
                    labelText: 'วันที่เงินเข้า',
                    hintText: "YYYY-MM-DD",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_month,
                        color: Colors.teal,
                      ),
                      onPressed: () {
                        displayCalendar(context).then((value) {
                          setState(() {
                            if (value != null) {
                              _moneyDateController.text =
                                  value.toString().substring(0, 10);
                            }
                          });
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
           
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_moneyDetailController.text.isEmpty) {
                      showDialogMassage(
                        context,
                        'แจ้งเตือน',
                        'กําหนดรายการเงินเข้า',
                      );
                    } else if (_moneyInOutController.text.isEmpty) {
                      showDialogMassage(
                        context,
                        'แจ้งเตือน',
                        'กําหนดจํานวนเงินเข้า',
                      );
                    } else if (_moneyDateController.text.isEmpty) {
                      showDialogMassage(
                        context,
                        'แจ้งเตือน',
                        'กําหนดวันที่เงินเข้า',
                      );
                    } else {
                      Money money = Money(
                        moneyDetail: _moneyDetailController.text,
                        moneyInOut: double.parse(_moneyInOutController.text),
                        moneyDate: _moneyTimeController.text == ''
                            ? _moneyDateController.text +
                                DateTime.now().toString().substring(10, 19)
                            : _moneyDateController.text +
                                ' ' +
                                _moneyTimeController.text,
                        moneyType: 1,
                        userID: widget.user!.userID,
                      );
                      CallApi.AddTharckingApi(money).then(
                        (value) => {
                          if (value[0].message == "1")
                            {
                              _moneyDetailController =
                                  TextEditingController(text: ''),
                              _moneyInOutController =
                                  TextEditingController(text: ''),
                              _moneyDateController =
                                  TextEditingController(text: ''),
                              _moneyTimeController =
                                  TextEditingController(text: ''),
                              showDialogMassage(context, 'แจ้งเตือน',
                                  "บันทึกข้อมูลเรียบร้อย"),
                            }
                          else
                            {
                              showDialogMassage(context, 'แจ้งเตือน',
                                  "ไม่สามารถบันทึกข้อมูลได้"),
                            }
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 1, 108, 89),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.80,
                      MediaQuery.of(context).size.height * 0.060,
                    ),
                  ),
                  child: Text(
                    'บันทึก',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height *
                          0.02, // ขนาดฟอนต์
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}