import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/forget/OTPVerificationScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Controller for the email TextField
  final _emailController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Validation and navigation logic
  void _verifyEmail() {
    if (_formKey.currentState!.validate()) {
      // If validation passes, navigate to OTPVerificationScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OTPVerificationScreen()),
      );
    } else {
      // Show a snackbar if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email')),
      );
    }
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
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Form(
            key: _formKey, // Add Form widget for validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                Text(
                  'Forgot Password?',
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff111303),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Don’t worry! It occurs. Please enter the email address linked with your account.',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff8F8F8F),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Email ID',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffACB5BB),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email ID',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18.sp,

                      color: Color(0xffB5B6B1),
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    fillColor: Color(0xffF6FAFD),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),

                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 3.h),
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
                        onTap: () {
                          // Logic to resend OTP (implement as needed)
                        },
                        child: Text(
                          "Resend OTP in 58s",
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
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _verifyEmail, // Call validation and navigation
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF1FFC6),
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                    child: Text(
                      'Verify Number',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff111303),
                      ),
                    ),
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
