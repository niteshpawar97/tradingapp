import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/market/paymentsuccefull.dart';


class TradingScreen extends StatefulWidget {
  @override
  State<TradingScreen> createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {
    String selectedType = 'Delivery';

      String walletBalance = '';

  @override
void initState() {
  super.initState();
  print("⚙️ initState called"); // 👈 Add this
  _loadWalletBalance();
}


  Future<void> _loadWalletBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      walletBalance = prefs.getString('walletBalance') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 5.h, left: 2.w, right: 4.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Market",
                        style: GoogleFonts.poppins(
                          fontSize: 18.px,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff111303),
                        ),
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.star), onPressed: () {}),
                ],
              ),

              SizedBox(height: 1.h),
              Padding(
               padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/Frame 98.png"),
                            SizedBox(width: 25.w),
                            Image.asset("assets/Frame 2087326480.png"),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Text(
                            '\$189.00',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff111303),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_drop_up,
                                color: Color(0xffFF7070),
                                size: 20,
                              ),
                              Text(
                                '+2.05%',
                                style: TextStyle(color: Color(0xffFF7070)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Delivery/Intraday Toggle
Padding(
   padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w),
  child: Row(
    children: [
      GestureDetector(
        onTap: () {
          setState(() {
            selectedType = 'Delivery';
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delivery',
              style: GoogleFonts.openSans(
                fontSize: 16.px,
                fontWeight: FontWeight.w800,
                color: selectedType == 'Delivery' ? Color(0xff111303) : Color(0xff92928B),
              ),
            ),
            SizedBox(height: 4),
            Container(
              height: 2,
              width: 60,
              color: selectedType == 'Delivery' ? Color(0xff111303) : Colors.transparent,
            )
          ],
        ),
      ),
      SizedBox(width: 20),
      GestureDetector(
        onTap: () {
          setState(() {
            selectedType = 'Intraday';
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Intraday',
              style: GoogleFonts.openSans(
                fontSize: 16.px,
                fontWeight: FontWeight.w600,
                color: selectedType == 'Intraday' ? Color(0xff111303) : Color(0xff92928B),
              ),
            ),
            SizedBox(height: 4),
            Container(
              height: 2,
              width: 60,
              color: selectedType == 'Intraday' ? Color(0xff111303) : Colors.transparent,
            )
          ],
        ),
      ),
    ],
  ),
)
,
          

              // Order Type Buttons
              Padding(
                padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Color(0xffE1FF84),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Market'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                           foregroundColor: Colors.black,
                        backgroundColor: Color(0xffFBFFED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Limit'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                           foregroundColor: Colors.black,
                        backgroundColor: Color(0xffFBFFED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('SI'),
                    ),
                    DropdownButton<String>(
                      value: 'Day',
                      items:
                          <String>['Day', 'GTC'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (_) {},
                      underline: SizedBox(),
                      icon: Icon(Icons.arrow_drop_down),
                      style: TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                    ),
                  ],
                ),
              ),
          

              // Quantity Input
          
               Padding(
                padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    fillColor: Color(0xffF6FAFD),
                    border: OutlineInputBorder(
                      
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorText: 'Available amount is not enough',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 10.0,
                    ),
                  ),
                ),
              ),
      

             Padding(
  padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w),
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.grey[200], // Light background
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Market Price',
                style: GoogleFonts.poppins(
            fontSize: 14.px,
            fontWeight: FontWeight.w500,
            color: Color(0xffB5B6B1),
          ),
            ),
            Icon(Icons.arrow_drop_down,    color: Color(0xffB5B6B1),),
          ],
        ),
        Text(
          'At Market',
          style: GoogleFonts.poppins(
            fontSize: 14.px,
            fontWeight: FontWeight.w500,
            color: Color(0xff111303),
          ),
        ),
      ],
    ),
  ),
),

           

              // Order Note
              Padding(
                 padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18.sp,  color: Color(0xFF92928B),),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Order will be placed once market opens at 9:00 AM on Monday, Mar 17th',
                      style: GoogleFonts.openSans(
                        fontSize: 12.px,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF92928B),
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            

              // Available and Required Amount
              Padding(
                padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Avail. \$0.00',
                      style: GoogleFonts.poppins(
                        fontSize: 12.px,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF92928B),
                      ),
                    ),
                    Text(
                      'Req \$3098.89',
                          style: GoogleFonts.poppins(
                        fontSize: 12.px,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111303),
                      ),
                    ),
                  ],
                ),
              ),Divider(),
          

              // Add Money Button
              Padding(
             padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 4.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DepositScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD2FF47),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Add Money',
                      style: GoogleFonts.poppins(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff111303),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _amountController = TextEditingController(
    text: '3300',
  );
  
  get walletBalance => null;

  void _addAmount(int value) {
    int currentAmount = int.tryParse(_amountController.text) ?? 0;
    int updatedAmount = currentAmount + value;
    setState(() {
      _amountController.text = updatedAmount.toString();
    });
  }

  void _onSubmit(String value) {
    int? enteredAmount = int.tryParse(value);
    if (enteredAmount != null &&
        enteredAmount >= 3000 &&
        enteredAmount <= 100000) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Amount entered: ₹$enteredAmount')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Amount should be between ₹3000 and ₹1,00,000')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 5.h, left: 4.w, right: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Deposit INR",
                      style: GoogleFonts.poppins(
                        fontSize: 18.px,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff111303),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 24),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Image.asset('assets/rd (2).png'),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Balance1',
                      style: GoogleFonts.poppins(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff414235),
                      ),
                    ),
                    Text(
                      '\$$walletBalance ',
                      style: GoogleFonts.poppins(
                        fontSize: 22.px,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff414235),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 3.h),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              onFieldSubmitted: _onSubmit,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                hintText: 'Min ₹3000 | Max ₹1,00,000',
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              "Min ₹ 3000 | Max ₹ 1,00,000",
              style: GoogleFonts.poppins(
                fontSize: 14.px,
                fontWeight: FontWeight.w500,
                color: Color(0xff92928B),
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _addAmount(3000),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xffFBFFED),
                  ),
                  child: Text(
                    '+3000',
                    style: GoogleFonts.poppins(
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff111303),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _addAmount(6000),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xffFBFFED),
                  ),
                  child: Text(
                    '+6000',
                    style: GoogleFonts.poppins(
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff111303),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _addAmount(9000),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xffFBFFED),
                  ),
                  child: Text(
                    '+9000',
                    style: GoogleFonts.poppins(
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff111303),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _addAmount(12000),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xffFBFFED),
                  ),
                  child: Text(
                    '+12000',
                    style: GoogleFonts.poppins(
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff111303),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 5),
                Text(
                  'Net Banking limit Min ₹3000 | Max ₹1,00,000',
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff92928B),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                'Note: your deposit may take up to 15 min',
                style: GoogleFonts.openSans(
                  fontSize: 12.px,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff92928B),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentOptionsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD2FF47),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Deposit \$${_amountController.text}',
                  style: GoogleFonts.poppins(
                    fontSize: 16.px,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff111303),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  _PaymentOptionsScreenState createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => const Paymentsuccefull(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 5.h, left: 4.w, right: 4.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Payment Options",
                          style: GoogleFonts.poppins(
                            fontSize: 18.px,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff111303),
                          ),
                        ),
                      ),
                    ),
                    // Optional: To balance the layout, you can add a SizedBox of same width as the icon
                    SizedBox(width: 24), // Icon usually ~24px wide
                  ],
                ),
                SizedBox(height: 3.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Color(0xff111303)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Funds transferred from any unverified Bank account will be refunded in 7-10 working days.',
                        style: GoogleFonts.openSans(
                          fontSize: 13.px,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff92928B),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines:
                            2, // You can adjust this to control how many lines to show
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Center(child: Image.asset("assets/Frame 2087326634.png")),
                SizedBox(height: 1.h),
                Container(
                  padding: EdgeInsets.all(20),

                  child: Center(
                    child: Image.asset('assets/image 123.png', height: 200),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  "UTR Number",
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffACB5BB),
                  ),
                ),

                SizedBox(height: 1.h),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'UTR Number',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter UTR Number'
                              : null,
                ),
                SizedBox(height: 1.h),
                Text(
                  "Reference Number",
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffACB5BB),
                  ),
                ),

                SizedBox(height: 1.h),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Reference Number',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter Reference Number'
                              : null,
                ),
                SizedBox(height: 1.h),
                Text(
                  "Transaction ID",
                  style: GoogleFonts.poppins(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffACB5BB),
                  ),
                ),

                SizedBox(height: 1.h),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Transaction ID',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter Transaction ID'
                              : null,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD2FF47),
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff111303),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
