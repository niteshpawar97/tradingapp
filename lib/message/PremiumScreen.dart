// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import 'package:alevet_market/message/meassgae.dart';

// class PremiumScreen extends StatelessWidget {
//   const PremiumScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.only(top: 4.h),
//         child: Column(
//           children: [
//             // Header Section
//             Container(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Text(
//                     'Get Premium',
//                     style: GoogleFonts.poppins(
//                       fontSize: 24.px,
//                       fontWeight: FontWeight.w800,
//                       color: Color(0xff111303),
//                     ),
//                   ),
//                   SizedBox(height: 1.h),
//                   Text(
//                     'Unlock all the power of this mobile tool\n and enjoy experience like never before!',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
//                       fontSize: 14.px,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff8F8F8F),
//                     ),
//                   ),
//                   SizedBox(height: 2.h),
//                   // Placeholder for the illustration (replace with your asset)
//                   Image.asset(
//                     'assets/Screenshot_2025-04-08_140806-removebg-preview.png', // Add your own image asset here
//                     height: 25.h,
//                     width: double.infinity,
//                   ),
//                 ],
//               ),
//             ),
//             // Subscription Options
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 children: [
//                   Card(
//                     color: Colors.green[50],
//                     child: ListTile(
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Annual',
//                             style: GoogleFonts.poppins(
//                               fontSize: 18.px,
//                               fontWeight: FontWeight.w800,
//                               color: Color(0xff111303),
//                             ),
//                           ),
//                           Container(
//                             width: 18.w,
//                             decoration: BoxDecoration(
//                               color: Color(0xff26CB63),
//                               borderRadius: BorderRadius.circular(20.sp),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Best Value',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 10.px,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xffffffff),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       subtitle: Text(
//                         'First 30 days free - Then \$999/Year',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14.px,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff111303),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Card(
//                     child: ListTile(
//                       title: Text(
//                         'Monthly',
//                         style: GoogleFonts.poppins(
//                           fontSize: 18.px,
//                           fontWeight: FontWeight.w800,
//                           color: Color(0xff111303),
//                         ),
//                       ),
//                       subtitle: Text(
//                         'First 7 days free - Then \$99/Month',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14.px,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff111303),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Card(
//                     child: ListTile(
//                       title: Text(
//                         'Per Day',
//                         style: GoogleFonts.poppins(
//                           fontSize: 18.px,
//                           fontWeight: FontWeight.w800,
//                           color: Color(0xff111303),
//                         ),
//                       ),
//                       subtitle: Text(
//                         '\$1/Per day',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14.px,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff111303),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 3.h),
//                   // Call to Action Button
//                   ElevatedButton(
//                     onPressed: () {
//                Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MessageScreen()),
//                 );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           14.sp,
//                         ), // Adjust the radius as needed
//                       ),
//                       backgroundColor: Color(0xffD2FF47),
//                       minimumSize: Size(double.infinity, 50),
//                     ),
//                     child: Text(
//                       'Start 30 - day free trial',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16.px,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff111303),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 2.h),
//                   Text(
//                     'By placing this order, you agree to the Terms of Service and Privacy Policy. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.',
//                     textAlign: TextAlign.start,
//                     style: GoogleFonts.poppins(
//                       fontSize: 11.px,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff414235),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),

//       // Bottom Navigation Bar
//     );
//   }
// }
