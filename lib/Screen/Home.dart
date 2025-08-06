import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/Screen/ProfileScreen.dart';
import 'package:alevet_market/Screen/refer.dart';
import 'package:alevet_market/bottom/bottomScreen.dart';
import 'package:alevet_market/notification/notifcation.dart';
import 'package:alevet_market/api/home_service.dart';
import 'package:alevet_market/profile/BalanceScreen.dart';
import 'package:alevet_market/refer@eran/referscreen.dart';
import 'package:alevet_market/widgets/no_internet_widget.dart'; // <-- Import your NoInternetWidget file
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:alevet_market/widgets/custom_loading_widget.dart'; // use this for loading state

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  String? _userName;
  String? _userEmail;
  String? _userMobile;
  String? _walletBalance;
  String? _errorMessage;

  bool _isBalanceVisible = true;
  bool _noInternet =
      false; // Simulating no internet. Replace with your network logic.

  @override
  void initState() {
    super.initState();
    print('📦 initState called, fetching data...');
    _fetchData();
    // Set status bar color to white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // White status bar
        statusBarIconBrightness: Brightness.dark, // Dark icons
      ),
    );
  }

  

  Future<void> _fetchData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (!mounted) return;
      setState(() {
        _noInternet = true;
        _isLoading = false;
      });
      return;
    } else {
      if (!mounted) return;
      setState(() {
        _noInternet = false;
      });
    }

    final result = await HomeService().getWalletData();

    if (result['success']) {
      final data = result['data'];
      final user = data['user'];
      final prefs = await SharedPreferences.getInstance();

      // Save to SharedPreferences
      await prefs.setString('userName', user['name']);
      await prefs.setString('userEmail', user['email']);
      await prefs.setString('userMobile', user['mobile']);
      await prefs.setString('walletBalance', data['wallet_balance'].toString());

      if (!mounted) return;
      setState(() {
        _walletBalance = data['wallet_balance'].toString();
        _userName = user['name'];
        _userEmail = user['email'];
        _userMobile = user['mobile'];
        _isLoading = false;
        _errorMessage = null; // Reset error on success
      });
    } else {
      if (!mounted) return;
      setState(() {
        _errorMessage = result['message'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show loading indicator while data is being fetched
      //loadingScreen show on this time
      return Scaffold(body: CustomLoadingWidget(loadingText: "Loading ..."));
    }

    if (_noInternet) {
      return Scaffold(
        body: NoInternetWidget(
          onRetry: () {
            setState(() {
              _isLoading = true;
            });
            _fetchData(); // Retry with connectivity check
          },
          message: "No Internet Connection. Please check your connection.",
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(body: Center(child: Text(_errorMessage!)));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Heyy ${_userName ?? 'User'}!',
                            style: GoogleFonts.poppins(
                              fontSize: 16.px,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff343338),
                            ),
                          ),
                          Text(
                            'Have a nice day 😊',
                            style: GoogleFonts.openSans(
                              fontSize: 12.px,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff343338),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 6.h,
                        width: 25.w,
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Color(0xff2C2C2C),
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                );
                              },
                              child: Image.asset("assets/Frame 2087326610.png"),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationScreen(),
                                  ),
                                );
                              },
                              child: Image.asset("assets/Group 1597881860.png"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search here...',
                      hintStyle: TextStyle(color: Color(0xff111303)),
                      prefixIcon: Icon(Icons.search, color: Color(0xff111303)),
                      suffixIcon: Icon(Icons.mic, color: Color(0xff111303)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff040404),
                          width: 0.5,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),

                  SizedBox(height: 2.h),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Balance (USD)',
                          style: GoogleFonts.poppins(
                            fontSize: 14.px,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff414235),
                          ),
                        ),
                        SizedBox(height: 0.8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  _isBalanceVisible
                                      ? '\$${_walletBalance ?? '0'} '
                                      : '\$***.**', // Hide balance if not visible ye work kyo nahi kr raah h please fix it

                                  style: GoogleFonts.poppins(
                                    fontSize: 36.px,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff343338),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isBalanceVisible = !_isBalanceVisible;
                                    });
                                  },
                                  child: Image.asset(
                                    _isBalanceVisible
                                        ? "assets/eye_open.png"
                                        : "assets/eye_closed.png", // Use your closed-eye asset
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 01.h,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffEBF9ED),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '+22.3%',
                                style: GoogleFonts.openSans(
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff3EC44F),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildActionButton(
                              'Deposit',
                              Icons.vertical_align_top,
                              Colors.green,
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BalanceScreen(),
                                  ),
                                );
                              },
                            ),
                            _buildActionButton(
                              'Withdraw',
                              Icons.vertical_align_bottom,
                              Colors.red,
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BalanceScreen(),
                                  ),
                                );
                              },
                            ),
                            _buildActionButton(
                              'Trade',
                              Icons.trending_up,
                              Colors.blue,
                              () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => TradeScreen(),
                                //   ),
                                // );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Refer & Earn Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Refer & Earn',
                          style: GoogleFonts.openSans(
                            fontSize: 32.px,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff111303),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Get up to \$0.1',
                          style: GoogleFonts.openSans(
                            fontSize: 22.px,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff111303),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReferAndEarnScreen(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'Refer Now',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.px,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff2C2C2C),
                                ),
                              ),
                              Icon(Icons.double_arrow),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Image.asset('assets/Group.png', height: 18.h, width: 30.w),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),

            SizedBox(height: 2.h),

            // Market Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Market',
                    style: GoogleFonts.poppins(
                      fontSize: 18.px,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff111303),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'View All',
                        style: GoogleFonts.openSans(
                          fontSize: 14.px,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff92928B),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Color(0xff92928B)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Image.asset("assets/Component 2.png", scale: 3.sp),
            SizedBox(height: 2.h),

            // Watchlist Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                'Watchlist',
                style: GoogleFonts.poppins(
                  fontSize: 18.px,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff111303),
                ),
              ),
            ),
            SizedBox(height: 1.h),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Image.asset("assets/Frame 2087326447.png", scale: 3.9.sp),
            //     Image.asset("assets/Frame 2087326448.png", scale: 3.9.sp),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 40.w,
                  child: Image.asset(
                    "assets/Frame 2087326447.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 40.w,
                  child: Image.asset(
                    "assets/Frame 2087326448.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Trending Stocks Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Stocks',
                    style: GoogleFonts.poppins(
                      fontSize: 18.px,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff111303),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'View All',
                        style: GoogleFonts.openSans(
                          fontSize: 14.px,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff92928B),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Color(0xff92928B)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  _buildTrendingStock(
                    'XAG/AUD',
                    'Silver vs AUD',
                    '\$28.89',
                    '-0.1%',
                    Colors.red,
                  ),
                  _buildTrendingStock(
                    'XAG/EUR',
                    'Silver vs EUR',
                    '\$28.89',
                    '-0.1%',
                    Colors.red,
                  ),
                  _buildTrendingStock(
                    'XAU/AUD',
                    'Gold vs AUD',
                    '\$77.89',
                    '-0.1%',
                    Colors.red,
                  ),
                  _buildTrendingStock(
                    'XAU/USD',
                    'Gold vs USD',
                    '\$77.89',
                    '-0.1%',
                    Colors.red,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 5.h,
        width: 25.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          color: label == 'Trade' ? Color(0xffE1FF84) : const Color(0xffFBFFED),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 2),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14.px,
                fontWeight:
                    label == 'Trade' ? FontWeight.w800 : FontWeight.w400,
                color:
                    label == 'Trade'
                        ? Color(0xff111303)
                        : const Color(0xff414235),
              ),
            ),
            SizedBox(width: 2.w),
            Icon(
              icon,
              color:
                  label == 'Trade'
                      ? Color(0xff111303)
                      : const Color(0xff414235),
              size: 18.px,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWatchlistCard(
    String symbol,
    String name,
    String price,
    String change,
    Color changeColor,
  ) {
    return Container(
      width: 40.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/frame.png', height: 6.h, width: 6.w),
              SizedBox(width: 2.w),
              Text(
                symbol,
                style: GoogleFonts.poppins(
                  fontSize: 18.px,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff343338),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(name, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: GoogleFonts.poppins(
                  fontSize: 18.px,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff343338),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: changeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  change,
                  style: GoogleFonts.poppins(
                    fontSize: 18.px,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff343338),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingStock(
    String symbol,
    String name,
    String price,
    String change,
    Color changeColor,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Image.asset('assets/Frame 2087326465.png', height: 6.h, width: 10.w),
          SizedBox(width: 3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                symbol,
                style: GoogleFonts.openSans(
                  fontSize: 14.px,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff414235),
                ),
              ),
              Text(
                name,
                style: GoogleFonts.openSans(
                  fontSize: 12.px,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff414235),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: GoogleFonts.poppins(
                  fontSize: 16.px,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff414235),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.trending_down,
                    color: Color(0xffFF0000),
                    size: 18.sp,
                  ),
                  Text(
                    change,
                    style: GoogleFonts.poppins(
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFF0000),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
