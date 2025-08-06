import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/market/TradingScreen.dart';

class marketsheetgraph extends StatefulWidget {
  marketsheetgraph({super.key});

  @override
  State<marketsheetgraph> createState() => _marketsheetgraphState();
}

class _marketsheetgraphState extends State<marketsheetgraph> {
  bool isAdded = false;

  void _toggleWatchlist() {
    setState(() {
      isAdded = !isAdded;
    });

    _showTopSnackBar(
      context,
      isAdded
          ? "Added Successfully to watchlist"
          : "Removed successfully from watchlist",
      isAdded ? Colors.green : Colors.red,
      isAdded ? Icons.check_circle_outline : Icons.cancel_outlined,
    );
  }

  void _showTopSnackBar(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
  ) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xff1F1F1F),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: color,
                      child: Icon(icon, color: Colors.white, size: 20),
                      radius: 14,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        message,
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(seconds: 3)).then((value) => overlayEntry.remove());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 4.h,
            left: 2.w,
            right: 2.w,
            bottom: 2.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Market",
                        style: GoogleFonts.poppins(
                          fontSize: 18.px,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff111303),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isAdded ? Icons.star : Icons.star_border,
                      color: isAdded ? Colors.yellow[700] : Colors.black,
                    ),
                    onPressed: _toggleWatchlist,
                  ),
                ],
              ),

              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/Frame 98.png"),
                            SizedBox(width: 25.w),
                            Image.asset("assets/Frame 2087326480.png"),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Text(
                            '\$189.00',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff111303),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_drop_up,
                                color: Color(0xffFF7070),
                                size: 20,
                              ),
                              Text(
                                '+2.05%',
                                style: TextStyle(color: Color(0xffFF7070)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Chart Image
              Container(
                color: Colors.transparent,
                height: 37.h,
                width: double.infinity,

                child: Padding(
                  padding: EdgeInsets.only(left: 1.w, right: 1.w),
                  child: Image.asset(
                    'assets/Frame 2087326492.png', // Replace with your image path
                  ),
                ),
              ),
              // Tabs
              Container(
                padding: EdgeInsets.symmetric(vertical: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTab('Overview'),
                    _buildTab('More'),
                    _buildTab('F&Q'),
                  ],
                ),
              ),
              // Daily Performance
              Padding(
                padding: EdgeInsets.only(top: 0.5.h, left: 4.w, right: 4.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Daily Performance',
                          style: GoogleFonts.poppins(
                            fontSize: 18.px,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff111303),
                          ),
                        ),
                        Icon(Icons.info_outline, color: Color(0xff111303)),
                      ],
                    ),
                    Image.asset("assets/Frame 2087326496.png", scale: 3.sp),
                    SizedBox(height: 1.h),
                    Image.asset("assets/Frame 2087326509.png"),
                  ],
                ),
              ),
              // Fundamentals
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fundamentals',
                          style: GoogleFonts.poppins(
                            fontSize: 18.px,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff111303),
                          ),
                        ),
                        Icon(Icons.info_outline, color: Color(0xff111303)),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Divider

                    // Content
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFundRow('P/E Ratio', '38.57'),
                          _buildFundRow('Industry P/E', '20.57'),
                          _buildFundRow('ROE', '20.57'),
                          _buildFundRow('Dividend Yield', '20.57'),
                          _buildFundRow('P/B Ratio', '20.57'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // About Company
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'About Company',
                  style: GoogleFonts.openSans(
                    fontSize: 18.px,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff111303),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'SBICard is one of India\'s leading credit card issuers. Established in 1998 as a joint venture between the State Bank of India and GE Capital, the company offers a wide range of credit cards. Read more',
                  style: GoogleFonts.openSans(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff111303),
                  ),
                ),
              ),
              // Financials (Placeholder)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Financials',
                      style: GoogleFonts.poppins(
                        fontSize: 18.px,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff111303),
                      ),
                    ),
                    Text(
                      "Quarterly ",
                      style: GoogleFonts.poppins(
                        fontSize: 14.px,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff111303),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/Fianancial.png", scale: 3.7.sp),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TradingScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD2FF47),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Buy',
                          style: GoogleFonts.poppins(
                            fontSize: 16.px,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff111303),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xFFD2FF47)),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Sell',
                          style: GoogleFonts.poppins(
                            fontSize: 16.px,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff111303),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             // SizedBox(height: 2.h,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text) {
    return TextButton(
      onPressed: () {},
      child: Container(
        width: 20.w,
        decoration: BoxDecoration(
          color: Color(0xffE1FF84),
          borderRadius: BorderRadius.circular(14.sp),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14.px,
                color: Color(0xff111303),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFundRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16.px,
              fontWeight: FontWeight.bold,
              color: Color(0xff606156),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16.px,
              fontWeight: FontWeight.bold,
              color: Color(0xff606156),
            ),
          ),
        ],
      ),
    );
  }
}
