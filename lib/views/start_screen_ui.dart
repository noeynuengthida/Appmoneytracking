// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneytracking1/views/login_ui.dart';
import 'package:moneytracking1/views/register_ui.dart';

class StartUI extends StatefulWidget {
   StartUI({super.key});

  @override
  State<StartUI> createState() => _StartUIState();
}

class _StartUIState extends State<StartUI> {
  final TextEditingController _registrationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ภาพพื้นหลัง
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'), // ชื่อไฟล์ภาพพื้นหลัง
                fit: BoxFit.scaleDown, // ครอบคลุมเต็มหน้าจอ
                alignment: Alignment.topCenter, // จัดตำแหน่งภาพตรงกลาง
              ),
            ),
          ),
          // องค์ประกอบอื่นๆ (เช่น ภาพประกอบ, ข้อความ, ปุ่ม)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer ดันองค์ประกอบต่างๆ
               Spacer(flex: 2),

              // ภาพประกอบ
              Image.asset(
                'assets/images/money.png', // ชื่อไฟล์ภาพประกอบ
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.scaleDown,
                alignment: Alignment(0.21, 1),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              // ข้อความด้านบน
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'บันทึก\nรายรับรายจ่าย',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 20, 129, 106),
                    ),
                  ),
                ),
              ),

              // ปุ่มเริ่มใช้งาน
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => LoginUI()));
                    // Navigation ไปหน้าอื่น
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromARGB(255, 1, 108, 89),
                    elevation: 10.0,
                    shadowColor: Color(0xFF82B4A9),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.9,
                        MediaQuery.of(context).size.height * 0.06),
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:  EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  child: Text(
                    'เริ่มใช้งานแอปพลิเคชัน',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold,
                        color:  Color.fromARGB(255, 255, 255, 255),

                      ),
                    ),
                  ),
                ),
              ),

              // Spacer สำหรับดันข้อความไปล่างสุด
              
              // ข้อความ "ยังไม่ได้ลงทะเบียน?" และช่องกรอกข้อมูล "ลงทะเบียน"
              Padding(
                padding:  EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ยังไม่ได้ลงทะเบียน ?',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.018,
                          color:  Color.fromARGB(179, 0, 0, 0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.001),
                    // TextField สำหรับการลงทะเบียน
                   TextButton(onPressed: () {
                     Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => RegisterUI()));
                   }
                   , child: Text(
                    'ลงทะเบียน',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        fontWeight: FontWeight.bold,
                        color:  Color(0xFF82B4A9),
                      ),
                    )
                   )),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.001,),
            ],
          ),
        ],
      ),
    );
  }
}
