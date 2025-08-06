import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class NotificationScreen extends StatelessWidget {
  // Simulated notification data (you can replace this with your actual data)
  final List<Map<String, dynamic>> notifications = [
    {
      'date': '27 Des 2022',
      'items': [
        {
          'icon': Icons.check_circle,
          'color': Color(0xff85F9BB),
          'title': 'Your order has ben successfull',
          'subtitle': 'Happy with 10GB',
        },
        {
          'icon': Icons.outbound,
          'color': Color(0xff546EF7),
          'title': 'DISCOUNT ALERT',
          'subtitle': 'Up to 50% discount when you buy credits now',
        },
        {
          'icon': Icons.check_circle,
          'color':Color(0xff85F9BB),
          'title': 'Your order has ben successfull',
          'subtitle': 'Happy with 10GB',
        },
      ],
    },
    {
      'date': '26 Des 2022',
      'items': [
        {
          'icon': Icons.check_circle,
          'color': Color(0xff85F9BB),
          'title': 'Your order has ben successfull',
          'subtitle': 'Happy with 10GB',
        },
        {
          'icon': Icons.outbound,
          'color': Color(0xff546EF7),
          'title': 'DISCOUNT ALERT',
          'subtitle': 'Up to 50% discount when you buy credits now',
        },
        {
          'icon': Icons.check_circle,
          'color': Color(0xff85F9BB),
          'title': 'Your order has ben successfull',
          'subtitle': 'Happy with 10GB',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.px, color: Color(0xff111303)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Notification' ,   style: GoogleFonts.poppins(
              color: Color(0xff111303),
              fontSize: 18.px,
              fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? _buildEmptyState() // Show empty state if no notifications
          : _buildNotificationList(), // Show notification list if there are notifications
    );
  }

  // Empty state UI (First Image)
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder for the illustration (you can replace with an actual image)
          Icon(
            Icons.email,
            size: 150,
            color: Colors.green,
          ),
          SizedBox(height: 20),
          Text(
            "You Don't have any notification",
            style: GoogleFonts.poppins(
           fontSize: 18.px,
              fontWeight: FontWeight.w800,
    color: Color(0xff151B33),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Notification list UI (Second Image)
  Widget _buildNotificationList() {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notificationGroup = notifications[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                notificationGroup['date'],
                style: GoogleFonts.poppins(
                  fontSize: 16.px,
                  fontWeight: FontWeight.w800,
                color: Color(0xff151B33),
                ),
              ),
            ),
            // Notification items under the date
            ...notificationGroup['items'].map<Widget>((item) {
              return ListTile(
                leading: Icon(
                  item['icon'],
                  color: item['color'],
                  size: 30,
                ),
                title: Text(
                  item['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 16.px, color: Color(0xff151B33),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  item['subtitle'],
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    color: Color(0xff97999B),  fontWeight: FontWeight.w600
                  ),
                ),
              );
            }).toList(),
            Divider(), // Separator between date groups
          ],
        );
      },
    );
  }
}