import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './utils/api_utils.dart'; // हेल्पर फ़ाइल को इम्पोर्ट करें

class HomeService {
  // 💰 वॉलेट डेटा लाने के लिए
  Future<Map<String, dynamic>> getWalletData() async {
    try {
      // SharedPreferences से ऑथेंटिकेशन टोकन प्राप्त करें
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      // अगर टोकन नहीं है, तो यूज़र लॉग इन नहीं है
      if (token == null) {
        return {'success': false, 'message': 'User not authenticated.'};
      }

      // ApiUtils का उपयोग करके GET रिक्वेस्ट भेजें
      final response = await ApiUtils.get("/user/wallet", headers: {'Authorization': 'Bearer $token'});

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // अगर डेटा सफलतापूर्वक मिलता है
        return {
          'success': true,
          'data': data,
        };
      } else {
        // अगर सर्वर से कोई एरर आता है
        return {'success': false, 'message': data['message'] ?? 'Failed to load wallet data.'};
      }
    } catch (e) {
      // नेटवर्क या अन्य कोई एरर
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // आप भविष्य में होम स्क्रीन से संबंधित अन्य API कॉल्स यहाँ जोड़ सकते हैं
  // जैसे: getMarketData(), getTrendingStocks() आदि।
}