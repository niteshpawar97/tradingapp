import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alevet_market/api/utils/api_utils.dart';

Future<http.Response> planBuy() async {
  // 🔐 टोकन प्राप्त करें
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');
  // final name = prefs.getString('userName') ?? '';
  if (token == null) {
    throw Exception("User not authenticated.");
  }

  // 🧾 पेमेंट डेटा तैयार करें
  final data = {
    'plan_id': '3',
  };

  // 📨 POST रिक्वेस्ट भेजें (टोकन के साथ)
  final response = await ApiUtils.post(
    '/user/plan-buy',
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
