

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String age;
  final String phone;
  final String gender;
  final String image;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.phone,
    required this.gender,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'].toString(),
      phone: json['phone'],
      gender: json['gender'],
      image: json['image'],
    );
  }
}
