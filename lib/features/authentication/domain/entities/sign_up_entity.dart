import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String repeatedPassword;
  final String profileImageUrl;
  final String role;

  const SignUpEntity({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.repeatedPassword,
    this.profileImageUrl = '',
    this.role = 'user',
  });

  @override
  List<Object?> get props => [id, name, email, password, repeatedPassword, profileImageUrl, role];
}