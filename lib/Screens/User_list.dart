import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/usermodel.dart';
import 'Login_Screen.dart';
import 'User_detail.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  TextEditingController _searchController = TextEditingController();
  String _selectedHairColor = "Brown";
  List<User> _users = [];
  bool _isLoading = false;

  Future<void> _searchUsers(String query) async {
    setState(() {
      _isLoading = true;
    });
    final response = await http
        .get(Uri.parse('https://dummyjson.com/users/search?q=$query'));

    if (response.statusCode == 200) {
      setState(() {
        _users = (jsonDecode(response.body)['users'] as List)
            .map((data) => User.fromJson(data))
            .toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load users');
    }
  }

  Future<void> _filterUsersByHairColor(String hairColor) async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse(
        'https://dummyjson.com/users/filter?key=hair.color&value=$hairColor'));

    if (response.statusCode == 200) {
      setState(() {
        _users = (jsonDecode(response.body)['users'] as List)
            .map((data) => User.fromJson(data))
            .toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load users');
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _logout();
              });
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Users',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchUsers(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Filter by Hair Color:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 15),
                DropdownButton<String>(
                  value: _selectedHairColor,
                  items: <String>['Brown', 'Black', 'Blonde', 'Red']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedHairColor = newValue!;
                    });
                    _filterUsersByHairColor(_selectedHairColor);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_users.isEmpty)
            Center(child: Text('No users found'))
          else
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return GestureDetector(
                    onTap: () {
                      _showUserDetails(user);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 10, bottom: 10),
                        leading: Hero(
                          tag: 'avatar-${user.id}',
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(user.image),
                            backgroundColor: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          '${user.firstName} ${user.lastName}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.phone,
                                    color: Colors.black, size: 16.0),
                                SizedBox(width: 5.0),
                                Text(
                                  user.phone,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Icon(Icons.cake,
                                    color: Colors.black, size: 16.0),
                                SizedBox(width: 5.0),
                                Text(
                                  'Age: ${user.age}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Icon(Icons.person,
                                    color: Colors.black, size: 16.0),
                                SizedBox(width: 5.0),
                                Text(
                                  user.gender,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.0,
                        ),
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

  void _showUserDetails(User user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserDetailScreen(userId: user.id),
      ),
    );
  }
}
