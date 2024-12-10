import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneytracking1/views/start_screen_ui.dart';

class SplashscreenUI extends StatefulWidget {
  const SplashscreenUI({super.key});

  @override
  State<SplashscreenUI> createState() => _SplashscreenUIState();
}

class _SplashscreenUIState extends State<SplashscreenUI> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StartUI(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF82B4A9), // ตั้งค่าสีพื้นหลัง
      body: Stack(
        children: [
          // ส่วนข้อความตรงกลาง
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Money Tracking',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'รายรับรายจ่ายของฉัน',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ส่วนข้อความด้านล่าง
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Text(
              'Created by 6419410039\nDTI-SAU',
              textAlign: TextAlign.center,
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                  color: const Color.fromARGB(255, 224, 248, 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
