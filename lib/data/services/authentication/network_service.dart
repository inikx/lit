import 'package:http/http.dart' as http;
import 'package:lit/constants/storage.dart';
import 'package:lit/constants/strings.dart';

class AuthenticationNetworkService {
  auth() async {
    String? token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$BASE_URL/api/auth'),
      headers: {
        "Content-Type": "application/json",
        "x-access-token": token.toString()
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
