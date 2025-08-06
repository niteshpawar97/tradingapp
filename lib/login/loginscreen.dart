import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/Screen/Home.dart';
import 'package:alevet_market/api/auth_service.dart';
import 'package:alevet_market/forget/forget_password.dart';
import 'package:alevet_market/login/registration.dart';
import 'package:alevet_market/bottom/bottomScreen.dart'; // Import your splash screen if needed

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _isLoading = false;

  // Controllers for TextFields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validation and navigation logic
  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final result = await _authService.loginUser(
        _emailController.text,
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (result['success']) {
        // api me success ka check hai krta hai ye
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder:
                (context) => const MainScreen(), // Replace with your HomeScreen
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Login failed')),
        );
      }
    } else {
      // Show a snackbar if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly')),
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

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Add Form widget for validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign in',
                            style: GoogleFonts.poppins(
                              fontSize: 24.px,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff111303),
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            'Welcome back you’ve been missed',
                            style: GoogleFonts.poppins(
                              fontSize: 16.px,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff8F8F8F),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Email ID',
                    style: GoogleFonts.poppins(
                      fontSize: 14.px,
                      color: Color(0xff8F8F8F),
                    ),
                  ),
                  SizedBox(height: 0.8.h),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email ID',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 18.px,

                        color: Color(0xffB5B6B1),
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: Color(0xffF6FAFD),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.px),
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
                  SizedBox(height: 2.h),
                  Text(
                    'Password',
                    style: GoogleFonts.poppins(
                      fontSize: 14.px,
                      color: Color(0xff8F8F8F),
                    ),
                  ),
                  SizedBox(height: 0.8.h),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 18.px,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff8F8F8F),
                      ),
                      filled: true,
                      fillColor: Color(0xffF6FAFD),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.px),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                          size: 20.px,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Forget Password?',
                        style: GoogleFonts.openSans(
                          fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff111303),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          _isLoading
                              ? null
                              : _login, // Call validation and navigation
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffD2FF47),
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.px),
                        ),
                      ),
                      child:
                          _isLoading
                              ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff111303),
                                ),
                              )
                              : Text(
                                'Login',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.px,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff111303),
                                ),
                              ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey[300], thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          'Or',
                          style: GoogleFonts.poppins(
                            fontSize: 14.px,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff9D9D9D),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Color(0xffE8ECF4), thickness: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle Google login
                        },
                        child: Container(
                          height: 8.h,
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 2.w,
                            right: 2.w,
                            bottom: 2.h,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.px),
                            border: Border.all(color: Color(0xffB5B6B1)),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/Frame_1597883572-removebg-preview.png',
                              height: 6.h,
                              width: 15.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      GestureDetector(
                        onTap: () {
                          // Handle Apple login
                        },
                        child: Container(
                          height: 8.h,
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 2.w,
                            right: 2.w,
                            bottom: 2.h,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.px),
                            border: Border.all(color: Color(0xffB5B6B1)),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/Frame_1597883573-removebg-preview.png',
                              height: 6.h,
                              width: 15.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      GestureDetector(
                        onTap: () {
                          // Handle Facebook login
                        },
                        child: Container(
                          height: 8.h,
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 2.w,
                            right: 2.w,
                            bottom: 2.h,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.px),
                            border: Border.all(color: Color(0xffB5B6B1)),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/Frame_1597883574-removebg-preview-removebg-preview.png',
                              height: 6.h,
                              width: 15.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don’t have an account? ",
                        style: GoogleFonts.openSans(
                          fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: GoogleFonts.openSans(
                                  fontSize: 16.px,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xffBFE841),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
