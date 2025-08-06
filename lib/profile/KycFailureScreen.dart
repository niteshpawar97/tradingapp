import 'package:flutter/material.dart';
import 'package:alevet_market/profile/VerificationScreen.dart';

class KycFailureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Verification',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 80,
            ),
            SizedBox(height: 16),
            Text(
              'We are very Sorry! Your KYC is not verified!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
             //   textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Sorry, your account is not verified. Please try to re-apply or contact us.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              //  textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to VerificationScreen to re-apply
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => VerificationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Re-Apply',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}