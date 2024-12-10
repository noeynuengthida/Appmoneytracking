import 'package:flutter/material.dart';
import 'package:moneytracking1/models/user.dart';
import 'package:moneytracking1/services/call_api.dart';
import 'package:moneytracking1/views/home_ui.dart';
import 'package:moneytracking1/views/start_screen_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  bool _obscureText = true;
  TextEditingController _usernameController = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");

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
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          'เข้าใช้งาน Money Tracking',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.025,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: MediaQuery.of(context).size.height * 0.04,
          ),
          onPressed: () {
            // กลับไปหน้าก่อนหน้า
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StartUI(),
              ),
            );
          },
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Container(
          height: double.infinity, // ยึดพื้นที่แนวตั้งทั้งหมด
          width: double.infinity, // ยึดพื้นที่แนวนอนทั้งหมด
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  ClipRRect(
                    child: Image.asset(
                      'assets/images/money.png',
                      width: MediaQuery.of(context).size.height * 0.25,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.045,
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'ชื่อผู้ใช้',
                      hintText: "USERNAME",
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
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'รหัสผ่าน',
                      hintText: "PASSWORD",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.teal,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
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
                  ElevatedButton(
                    onPressed: () {
                      if (_usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        showDialogMassage(context, 'แจ้งเตือน',
                            'กรุณาป้อนข้อมูลให้ครบทุกช่อง');
                      } else {
                        User user = User(
                          userName: _usernameController.text,
                          userPassword: _passwordController.text,
                        );
                        CallApi.CheckLogInApi(user).then(
                          (value) => {
                            if (value[0].message == "1")
                              {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeUI(
                                      user: value[0],
                                    ),
                                  ),
                                ),
                              }
                            else
                              {
                                showDialogMassage(context, 'แจ้งเตือน',
                                    "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง"),
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
                      'เข้าใช้งาน',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height *
                            0.02, // ขนาดฟอนต์
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
