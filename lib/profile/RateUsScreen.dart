import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class ratesuceefull extends StatelessWidget {
  const ratesuceefull({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Container(child: Center(child: Image.asset("assets/ff.png")),)
    );
  }
}

class RateUsScreen extends StatefulWidget {
  @override
  _RateUsScreenState createState() => _RateUsScreenState();
}

class _RateUsScreenState extends State<RateUsScreen> {
  String selectedRating = 'Medium'; // Default rating
  final TextEditingController feedbackController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

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
          'Rate Us',
          style: GoogleFonts.poppins(color: Color(0xff111303)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                'Your Opinion Matters',
                style: GoogleFonts.poppins(
                  fontSize: 18.px,color: Color(0xff0B0A0A),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Please rate your experience',
                style: GoogleFonts.poppins(
                  fontSize: 15.px,color: Color(0xff9D9D9D),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'How would you rate your experience of',
                style: GoogleFonts.poppins(
                  fontSize: 15.px,      fontWeight: FontWeight.w700,
                  color: Color(0xff0B0A0A),
                ),
              ),
                Text(
                'using Avelet App?',
                style: GoogleFonts.poppins(
                fontSize: 15.px,      fontWeight: FontWeight.w700,
                  color: Color(0xff0B0A0A),
                ),
              ),
              SizedBox(height: 3.h),
              // Rating Emojis
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRatingEmoji('Very Poor', '😢', selectedRating == 'Very Poor'),
                  _buildRatingEmoji('Poor', '😕', selectedRating == 'Poor'),
                  _buildRatingEmoji('Medium', '😐', selectedRating == 'Medium'),
                  _buildRatingEmoji('Good', '😊', selectedRating == 'Good'),
                  _buildRatingEmoji('Excellent', '😍', selectedRating == 'Excellent'),
                ],
              ),
              SizedBox(height: 24),
              // Feedback Text Field
              TextField(
                controller: feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write here...',
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              SizedBox(height: 16),
              // Display feedback if entered
              if (feedbackController.text.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$selectedRating App!',
                        style: GoogleFonts.poppins(
                          fontSize: 16.px,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        feedbackController.text,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xffF6FAFD),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 5.h),
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (feedbackController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please provide feedback')),
                      );
                      return;
                    }
                    // Show success bottom sheet
                    _showSuccessBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffEAFFAA),
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                     shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.sp), // Circular edges
    ),
                  ),
                  child: Text(
                    'Submit Now',
                    style: GoogleFonts.poppins(fontSize: 16.px,fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build rating emoji buttons
  Widget _buildRatingEmoji(String rating, String emoji, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRating = rating;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 22.px,
            backgroundColor: isSelected ? Colors.purple : Color(0xffEAEAEA),
            child: Text(
              emoji,
              style: GoogleFonts.poppins(fontSize: 20.px),
            ),
          ),
          SizedBox(height: 8),
          Text(
            rating,
            style: GoogleFonts.poppins(
              fontSize: 16.px,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Method to show the success bottom sheet
void _showSuccessBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) =>ratesuceefull(), // Ensure this widget exists
  );
}

void validateAndShowBottomSheet(BuildContext context, bool isValid) {
  if (isValid) {
    _showSuccessBottomSheet(context);
  } else {
    // Show a snackbar if validation fails
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill all fields correctly')),
    );
  }
}

}

