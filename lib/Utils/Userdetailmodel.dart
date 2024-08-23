class Userdetail {
  final String? image;
  final String? name;
  final String? gender;
  final String? email;
  final String? phone;
  final String? username;
  final String? birthDate;
  final String? bloodGroup;
  final double? height;
  final double? weight;
  final String? color;
  final String? university;
  final String? hair;

  Userdetail({
    this.image,
    this.name,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.birthDate,
    this.bloodGroup,
    this.height,
    this.weight,
    this.color,
    this.university,
    this.hair,
  });

  factory Userdetail.fromJson(Map<String, dynamic> json) {
    return Userdetail(
      image: json['image'] ?? 'N/A',  // Provide a default empty string if null
      name: (json['firstName'] ?? 'N/A') + ' ' + (json['lastName'] ?? 'N/A'),
      gender: json['gender'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      phone: json['phone'] ?? 'N/A',
      username: json['Username'] ?? 'N/A',
      birthDate: json['birthDate'] ?? 'N/A',
      bloodGroup: json['bloodGroup'] ?? 'N/A',
      height: (json['height'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      color: json['color'] ?? 'N/A',
      university: json['university'] ?? 'N/A',
      hair: json['hair'] != null ? json['hair']['color'] ?? 'N/A' : 'N/A',
    );
  }
}
