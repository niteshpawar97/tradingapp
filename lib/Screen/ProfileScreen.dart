import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/profile/BalanceScreen.dart';
import 'package:alevet_market/profile/BankDetailsScreen.dart';
import 'package:alevet_market/profile/RateUsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alevet_market/login/loginscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showSupportDialog() async {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Help & Support'),
            content: Text('Call our support: 03369029710'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  const phone = 'tel:03369029710';
                  if (await canLaunchUrl(Uri.parse(phone))) {
                    await launchUrl(Uri.parse(phone));
                  }
                },
                child: Text('Call'),
              ),
            ],
          ),
    );
  }

  int selectedIndex = -1;
  bool isDarkMode = false;

  String walletBalance = '';
  String name = '';
  String mobileNumber = '';

  @override
  void initState() {
    super.initState();
    print("⚙️ initState called"); // 👈 Add this
    _loadWalletBalance();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _loadWalletBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      walletBalance = prefs.getString('walletBalance') ?? '';
      name = prefs.getString('userName') ?? '';
      mobileNumber = prefs.getString('userMobile') ?? '';
    });
  }

  void toggleTheme(bool value) {
    // Add logic for theme change
    setState(() {
      isDarkMode = value;
    });
  }

  void onTap(int index, Widget screen) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    ).then((_) {
      setState(() {
        selectedIndex = -1;
      });
    });
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.h, right: 8.w),
                child: Container(
                  color: Colors.white,

                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            'Profile',
                            style: GoogleFonts.poppins(
                              color: Color(0xff111303),
                              fontSize: 18.px,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),

                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 30.sp,
                          backgroundColor: Color(0xffEAFFAA),
                          backgroundImage: AssetImage('assets/profile.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 24.px,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              // ignore: unnecessary_string_interpolations
                              '$name',
                              style: GoogleFonts.poppins(
                                color: Color(0xff111303),
                                fontSize: 18.px,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.verified,
                              color: Color(0xff2196F3),
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          'Mob: ${mobileNumber}',
                          style: GoogleFonts.poppins(
                            color: Color(0xff111303),
                            fontSize: 14.px,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.w),
                child: Container(
                  color: Colors.transparent,
                  height: 6.h,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account Information",
                        style: GoogleFonts.poppins(
                          color: Color(0xff111303),
                          fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        "Find all your profile related information",
                        style: GoogleFonts.poppins(
                          color: Color(0xff8F8F8F),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              buildListTile(
                0,
                icon: Icons.account_balance_wallet,
                title: 'Balance : \$${walletBalance}',
                subtitle: 'Check your account balance here',
                screen: BalanceScreen(),
              ),
              SizedBox(height: 1.h),
              buildListTile(
                1,
                icon: Icons.account_balance,
                title: 'Bank Details',
                subtitle: 'Manage your KYC, bank details',
                screen: BankDetailsScreen(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.w, top: 1.h),
                child: Container(
                  color: Colors.transparent,
                  height: 6.h,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "App Settings",
                        style: GoogleFonts.poppins(
                          color: Color(0xff111303),
                          fontSize: 14.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Get the best out of your Alevet",
                        style: GoogleFonts.openSans(
                          color: Color(0xff8F8F8F),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              buildListTile(
                2,
                icon: Icons.settings,
                title: 'Settings',
                subtitle: 'Security or display settings',
                screen: RateUsScreen(),
              ),
              SizedBox(height: 1),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Image.asset("assets/sss.png"),
                  title: Text(
                    'Appearance',
                    style: GoogleFonts.poppins(
                      color: Color(0xff111303),
                      fontSize: 16.px,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    'Switch between Themes',
                    style: GoogleFonts.openSans(
                      color: Color(0xff8F8F8F),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        isDarkMode = !isDarkMode; // Toggle the theme mode
                      });
                      toggleTheme(isDarkMode);
                    },
                    child: Container(
                      width: 15.w, // Set width for switch effect
                      height: 4.h, // Set height
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color:
                            isDarkMode
                                ? Colors.white
                                : Colors.yellow, // Background changes
                        borderRadius: BorderRadius.circular(
                          40.sp,
                        ), // Rounded switch effect
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.light_mode,
                            color:
                                isDarkMode ? Color(0xff0450FC) : Colors.black,
                            size: 18.sp,
                          ), // Sun
                          Icon(
                            Icons.dark_mode,
                            color: isDarkMode ? Colors.grey : Colors.yellow,
                            size: 18.sp,
                          ), // Moon
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.w, top: 2.h),
                child: Container(
                  color: Colors.transparent,
                  height: 6.h,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How can we help",
                        style: GoogleFonts.poppins(
                          color: Color(0xff111303),
                          fontSize: 14.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Get the best out of your Alevet",
                        style: GoogleFonts.openSans(
                          color: Color(0xff8F8F8F),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: _showSupportDialog,
                child: buildListTile(
                  3,
                  icon: Icons.headphones,
                  title: 'Help & Support',
                  subtitle: 'Contact Us 03369029710',
                  screen: RateUsScreen(),
                  onTapCustom: _showSupportDialog, // Custom onTap
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 6.w, top: 2.h),
                child: Container(
                  color: Colors.transparent,
                  height: 6.h,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About Us",
                        style: GoogleFonts.poppins(
                          color: Color(0xff111303),
                          fontSize: 14.px,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Get the best out of your Alevet",
                        style: GoogleFonts.openSans(
                          color: Color(0xff8F8F8F),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              buildListTile(
                4,
                assetPath: 'assets/tre.png',
                title: 'About Alevet',
                subtitle: 'About, Terms of use, Privacy Policy',
                screen: RateUsScreen(),
              ),
              SizedBox(height: 1.h),
              buildListTile(
                5,
                assetPath: 'assets/star.png',
                title: 'Rate Us',
                subtitle: 'Tell us what you think',
                screen: RateUsScreen(),
              ),
              SizedBox(height: 1.h),
              buildListTile(
                6,
                assetPath: 'assets/telegram.png',
                title: 'Join Telegram Channel',
                subtitle: 'Take part in discussion',
                screen: RateUsScreen(),
                onTapCustom: () => _launchUrl('https://t.me/alevetmarket'),
              ),
              buildListTile(
                7,
                assetPath: 'assets/instgram.png',
                title: 'Join Instagram',
                subtitle: 'Take part in discussion',
                screen: RateUsScreen(),
                onTapCustom:
                    () => _launchUrl(
                      'https://www.instagram.com/alevetmarket?igsh=MWVoOWQxdnNqb2h1Zg==',
                    ),
              ),
              buildListTile(
                8,
                assetPath: 'assets/youtube.png',
                title: 'YouTube',
                subtitle: 'Take part in discussion',
                screen: RateUsScreen(),
                onTapCustom:
                    () => _launchUrl(
                      'https://youtube.com/@forexyaanix?si=ey5dpS2B_B2xCBC8',
                    ),
              ),
              SizedBox(height: 1.h),
              buildListTile(
                9,
                assetPath: 'assets/twittwer.png',
                title: 'Follow us on X',
                subtitle: 'Stay on top of the latest updates',
                screen: RateUsScreen(),
              ),
              SizedBox(height: 2.h),

              SizedBox(
                width: 90.w,
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear(); // Remove all saved data

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffF1FFC6),
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                  child: Text(
                    'Logout'.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff111303),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(
    int index, {
    String? assetPath,
    IconData? icon,
    required String title,
    required String subtitle,
    required Widget screen,
    VoidCallback? onTapCustom, // <-- Add this
  }) {
    return GestureDetector(
      onTap:
          onTapCustom ??
          (() => onTap(index, screen)), // <-- Prefer onTapCustom if provided
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: selectedIndex == index ? Color(0xffFBFFED) : Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading:
              assetPath != null
                  ? Image.asset(
                    assetPath,
                    width: 24.sp,
                    height: 24.sp,
                  ) // Use asset image if provided
                  : icon != null
                  ? Icon(
                    icon,
                    color: Colors.grey,
                    size: 23.sp,
                  ) // Use icon if provided
                  : SizedBox(), // Empty widget if neither is provided
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: Color(0xff111303),
              fontSize: 16.px,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.openSans(
              color: Color(0xff8F8F8F),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 19.px,
            color: Color(0xff606156),
          ),
        ),
      ),
    );
  }
}
