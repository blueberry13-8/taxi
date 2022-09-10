import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api_User{
  static const String api_url = '';

  Future<bool> getToken(User user) async {
    final response;
    try{
      response = await http.post('$api_url/register',);
      if (response.statusCode != 200){
        return false;
      }
    }catch(e){
      return false;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.body);
    return true;
  }

  List<Order> getUsersOrders(){
    try{

    }catch{

    }
  }
}