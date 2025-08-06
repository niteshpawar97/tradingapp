import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
// import 'package:alevet_market/message/meassgae.dart';
import 'package:alevet_market/api/plan_service.dart';
import 'dart:convert'; // <-- Add this import at the top

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Column(
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Get Premium',
                    style: GoogleFonts.poppins(
                      fontSize: 24.px,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff111303),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Unlock all the power of this mobile tool\n and enjoy experience like never before!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14.px,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff8F8F8F),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  // Placeholder for the illustration (replace with your asset)
                  Image.asset(
                    'assets/Screenshot_2025-04-08_140806-removebg-preview.png', // Add your own image asset here
                    height: 25.h,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            // Subscription Options
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  // Daily Subscription Card
                  Card(
                    child: ListTile(
                      title: Text(
                        'Per Day',
                        style: GoogleFonts.poppins(
                          fontSize: 18.px,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff111303),
                        ),
                      ),
                      subtitle: Text(
                        '\$1/Per day',
                        style: GoogleFonts.poppins(
                          fontSize: 14.px,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff111303),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  // Call to Action Button
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final response = await planBuy();
                        // Decode the JSON response
                        final data = jsonDecode(response.body);

                        // Now you can access the message
                        print(data['message']);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              data['message'] ?? 'Something went wrong!',
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          14.sp,
                        ), // Adjust the radius as needed
                      ),
                      backgroundColor: Color(0xffD2FF47),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Start Signal Premium',
                      style: GoogleFonts.poppins(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff111303),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'By placing this order, you agree to the Terms of Service and Privacy Policy. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: 11.px,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff414235),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
    );
  }
}
