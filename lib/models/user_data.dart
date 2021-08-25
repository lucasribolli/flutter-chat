class UserData {
  final String? name;
  late final String email;

  UserData({
    required this.name,
    required this.email,
  });

  Map<String, String> toMap() {
    return {
      'name': name ?? '',
      'email': email,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'],
      email: map['email'],
    );
  }
}
