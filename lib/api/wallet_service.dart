import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alevet_market/api/utils/api_utils.dart';

Future<http.Response> sendPaymentDetails(String amount, String utrNumber) async {
  // 🔐 टोकन प्राप्त करें
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');
  final name = prefs.getString('userName') ?? '';
  if (token == null) {
    throw Exception("User not authenticated.");
  }

  // 🧾 पेमेंट डेटा तैयार करें
  final data = {
    'name': name,
    'amount': amount,
    'payment_method': 'UPI',
    'transaction_id': utrNumber,
  };

  // 📨 POST रिक्वेस्ट भेजें (टोकन के साथ)
  final response = await ApiUtils.post(
    '/user/payment',
    data,
    headers: {'Authorization': 'Bearer $token'},
  );
  // ✅ या ❌ रिस्पॉन्स हैंडल करें
  if (response.statusCode == 200 || response.statusCode == 201) {
    print("✅ Payment details sent successfully:  ${response.statusCode} - ${response.body}");

  } else {
    print(
      "❌ Failed to send payment details: ${response.statusCode} - ${response.body}",
    );
  }

  return response;
}



Future<http.Response> sendWithdrawalDetails(String amount) async {
  // 🔐 टोकन प्राप्त करें
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');
  final name = prefs.getString('userName') ?? '';

  // 🏦 बैंक विवरण प्राप्त करे
  //     await prefs.setString('bank_account', account);
    // await prefs.setString('bank_ifsc', ifsc);
    // await prefs.setString('bank_account_type', accountType);
  // 🏦 बैंक विवरण प्राप्त करें
  final ifscCode = prefs.getString('bank_ifsc') ?? '';
  final accountNumber = prefs.getString('bank_account') ?? '';
  // final accountType = prefs.getString('bank_account_type') ?? '';

  if (token == null) {
    throw Exception("User not authenticated.");
  }

  // 🧾 पेमेंट डेटा तैयार करें
  final data = {
    'name': name, 
    'amount': amount,
    'ifsc_code': ifscCode,
    'account_number': accountNumber,
  };

  // 📨 POST रिक्वेस्ट भेजें (टोकन के साथ)
  final response = await ApiUtils.post(
    '/user/withdrawal',
    data,
    headers: {'Authorization': 'Bearer $token'},
  );
  // ✅ या ❌ रिस्पॉन्स हैंडल करें
  if (response.statusCode == 200 || response.statusCode == 201) {
    print("✅ Payment details sent successfully:  ${response.statusCode} - ${response.body}");

  } else {
    print(
      "❌ Failed to send payment details: ${response.statusCode} - ${response.body}",
    );
  }

  return response;
}

Future<http.Response> getTransactionHistory() async {
  // 🔐 टोकन प्राप्त करें
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');
  if (token == null) {
    throw Exception("User not authenticated.");
  }

  // 📨 GET रिक्वेस्ट भेजें (टोकन के साथ)
  final response = await ApiUtils.get(
    '/user/transaction-history',
    headers: {'Authorization': 'Bearer $token'},
  );

  // ✅ या ❌ रिस्पॉन्स हैंडल करें
  if (response.statusCode == 200) {
    print("✅ Transaction history retrieved successfully: ${response.statusCode} - ${response.body}");
  } else {
    print(
      "❌ Failed to retrieve transaction history: ${response.statusCode} - ${response.body}",
    );
  }

  return response;
}

