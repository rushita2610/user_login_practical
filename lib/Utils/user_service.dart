import 'dart:convert';
import 'package:helmsman_practical/Utils/usermodel.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String _url = 'https://dummyjson.com/users';

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(_url));
    print("Api call ==> $_url");
    if (response.statusCode == 200) {
      print("Response statuscode ==> ${response.statusCode}");
      var decode = jsonDecode(response.body);
      print("Response body decode ==> ${response.body}");
      final List users = decode['users'];
      return users.map((user) => User.fromJson(user)).toList();
    } else {
      print("Error Response statuscode ==> ${response.statusCode}");
      print("Error Response body ==> ${response.body}");
      throw Exception('Failed to load users');
    }
  }
}
