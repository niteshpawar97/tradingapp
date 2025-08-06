import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/forget/PasswordChangedScreen.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  _CreateNewPasswordScreenState createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  // Controllers for TextFields
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // State variables for password visibility
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Validation and navigation logic
  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      // If validation passes, show the PasswordChangedScreen as a bottom sheet
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),
        ),
        builder: (context) => const PasswordChangedScreen(),
      );
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

        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Text(
                  'Create new password',
                  style: GoogleFonts.poppins(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff111303),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Your new password must be unique from those previously used.',
                  style: GoogleFonts.openSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff8F8F8F),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'New Password',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffACB5BB),
                  ),
                ),
                SizedBox(height: 1.h),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Text(
                  'Confirm Password',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffACB5BB),
                  ),
                ),
                SizedBox(height: 1.h), // Adjusted for consistency
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Confirm Password',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18.sp,

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
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _resetPassword, // Call validation and navigation
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        0xffD2FF47,
                      ), // Or use Color(0xffD2FF47) to match your theme
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                    child: Text(
                      'Reset Password',
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
