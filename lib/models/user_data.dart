class UserData {
  String? name;
  late String email;
  String? imageUrl;

  UserData({
    required this.name,
    required this.email,
    this.imageUrl,
  });

  Map<String, String> toMap() {
    return {
      'name': name ?? '',
      'imageUrl': imageUrl ?? '',
      'email': email,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'],
      email: map['email'],
      imageUrl: map['imageUrl'],
    );
  }
}
