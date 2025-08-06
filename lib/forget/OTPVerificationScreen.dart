// OTP Verification Screen (Using Device Keyboard)
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/forget/CreateNewPasswordScreen.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  int timerSeconds = 58;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();

    // Add listeners to each controller to handle auto-navigation
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1) {
          if (i < controllers.length - 1) {
            FocusScope.of(context).requestFocus(focusNodes[i + 1]);
          } else {
            // All digits entered, navigate to the next screen
            if (controllers.every(
              (controller) => controller.text.length == 1,
            )) {
              Future.delayed(const Duration(milliseconds: 300), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateNewPasswordScreen(),
                  ),
                );
              });
            }
          }
        }
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds > 0) {
        setState(() {
          timerSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/backround.png',
            ), // Change to your image path
            fit: BoxFit.fill, // Ensures the image covers the entire screen
          ),
        ),

        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OTP Verification',
                style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff111303),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Enter the verification code we just sent on your email address.',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8F8F8F),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 15.w,
                    height: 10.h,
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '', // Hide the counter
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        if (value.isEmpty && index > 0) {
                          FocusScope.of(
                            context,
                          ).requestFocus(focusNodes[index - 1]);
                        }
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: 2.h),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Didn’t receive OTP? ",
                      style: GoogleFonts.openSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff8F8F8F),
                      ),
                    ),
                    GestureDetector(
                      onTap:
                          timerSeconds == 0
                              ? () {
                                setState(() {
                                  timerSeconds = 58;
                                  _startTimer();
                                });
                              }
                              : null,
                      child: Text(
                        "Resend OTP in ${timerSeconds}s",
                        style: GoogleFonts.openSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff8F8F8F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  
                  onPressed:
                      controllers.every(
                            (controller) => controller.text.length == 1,
                          )
                          ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const CreateNewPasswordScreen(),
                              ),
                            );
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF1FFC6),
                      disabledBackgroundColor: const Color(0xffF1FFC6),
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Verify Number',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff111303),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
