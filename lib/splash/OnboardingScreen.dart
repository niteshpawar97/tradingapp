import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/bottom/bottomScreen.dart';
import 'package:alevet_market/login/loginscreen.dart';
import 'package:alevet_market/login/registration.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
      print('📦 initState called, checking login...');
    _checkLoginStatus();
  }

void _checkLoginStatus() {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    
    print('🧪 Saved token: $token');

    if (token != null && token.isNotEmpty) {
      print('✅ Token found, navigating to MainScreen...');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      print('❌ No token found');
    }
  });
}



  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/f.png',
      'title': "Let's Get Started",
      'subtitle': 'We will send an SMS with a verification code on the number',
    },
    {
      'image': 'assets/Parent-Group.png',
      'title': "Let's Get Started",
      'subtitle': 'We will send an SMS with a verification code on the number',
    },
    {
      'image': 'assets/Frame (1).png',
      'title': "Let's Get Started",
      'subtitle': 'We will send an SMS with a verification code on the number',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/2.png'), // Replace with your background image path
            fit: BoxFit.fill, // Adjust how the image fits (cover, contain, etc.)
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        onboardingData[index]['image']!,
                        height: 30.h,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingData.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            height: 8,
                            width: _currentPage == i ? 24 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == i
                                  ? const Color(0xffD2FF47)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        onboardingData[index]['title']!,
                        style: GoogleFonts.aDLaMDisplay(
                        fontSize: 24.sp,
                        color: Color(0xff111303),
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          onboardingData[index]['subtitle']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                        fontSize: 14.sp,
                        color: Color(0xff8F8F8F),
                        fontWeight: FontWeight.w700,
                      ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.h), // Note: 'bottom' instead of 'custom'
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD2FF47),
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.h,
                        vertical: 2.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xffD2FF47)),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.h,
                        vertical: 2.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
