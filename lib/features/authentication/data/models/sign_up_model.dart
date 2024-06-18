import '../../domain/entities/sign_up_entity.dart';

class SignUpModel extends SignUpEntity {
  const SignUpModel({
    required String id,
    required String name,
    required String email,
    required String password,
    required String repeatedPassword,
    String profileImageUrl = '',
    String role = 'user',
    String bio = 'The user hasn\'t set any bio yet',
  }) : super(
          id: id,
          name: name,
          email: email,
          password: password,
          repeatedPassword: repeatedPassword,
          profileImageUrl: profileImageUrl,
          role: role,
          bio: bio,
        );

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      repeatedPassword: json['repeatedPassword'],
      profileImageUrl: json['profileImageUrl'] ?? '',
      role: json['role'] ?? 'user',
      bio: json['bio'] ?? 'The user hasn\'t set any bio yet',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'repeatedPassword': repeatedPassword,
      'profileImageUrl': profileImageUrl,
      'role': role,
      'bio': bio,
    };
  }
}
