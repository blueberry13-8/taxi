import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/log/logger.dart';
import 'package:taxi/models/order.dart';
import 'package:taxi/models/user.dart';

class UserRepo {
  static const String apiUrl = 'https://volunteertaxiapp.herokuapp.com';

  Future<bool> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token')!;
  }

  Future<bool> register(User user) async {
    final uri = Uri.parse('$apiUrl/register');
    final http.Response response;
    try {
      logger.info(jsonEncode(user.toJson()));
      response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode != 200) {
        return false;
      }
    } catch (e, stack) {
      logger.severe(e, stack);
      return false;
    }
    logger.info('Registration completed: ${response.body}');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', jsonDecode(response.body)['user_token']);
    logger.info(
        'Token from SERVER ${jsonDecode(response.body)['user_token']}\nToken from PREFS ${prefs.getString('token')}');
    await prefs.setString(
      'role',
      user.role.name,
    );
    return true;
  }

  Future<bool> login(User user) async {
    final uri = Uri.parse('$apiUrl/login');
    final http.Response response;
    try {
      response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode != 200) {
        return false;
      }
    } catch (e) {
      return false;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', jsonDecode(response.body)['user_token']);
    await prefs.setString(
      'role',
      user.role.name,
    );
    return true;
  }

  Future<bool> addOrder(Order order) async {
    final uri = Uri.parse('$apiUrl/add_order');
    final http.Response response;
    final token = await _getToken();
    //final body
    try {
      response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'order': jsonEncode(order.toJson()), 'token': token}),
      );
      if (response.statusCode != 200) {
        return false;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<List<Order>> getOrders() async {
    final uri = Uri.parse('$apiUrl/get_orders');
    final http.Response response;
    final token = await _getToken();
    try {
      response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );
      if (response.statusCode != 200) {
        return [];
      }
    } catch (e) {
      return [];
    }
    logger.info(response.body);
    return List<Order>.from(
        jsonDecode(response.body)['orders'].map((x) => Order.fromJson(x)));
  }

  Future<User> getUserByToken() async {
    final uri = Uri.parse('$apiUrl/get_user');
    final http.Response response;
    final token = await _getToken();
    try {
      response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );
      if (response.statusCode != 200) {
        throw Exception(
            'Cannot get user from server. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Cannot get user from server. Post request did not work');
    }
    return User.fromJson(jsonDecode(response.body));
  }

// Future<List<Order>> getUserOrders() async {
//   User user = await getUserByToken();
//   //return user.orders;
// }

}
