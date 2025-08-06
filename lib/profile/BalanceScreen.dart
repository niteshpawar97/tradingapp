import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:alevet_market/bottom/bottomScreen.dart';
// import 'package:alevet_market/profile/trasction.dart';
import 'package:flutter/services.dart';
import 'package:alevet_market/api/wallet_service.dart';
import 'package:alevet_market/widgets/custom_loading_widget.dart';
import 'package:alevet_market/widgets/no_internet_widget.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  List<dynamic> _transactions = [];
  bool _isLoading = true;
  String walletBalance = '';
  bool _noInternet = false;

  @override
  void initState() {
    super.initState();
    print("⚙️ initState called"); // 👈 Add this
    _loadWalletBalance();
    fetchTransactionHistory();
  }

  Future<void> _loadWalletBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      walletBalance = prefs.getString('walletBalance') ?? '';
    });
  }

  Future<void> fetchTransactionHistory() async {
    print("🚀 fetchTransactionHistory started");

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _noInternet = true;
        _isLoading = false;
      });
      return;
    } else {
      setState(() {
        _noInternet = false;
      });
    }
    setState(() {
      _isLoading = true;
    });
    print("🔄 Fetching transaction history...");
    try {
      final response = await getTransactionHistory();
      print("📜 Transaction history fetched: ${response.body}");
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        setState(() {
          _transactions =
              decoded['transactions']; // 👈 Adjust if your key is different
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load history");
      }
    } catch (e) {
      print("❌ Error: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show loading indicator while data is being fetched
      //loadingScreen show on this time
      return Scaffold(body: CustomLoadingWidget(loadingText: "Loading ..."));
    }

    if (_noInternet) {
      return Scaffold(
        body: NoInternetWidget(
          onRetry: () {
            setState(() {
              _isLoading = true;
            });
            fetchTransactionHistory();
          },
          message: "No Internet Connection. Please check your connection.",
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.px, color: Color(0xff111303)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Balance',
          style: GoogleFonts.poppins(
            color: Color(0xff111303),
            fontSize: 18.px,
            fontWeight: FontWeight.w800,
          ),
        ),

        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Help',
                style: GoogleFonts.poppins(
                  color: Color(0xff95B532),
                  fontSize: 16.px,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset("assets/coin.png", scale: 0.4.h),
                Column(
                  children: [
                    Text(
                      'Available Balance',
                      style: GoogleFonts.poppins(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff414235),
                      ),
                    ),

                    Text(
                      '\$$walletBalance',
                      style: GoogleFonts.poppins(
                        fontSize: 22.px,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff414235),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 2.h),
            _buildBalanceDetail('Opening Balance', '\$$walletBalance'),
            _buildBalanceDetail("Today's Received Balance", '\$0.00'),
            _buildBalanceDetail("Today's Used Balance", '\$0.00'),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.px),
                  color: Color(0xffBFE841),
                ),

                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Withdrawable Balance',
                          style: GoogleFonts.poppins(
                            fontSize: 14.px,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff111303),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.info_outline,
                          size: 22.px,
                          color: Color(0xff111303),
                        ),
                      ],
                    ),
                    Text(
                      '\$$walletBalance',
                      style: GoogleFonts.poppins(
                        fontSize: 17.px,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff111303),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'View Transaction Details',
                    style: GoogleFonts.poppins(
                      fontSize: 18.px,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff111303),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18.px,
                    color: Color(0xff111303),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  final isDeposit = transaction['type'] == 'Deposit';
                  final status =
                      transaction['status'] ?? "pending"; // default value

                  // Status badge color logic
                  Color getStatusColor(String status) {
                    switch (status.toLowerCase()) {
                      case "approved":
                        return Colors.green;
                      case "rejected":
                        return Colors.red;
                      case "pending":
                      default:
                        return Colors.orange;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 7.0,
                      horizontal: 4.0,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 5.h,
                            width: 10.w,
                            color:
                                isDeposit
                                    ? Color(0xff85F9BB)
                                    : Color(0xffF0B9B9),
                            child: Icon(
                              isDeposit
                                  ? Icons.south_east
                                  : Icons.arrow_outward_sharp,
                              color:
                                  isDeposit
                                      ? Color(0xff0BCC35)
                                      : Color(0xffEC2F2F),
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction['type'].toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    color: Color(0xff111303),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // Transaction order ID
                                Text(
                                  'Order# ${transaction['id']}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0xff414235),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  ' ${transaction['time']}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Color(0xff414235),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                transaction['amount'],
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  color: isDeposit ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 6),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(
                                    status,
                                  ).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  status[0].toUpperCase() +
                                      status.substring(1), // Capitalize
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: getStatusColor(status),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    'Deposit',
                    Color(0xffD2FF47),
                    () {
                      showDepositBottomSheet(context);
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton(
                    context,
                    'Withdraw',
                    Colors.white,
                    () {
                      showWithdrawBottomSheet(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceDetail(String title, String amount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14.px,
              fontWeight: FontWeight.w600,
              color: Color(0xff111303),
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.poppins(
              fontSize: 17.px,
              fontWeight: FontWeight.w600,
              color: Color(0xff111303),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp), // Circular edges
        ),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 17.px,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

void showDepositBottomSheet(BuildContext context) {
  final TextEditingController amountController = TextEditingController(
    text: "3000",
  );
  final TextEditingController utrController = TextEditingController();
  final String upiId = "q832582179@ybl"; // Static UPI ID
  String? errorMessage;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 4,
                          width: 40,
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      Text(
                        "Deposit Amount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Minimum deposit ₹3000",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 16),

                      /// 🔁 UPI ID
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "UPI ID: $upiId",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: upiId));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("UPI ID copied")),
                              );
                            },
                            icon: Icon(Icons.copy, size: 18),
                            label: Text("Copy"),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      /// 🔴 Error message on top
                      if (errorMessage != null)
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  errorMessage!,
                                  style: TextStyle(color: Colors.red[800]),
                                ),
                              ),
                            ],
                          ),
                        ),

                      /// 💰 Amount Field
                      /// amount 3000 ho kamse kam add kro
                      Text(
                        "Amount",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 6),
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter amount',
                          filled: true,
                          fillColor: Color(0xFFF5F9FD),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      /// 🧾 UTR Number Field
                      Text(
                        "UTR Number",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 6),
                      TextField(
                        controller: utrController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter 12-digit UTR',
                          filled: true,
                          fillColor: Color(0xFFF5F9FD),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      /// 🚀 Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final amount = amountController.text.trim();

                            if (double.tryParse(amount) == null ||
                                double.parse(amount) < 3000) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Amount must be at least 3000"),
                                ),
                              );
                              return;
                            }

                            final utrNumber = utrController.text.trim();

                            setModalState(() => errorMessage = null);

                            if (amount.isEmpty || utrNumber.isEmpty) {
                              setModalState(
                                () =>
                                    errorMessage = "⚠️ Please fill all fields",
                              );
                              return;
                            }

                            if (utrNumber.length != 12 ||
                                int.tryParse(utrNumber) == null) {
                              setModalState(
                                () =>
                                    errorMessage =
                                        "❌ UTR number must be exactly 12 digits",
                              );

                              return;
                            }

                            await submitPayment(context, amount, utrNumber);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffD2FF47),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Deposit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

void showWithdrawBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      final TextEditingController _amountController = TextEditingController(
        text: "30",
      );
      String? errorMessage;

      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 4,
                        width: 40,
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Text(
                      "Withdraw Amount",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text.rich(
                      TextSpan(
                        text: "Note : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Minimum Withdraw \$30",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// 🔴 Error message
                    if (errorMessage != null)
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.red),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                errorMessage!,
                                style: TextStyle(color: Colors.red[800]),
                              ),
                            ),
                          ],
                        ),
                      ),

                    Text(
                      "Amount",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F9FD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '\$30',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final amount = _amountController.text.trim();

                          // 🔄 Clear old error
                          setModalState(() => errorMessage = null);

                          if (amount.isEmpty ||
                              double.tryParse(amount) == null ||
                              double.parse(amount) < 30) {
                            setModalState(
                              () =>
                                  errorMessage =
                                      "⚠️ Please enter minimum \$30 amount",
                            );
                            return;
                          }

                          await submitWithdrawal(context, amount);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffD2FF47),
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Withdraw',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Future<void> submitPayment(
  BuildContext context,
  String amount,
  String utrNumber,
) async {
  //amount 3000 ho kamse kam
  if (double.tryParse(amount) == null || double.parse(amount) < 3000) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("⚠️ Minimum deposit amount is ₹3000.")),
    );
    return;
  }
  try {
    final response = await sendPaymentDetails(amount, utrNumber);

    final responseData = jsonDecode(response.body);
    final message = responseData['message'] ?? 'No message';

    if (response.statusCode == 200 || response.statusCode == 201) {
      // 🟢 Success Snackbar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("✅ $message")));
      Navigator.pop(context); // अब यहाँ close करें

      // Reload full screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      // 🔴 Error Snackbar
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Failed: $message")));
    }
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("⚠️ Error: ${e.toString()}")));
  }
}

Future<void> submitWithdrawal(BuildContext context, String amount) async {
  // 🏦 बैंक विवरण प्राप्त करें
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? account = prefs.getString('bank_account');
  String? ifsc = prefs.getString('bank_ifsc');
  if (account == null || ifsc == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("⚠️ Please set your bank details first.")),
    );
    return;
  }

  try {
    final response = await sendWithdrawalDetails(amount);

    final responseData = jsonDecode(response.body);
    final message = responseData['message'] ?? 'No message';

    if (response.statusCode == 200 || response.statusCode == 201) {
      // 🟢 Success Snackbar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("✅ $message")));
      Navigator.pop(context); // अब यहाँ close करें

      // Reload full screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      // 🔴 Error Snackbar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Failed: $message")));
    }
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("⚠️ Error: ${e.toString()}")));
  }
}
