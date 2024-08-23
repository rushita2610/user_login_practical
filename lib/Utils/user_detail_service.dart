import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Userdetailmodel.dart';

Future<Userdetail> fetchUserdetail(int id) async {

  final response = await http.get(Uri.parse('https://dummyjson.com/users/$id'));
  print("Api call ==> ${'https://dummyjson.com/users/$id'}");

  if (response.statusCode == 200) {
    print("Response status code ==> ${response.statusCode}");
    print("Response body ==> ${response.body}");
    return Userdetail.fromJson(json.decode(response.body));
  } else {
    print("Error status code ==> ${response.statusCode}");
    print("Error body ==> ${response.body}");
    throw Exception('Failed to load user');
  }
}
