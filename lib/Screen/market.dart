import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/market/marketshhet.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _stocks = [
    {
      'name': 'XAG/AUD \n Silver vs. Aust.',
      'price': '\$22.99',
      'change': '+4.39%',
      'image': 'assets/Frame 2087326467.png',
    },

    {
      'name': 'USOIL \n Crude Oil',
      'price': '\$32.69',
      'change': '-0.13%',
      'image': 'assets/Frame 2087326465 (1).png',
    },
    {
      'name': 'ETH \n Ethereum vs US Dollar',
      'price': '\$277.69',
      'change': '-1.39%',
      'image': 'assets/Frame 2087326465 (2).png',
    },
    {
      'name': 'GBPJPY \n Great Britain Pound vs Japanes',
      'price': '\$277.69',
      'change': '-0.13%',
      'image': 'assets/Frame 2087326466.png',
    },
    {
      'name': 'US30 \n US Wall Street 30 Index',
      'price': '\$277.69',
      'change': '-1.39%',
      'image': 'assets/Frame 2087326465 (3).png',
    },
    {
      'name': 'USTEC \n US Tech 100 Index',
      'price': '\$277.69',
      'change': '-0.13%',
      'image': 'assets/Frame 2087326465 (4).png',
    },
    {
      'name': 'BTC \n Bitcoin vs US Dollar',
      'price': '\$277.69',
      'change': '-1.39%',
      'image': 'assets/Frame 2087326465 (5).png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(
          0xFFD2FF47,
        ), // Light green color matching the image
        elevation: 0, // Removes shadow for a flat look
        toolbarHeight: 4.h,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Top Gainers'),
            Tab(text: 'Top Losers'),
            Tab(text: 'Under \$10'),
          ],
          indicatorColor: Colors.black, // White underline for selected tab
          labelColor: Colors.black, // White text for tabs
          unselectedLabelColor:
              Colors.black, // Slightly transparent white for unselected tabs
          indicatorWeight: 2.0, // Thicker indicator line
        ),
      ),
      body: Container(
        // Adds margin around the body content
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the rounded container
          borderRadius: BorderRadius.circular(20.0), // Rounds the corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Adds a subtle shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            20.sp,
          ), // Ensures content clips to rounded edges
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Stocks',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.tune),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Color(0xffF6FAFD),
                  ),
                ),
              ),
              // Stock List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 1.h,
                  ),
                  itemCount: _stocks.length,
                  itemBuilder: (context, index) {
                    final stock = _stocks[index];
                    bool isPositive = stock['change'].startsWith('+');
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: ListTile(
                        leading: InkWell(onTap: () {
                           Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>StockDetailScreen()),
                );
                        },
                          child: Image.asset(
                            stock['image'],
                          
                            // width: 24,
                            // height: 24,
                          ),
                        ),
                        title: Text(
                          stock['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 14.px,
                            color: Color(0xff414235),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              stock['price'],
                              style: GoogleFonts.poppins(
                                fontSize: 16.px,
                                color: Color(0xff414235),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              stock['change'],
                              style: TextStyle(
                                color: isPositive ? Colors.green : Colors.red,
                                fontSize: 12.px,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
