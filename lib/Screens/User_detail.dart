import 'package:flutter/material.dart';
import 'package:helmsman_practical/Utils/user_detail_service.dart';

import '../Utils/Userdetailmodel.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;

  UserDetailScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: FutureBuilder<Userdetail>(
        future: fetchUserdetail(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.image ?? ''),
                      ),
                    ),
                    SizedBox(height: 20),
                    userDetailRow('Name:', user.name),
                    userDetailRow('Gender:', user.gender),
                    userDetailRow('Email:', user.email),
                    userDetailRow('Phone:', user.phone),
                    userDetailRow('Username:', user.username),
                    userDetailRow('Birthdate:', user.birthDate),
                    userDetailRow('Blood Group:', user.bloodGroup),
                    userDetailRow('Height:', '${user.height ?? 0} cm'),
                    userDetailRow('Weight:', '${user.weight ?? 0} kg'),
                    userDetailRow('Favorite Color:', user.color),
                    userDetailRow('University:', user.university),
                    userDetailRow('Hair Color:', user.hair),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  Widget userDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
