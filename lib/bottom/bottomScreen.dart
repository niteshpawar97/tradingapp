import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/Screen/MessagesScreen.dart';
import 'package:alevet_market/Screen/PortfolioScreen.dart';
import 'package:alevet_market/Screen/Home.dart';
import 'package:alevet_market/Screen/market.dart';
import 'package:alevet_market/profile/BalanceScreen.dart';
import 'package:alevet_market/refer@eran/referscreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    HomeScreen(),
    PortfolioScreen(),
    PremiumScreen(),
    StockScreen(),
    ReferAndEarnScreen(),
    BalanceScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            _buildNavItem('assets/8.png', 'Home', 0),
            _buildNavItem('assets/4.png', 'Portfolio', 1),
            _buildNavItem('assets/discover-circle.png', 'Plan', 2),
            _buildNavItem('assets/3.png', 'Market', 3),
            _buildNavItem('assets/22.png', 'Refer', 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    String assetPath,
    String label,
    int index,
  ) {
    bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform:
                isSelected
                    ? Matrix4.translationValues(
                      0,
                      -20,
                      0,
                    ) // Move up when selected
                    : Matrix4.translationValues(0, 0, 0), // Default position
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isSelected)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xffD2FF47),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        assetPath,
                        width: 25.sp,
                        height: 25.sp,
                        color: const Color(0xff606156),
                      ),
                    ),
                  ),

                Padding(
                  padding: EdgeInsets.only(top: isSelected ? 10 : 0),
                  child:
                      isSelected
                          ? SizedBox.shrink() // Hide icon when selected
                          : Image.asset(assetPath, width: 24, height: 24),
                ),
              ],
            ),
          ),
          //  /   SizedBox(height: 1), // Space between icon and text
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12.px,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Color(0xff424242) : Color(0xff606156),
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}
