import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/models/user.dart';
import 'package:taxi/models/order.dart';

class UserRepo {
  static const String apiUrl = 'https://volunteertaxiapp.herokuapp.com';

  Future<bool> register(User user) async {
    final uri = Uri.parse('$apiUrl/register');
    final http.Response response;
    try {
      response = await http.post(
        uri,
        body: user.toJson(),
      );
      if (response.statusCode != 200) {
        return false;
      }
    } catch (e) {
      return false;
    }
    // print('${response.statusCode}  ::::  ${response.body}');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', jsonDecode(response.body)['user_token']);
    return true;
  }

  Future<bool> login(User user) async {
    final uri = Uri.parse('$apiUrl/login');
    final http.Response response;
    try {
      response = await http.post(
        uri,
        body: user.toJson(),
      );
      if (response.statusCode != 200) {
        return false;
      }
    } catch (e) {
      return false;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', jsonDecode(response.body)['user_token']);
    return true;
  }

// List<Order> getUsersOrders() {
//   try {
//
//   } catch {
//
//   }
// }
}
