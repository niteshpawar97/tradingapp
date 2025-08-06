import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/login/loginscreen.dart';
import 'package:alevet_market/api/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers for each TextField
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _referralController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final authService = AuthService();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // State variables for password visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Dispose controllers to avoid memory leaks
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _referralController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Validation and navigation logic
  void _register() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final result = await authService.registerUser(
        name: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        mobile: _mobileController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirmation: _confirmPasswordController.text.trim(),
      );


      Navigator.of(context).pop(); // Remove loading dialog
      print("Registration result: $result");

      if (result['success'] == true) {
        print("Navigating to LoginScreen...");
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        print("Registration failed: ${result['message']}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Registration failed')),
        );
      }
    } else {
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

        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign Up',
                  style: GoogleFonts.poppins(
                    fontSize: 24.px,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff111303),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Have a day! Just a few quick things to get started',
                  style: GoogleFonts.openSans(
                    fontSize: 16.px,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff8F8F8F),
                  ),
                ),
                SizedBox(height: 2.h),

                // Full Name Field
                Text(
                  'Full Name',
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    color: Color(0xff8F8F8F),
                  ),
                ),
                SizedBox(height: 0.5.h),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Name',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18.px,
                      color: Color(0xffB5B6B1),
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    fillColor: Color(0xffF6FAFD),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 1.h),

                // Email ID Field
                Text(
                  'Email ID',
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    color: Color(0xff8F8F8F),
                  ),
                ),
                SizedBox(height: 0.5.h),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email ID',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18.px,

                      color: Color(0xffB5B6B1),
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    fillColor: Color(0xffF6FAFD),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                SizedBox(height: 1.h),

                // Mobile Number Field
                Text(
                  'Mobile Number',
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    color: Color(0xff8F8F8F),
                  ),
                ),
                SizedBox(height: 0.5.h),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Number',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18.px,

                      color: Color(0xffB5B6B1),
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    fillColor: Color(0xffF6FAFD),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 1.h),

                // Referral Code Field (Optional)
                Text(
                  'Referral Code',
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    color: Color(0xff8F8F8F),
                  ),
                ),
                SizedBox(height: 0.5.h),
                TextFormField(
                  controller: _referralController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Referral Code',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18.px,

                      color: Color(0xffB5B6B1),
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    fillColor: Color(0xffF6FAFD),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 1.h),

                // Password Field
                Text(
                  'Password',
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    color: Color(0xff8F8F8F),
                  ),
                ),
                SizedBox(height: 0.5.h),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18.px,

                      color: Color(0xffB5B6B1),
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    fillColor: Color(0xffF6FAFD),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
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
                SizedBox(height: 1.h),

                // Confirm Password Field
                Text(
                  'Confirm Password',
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    color: Color(0xff8F8F8F),
                  ),
                ),
                SizedBox(height: 0.5.h),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18.px,

                      color: Color(0xffB5B6B1),
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    fillColor: Color(0xffF6FAFD),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.px),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 3.h),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD2FF47),
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.px),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff111303),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),

                // Already have an account? Login
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "already have an account ?",
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
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
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
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
