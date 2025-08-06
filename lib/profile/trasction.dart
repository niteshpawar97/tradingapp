import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TransactionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {
      'type': 'Deposit',
      'transactionId': 'TRN 000000000000',
      'time': '5:13 PM',
      'amount': '\$20.00',
    },
    {
      'type': 'Withdraw',
      'transactionId': 'TRN 000000000000',
      'time': '5:13 PM',
      'amount': '\$20.00',
    },
    {
      'type': 'Deposit',
      'transactionId': 'TRN 000000000000',
      'time': '5:13 PM',
      'amount': '\$20.00',
    },
    {
      'type': 'Deposit',
      'transactionId': 'TRN 000000000000',
      'time': '5:13 PM',
      'amount': '\$20.00',
    },
    {
      'type': 'Withdraw',
      'transactionId': 'TRN 000000000000',
      'time': '5:13 PM',
      'amount': '\$20.00',
    },
    {
      'type': 'Deposit',
      'transactionId': 'TRN 000000000000',
      'time': '5:13 PM',
      'amount': '\$20.00',
    },
  ];

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
          'Transaction',
          style: TextStyle(
            color: Color(0xff111303),
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Transaction",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final isDeposit = transaction['type'] == 'Deposit';
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 7.0,
                    horizontal: 16.0,
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
                              isDeposit ? Color(0xff85F9BB) : Color(0xffF0B9B9),

                          child: Icon(
                            isDeposit
                                ? Icons.south_east
                                : Icons.arrow_outward_sharp,
                            color: isDeposit ? Color(0xff0BCC35) : Color(0xffEC2F2F),
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
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Color(0xff111303),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${transaction['transactionId']} | ${transaction['time']}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Color(0xff414235),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          transaction['amount'],
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: isDeposit ? Colors.green : Colors.red,

                            fontWeight: FontWeight.w900,
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
    );
  }
}
