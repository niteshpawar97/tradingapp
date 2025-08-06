import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For copying to clipboard
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/refer@eran/referreward.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({super.key});

  // Function to copy referral code to clipboard
  void _copyToClipboard(String code, BuildContext context) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied to clipboard!')),
    );
  }


  @override
  Widget build(BuildContext context) {
    const String referralCode = "AVF03464";

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5.h),
              Center(
                child: Text(
                  "Refer & Earn",
                  style: GoogleFonts.poppins(
                    fontSize: 18.px,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff111303),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 3.h),
                child: Image.asset(
                  'assets/bb.png', // Replace with your illustration asset
                  height: 30.h,
                  fit: BoxFit.fill,
                ),
              ),
              // Referral Info
              Text(
                'Earn \$00.1 For Every Referral',
                style: GoogleFonts.poppins(
                  fontSize: 24.px,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff111303),
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'Get your friends on forex and win big rewards',
                style: GoogleFonts.poppins(
                  fontSize: 14.px,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8F8F8F),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Referral Code Section
              Container(
               
               height: 8.h,
               width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your Referral Code',
                            style: GoogleFonts.openSans(
                              fontSize: 12.px,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffE7E7E6),
                            ),
                          ),
                          Text(
                            referralCode,
                      
                            style: GoogleFonts.openSans(
                              fontSize: 16.px,
                              fontWeight: FontWeight.w800,
                              color: Color(0xffE7E7E6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("|",  style: GoogleFonts.openSans(
                            fontSize: 20.px,
                            fontWeight: FontWeight.w800,
                            color: Color(0xffE7E7E6),
                          ),),
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 20),
                          onPressed:
                              () => _copyToClipboard(referralCode, context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              //TODO: WhatsApp Invite Button with Icon click hone par sabhi share wale apps khule onpress par 
              ElevatedButton.icon(
                onPressed: () {
                  // Implement WhatsApp sharing functionality here
                  // For example, you can use a package like 'share_plus' to share the referral code
                  Share.share('Join me on this app! App link: https://alevet.com/');
                  // For now, we will just show a snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invite your friends on WhatsApp!'),

                    ),
                  );
                },
                icon: Image.asset("assets/whatsap.png"),
                label:  Text('Invite on WhatsApp',style: GoogleFonts.poppins(fontSize: 16.px,
                fontWeight: FontWeight.w800, color: Color(0xff111303)),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD2FF47), // WhatsApp green
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle:  GoogleFonts.poppins(fontSize: 16.px,color: Color(0xff111303)),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              // Rewards Section
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     'Your Rewards',
              //     style: GoogleFonts.poppins(
              //       fontSize: 18.px,
              //       fontWeight: FontWeight.w800,
              //       color: Color(0xff1E1A18),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 16),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     // Reward Item 1
              //     Image.asset(
              //       'assets/Reward (1).png', // Replace with your reward icon
              //       height: 15.h,
              //       width: 40.w,
              //     ),
              //     // Reward Item 2
              //     InkWell(onTap: (){
              //          Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) =>Referreward ()),
              //   );
              //     },
              //       child: Image.asset(
              //         'assets/Reward.png', // Replace with your reward icon
              //         height: 15.h,
              //         width: 40.w,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
