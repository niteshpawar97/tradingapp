import 'package:flutter/material.dart';
import 'package:alevet_market/profile/KycFailureScreen.dart';
import 'package:alevet_market/profile/KycSuccessScreen.dart';

class FacialRecognitionScreen extends StatelessWidget {
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
          'Facial Recognition',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[300], // Placeholder for camera view
              child: Center(
                child: Text(
                  'Camera View (Placeholder)',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Simulate trying again (refresh the screen)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => FacialRecognitionScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Simulate success (or failure) - 50% chance for demo
                      if (DateTime.now().millisecond % 2 == 0) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => KycSuccessScreen()),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => KycFailureScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}