import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class BankDetailsScreen extends StatefulWidget {
  @override
  _BankDetailsScreenState createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  String accountType = "Savings"; // Default selection

  bool isEditMode = true; // by default form is shown
  String savedAccount = "";
  String savedIfsc = "";
  String savedAccountType = "";

  @override
  void initState() {
    super.initState();
    _loadBankDetails();
  }

  Future<void> _loadBankDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedAccount = prefs.getString('bank_account') ?? '';
      savedIfsc = prefs.getString('bank_ifsc') ?? '';
      savedAccountType = prefs.getString('bank_account_type') ?? '';
      if(savedAccount.isNotEmpty && savedIfsc.isNotEmpty && savedAccountType.isNotEmpty){
        isEditMode = false; // show details card
      }
      // Also update form controllers in case of editing
      accountController.text = savedAccount;
      ifscController.text = savedIfsc;
      accountType = savedAccountType.isNotEmpty ? savedAccountType : "Savings";
    });
  }

  Future<void> _saveBankDetails() async {
    final account = accountController.text.trim();
    final ifsc = ifscController.text.trim();
    if (account.isEmpty || ifsc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bank_account', account);
    await prefs.setString('bank_ifsc', ifsc);
    await prefs.setString('bank_account_type', accountType);
    setState(() {
      savedAccount = account;
      savedIfsc = ifsc;
      savedAccountType = accountType;
      isEditMode = false; // switch to show mode
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bank details saved!')),
    );
  }

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
        title: Text(
          'Bank Details',
          style: GoogleFonts.poppins(
              color: Color(0xff111303),
              fontSize: 18.px,
              fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, size: 24.px, color: Color(0xff111303)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: isEditMode ? _buildForm() : _buildDetailsCard(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20.h,
          color: Colors.white,
          width: double.infinity,
          child: Image.asset("assets/bank.png"),
        ),
        SizedBox(height: 1.h),
        Text(
          'Verify Bank Details',
          style:  GoogleFonts.poppins(fontSize: 17.px, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1.h),
        _buildTextField('Account Number', accountController),
        SizedBox(height: 16),
        _buildTextField('IFSC Code', ifscController),
        SizedBox(height: 16),
        Text(
          'Select Account Type',
          style:  GoogleFonts.poppins(fontSize: 15.px, color: Color(0xffACB5BB)),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _buildAccountTypeOption('Savings'),
            SizedBox(width: 16),
            _buildAccountTypeOption('Current'),
          ],
        ),
        SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _saveBankDetails,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffD2FF47),
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

Widget _buildDetailsCard() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 20.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Image.asset("assets/bank.png", height: 13.h),
        ),
      ),
      SizedBox(height: 2.h),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailRow(Icons.account_balance, "Account Number", savedAccount),
            Divider(height: 28, thickness: 0.8),
            _detailRow(Icons.code, "IFSC Code", savedIfsc),
            Divider(height: 28, thickness: 0.8),
            _detailRow(Icons.account_box, "Account Type", savedAccountType),
          ],
        ),
      ),
      SizedBox(height: 24),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: Icon(Icons.edit, color: Colors.black),
          label: Text(
            'Edit',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffD2FF47),
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            setState(() {
              isEditMode = true;
            });
          },
        ),
      ),
    ],
  );
}

Widget _detailRow(IconData icon, String label, String value) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xffF1F4F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Color(0xffBFE841), size: 22),
      ),
      SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.poppins(
                  color: Color(0xffACB5BB),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                )),
            Text(value,
                style: GoogleFonts.poppins(
                  color: Color(0xff111303),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                )),
          ],
        ),
      ),
    ],
  );
}



  /// **Reusable Widget for Bank Verification Card**
  // Widget _buildVerificationCard(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.all(16.0),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.2),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Text(
  //               'Please verify your account',
  //               style:  GoogleFonts.poppins(
  //                   color: Color(0xff111303),
  //                   fontSize: 17.px,
  //                   fontWeight: FontWeight.w900),
  //             ),
  //             SizedBox(width: 2.w),
  //             Icon(
  //               Icons.check_circle,
  //               color: Colors.green,
  //               size: 20.px,
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 1.h),
  //         Text(
  //           'To ensure the security of your account and protect against fraud, we require you to complete our identity verification process',
  //           style:  GoogleFonts.poppins(
  //               color: Color(0xff887E7E),
  //               fontSize: 14.px,
  //               fontWeight: FontWeight.w400),
  //         ),
  //         SizedBox(height: 1.h),
  //         SizedBox(
  //           width: 40.w,
  //           child: ElevatedButton(
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => VerificationScreen()),
  //               );
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Color(0xffD2FF47),
  //               foregroundColor: Colors.black,
  //               minimumSize: Size(double.infinity, 40),
  //             ),
  //             child: Text(
  //               'Get Verified',
  //               style:  GoogleFonts.poppins(fontSize: 16.px,fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  
  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  GoogleFonts.poppins(fontSize: 15.px, color: Color(0xffACB5BB)),
        ),
        SizedBox(height: 0.8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            style:  GoogleFonts.poppins(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Enter $label',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountTypeOption(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          accountType = title;
        });
      },
      child: Row(
        children: [
          Radio(
            value: title,
            groupValue: accountType,
            onChanged: (value) {
              setState(() {
                accountType = value.toString();
              });
            },
            activeColor: Color(0xffBFE841),
          ),
          Text(
            title,
            style:  GoogleFonts.poppins(fontSize: 16.px),
          ),
        ],
      ),
    );
  }
}