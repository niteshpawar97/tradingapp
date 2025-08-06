import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  String walletBalance = '';

  @override
  void initState() {
    super.initState();
    print("⚙️ initState called"); // 👈 Add this
    _loadWalletBalance();
  }

  Future<void> _loadWalletBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      walletBalance = prefs.getString('walletBalance') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Stocks',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),

              // Available Balance
              Row(
                children: [
                  Image.asset("assets/rd (2).png"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Available Balance',
                            style: GoogleFonts.poppins(
                              fontSize: 16.px,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff414235),
                            ),
                          ),
                          Text(
                            '\$$walletBalance',
                            style: GoogleFonts.poppins(
                              fontSize: 22.px,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff111303),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10.w,),
                       Container(
  decoration: BoxDecoration(
    color: Color(0xff000000),
    // Optional background color
    shape: BoxShape.circle,  // Makes it rounded
  ),
  padding: EdgeInsets.all(8), // Adjust padding as needed
  child: Icon(
    Icons.add,
    color: Color(0xffffffff),
  ),
)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 1.h,),
           
              //     // Row(
              //     //       children: [
              //     //         Icon(Icons.add, color: Colors.green),

              //     //       ],
              //     //     ),
              //       ),
              // )  ),
              // Tabs
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffE1FF84),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                      ),
                      child: Text(
                        'Positions',
                        style: GoogleFonts.poppins(
                          fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff111303),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFBFFED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                      ),
                      child: Text(
                        'Holdings',
                        style: GoogleFonts.poppins(
                          fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff414235),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFBFFED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                      ),
                      child: Text(
                        'Orders',
                        style: GoogleFonts.poppins(
                          fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff414235),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Market Indices
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Market Indices',
                          style: GoogleFonts.poppins(
                            fontSize: 16.px,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff111303),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View all',
                            style: GoogleFonts.poppins(
                              fontSize: 14.px,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff8F8F8F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Image.asset("assets/Frame 2087326456.png", scale: 2.9.sp),
                  ],
                ),
              ),
              // Build Your Wealth
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.sp),
                  ),
                  color: Color(0xffFBFFED),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Build Your Wealth',
                              style: GoogleFonts.poppins(
                                fontSize: 16.px,
                                color: Color(0xff111303),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'You don\'t have any position \nin your portfolio',
                              style: GoogleFonts.poppins(
                                fontSize: 12.px,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff8F8F8F),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffD2FF47),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.sp),
                                ),
                              ),
                              child: Text(
                                'Explore',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.px,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        Image.asset(
                          'assets/rd (1).png', // Replace with your icon asset
                        ),
                      ],
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
