import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {
  final String name;
  final String email;
  final String password;
  final String repeatedPassword;
  final String profileImageUrl;

  const SignUpEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.repeatedPassword,
    this.profileImageUrl = '',
  });

  @override
  List<Object?> get props => [name, email, password, repeatedPassword, profileImageUrl];
}