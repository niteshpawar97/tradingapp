import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? selectedIdentity;
  final TextEditingController identityNumberController = TextEditingController();
  File? frontImage;
  File? backImage;

  @override
  void dispose() {
    identityNumberController.dispose();
    super.dispose();
  }

  // Function to pick an image
  Future<void> _pickImage(bool isFront) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        if (isFront) {
          frontImage = File(image.path);
        } else {
          backImage = File(image.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.sp, color: Color(0xff111303)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Verification',
          style: GoogleFonts.poppins(
              color: Color(0xff111303),
              fontSize: 18.px,
              fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20.h,
                color: Colors.white,
                width: double.infinity,
                child: Image.asset("assets/ver.png"),
              ),
              SizedBox(height: 1.h),
              Text(
                'Proof of identity',
                style: GoogleFonts.poppins(fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1.h),
              Text(
                'We need to see your name clearly printed on an official document',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select Your Identity',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                value: selectedIdentity,
                items: ['Aadhar Card', 'PAN Card', 'Passport', 'Driving License']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedIdentity = value;
                  });
                },
              ),
              SizedBox(height: 1.h),
              TextField(
                controller: identityNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Identity No',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Upload Your Documents',
                style: GoogleFonts.poppins(fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We need to see your name clearly printed on an \nofficial document',
                style: GoogleFonts.poppins(fontSize: 14.sp, color: Color(0xffACB5BB)),
              ),
              SizedBox(height: 16),
              _buildUploadCard('Front View', frontImage, () => _pickImage(true)),
              SizedBox(height: 16),
              _buildUploadCard('Back View', backImage, () => _pickImage(false)),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  
                  onPressed: () {
                    if (selectedIdentity == null ||
                        identityNumberController.text.isEmpty ||
                        frontImage == null ||
                        backImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields and upload images')),
                      );
                      return;
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => KycInstructionScreen()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                   shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.sp), // Circular edges
    ),
                    backgroundColor: Color(0xffD2FF47),
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Submit'.toUpperCase(),
                    style: GoogleFonts.poppins(fontSize: 16.sp,color: Color(0xff111303),fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build upload card for images
  Widget _buildUploadCard(String title, File? image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 20.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(image, fit: BoxFit.cover),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                 // Icon(Icons.image, size: 50.sp, color: Colors.grey),
                  Positioned(
                    bottom: 10,
                    child: Column(
                      children: [
                        Center(child: Icon(Icons.camera_alt, color: Colors.red, size: 28.sp)),
                        SizedBox(height: 5),
                        Text(title, style: TextStyle(fontSize: 14.sp)),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
