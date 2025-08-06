import 'package:flutter/material.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String name = 'Abhishek SG';
  String dateOfBirth = '22-04-1999';
  String gender = 'Male';
  String mobileNumber = '+91 8080808080';
  String email = 'abhisheksg11@gmail.com';
  String country = 'Canada';

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
          'My Profile',
          style: TextStyle(color: Colors.black),
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
              // Profile Image with Edit Icon
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _showImageUploadBottomSheet(context);
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey[200],
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Basic Info Section
              Text(
                'BASIC INFO',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
              // Name Field
              _buildInfoField('Name', name),
              SizedBox(height: 16),
              // Date of Birth and Gender Row
              Row(
                children: [
                  Expanded(
                    child: _buildInfoFieldWithIcon(
                      'Date of Birth',
                      dateOfBirth,
                      Icons.calendar_today,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField('Gender', gender, ['Male', 'Female', 'Other']),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Mobile Number Field
              _buildInfoField('Mobile Number', mobileNumber),
              SizedBox(height: 16),
              // Email ID Field
              _buildInfoFieldWithIcon(
                'Email ID',
                email,
                Icons.check_circle,
                iconColor: Colors.green,
              ),
              SizedBox(height: 16),
              // Country Field
              _buildDropdownField('Country', country, ['Canada', 'USA', 'India', 'UK']),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a text field with label
  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // Helper method to build a text field with an icon
  Widget _buildInfoFieldWithIcon(String label, String value, IconData icon, {Color? iconColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
              Icon(
                icon,
                size: 20,
                color: iconColor ?? Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to build a dropdown field
  Widget _buildDropdownField(String label, String value, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: SizedBox(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                if (label == 'Gender') {
                  gender = newValue!;
                } else if (label == 'Country') {
                  country = newValue!;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  // Method to show the image upload bottom sheet
  void _showImageUploadBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Crop Image',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Placeholder for the image cropping area
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      minimumSize: Size(120, 50),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Simulate image upload (in a real app, you'd handle image cropping and uploading here)
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Image uploaded successfully')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      minimumSize: Size(120, 50),
                    ),
                    child: Text(
                      'Upload',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}