class UserEntity {
  final String name;
  final String role;
  final String email;
  final String address;

  UserEntity({
    required this.name,
    required this.role,
    required this.email,
    required this.address,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      name: json['name'],
      role: json['role'],
      email: json['email'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'email': email,
      'address': address,
    };
  }
}
