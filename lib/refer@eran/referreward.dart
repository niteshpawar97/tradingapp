import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class Referreward extends StatefulWidget {
  const Referreward({super.key});

  @override
  State<Referreward> createState() => _ReferrewardState();
}

class _ReferrewardState extends State<Referreward> {
  @override
  void initState() {
    super.initState();
    // Hide status bar for fullscreen experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore status bar when leaving the screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full background image
          Positioned.fill(
            child: Image.asset(
              "assets/Refer & Earn.png",
              fit: BoxFit.cover,
            ),
          ),
          // Back arrow
          Positioned(
            top: 6.2.h,
            left: 16,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
               
                padding: EdgeInsets.all(8),
                child: Icon(Icons.arrow_back, color: Colors.black,size: 20.sp,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
