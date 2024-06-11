import '../../domain/entities/sign_up_entity.dart';

class SignUpModel extends SignUpEntity {
  const SignUpModel({
    required String name,
    required String email,
    required String password,
    required String repeatedPassword,
    String profileImageUrl = '',
  }) : super(
          name: name,
          email: email,
          password: password,
          repeatedPassword: repeatedPassword,
          profileImageUrl: profileImageUrl,
        );

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      repeatedPassword: json['repeatedPassword'],
      profileImageUrl: json['profileImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'repeatedPassword': repeatedPassword,
      'profileImageUrl': profileImageUrl,
    };
  }
}
