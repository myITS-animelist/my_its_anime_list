import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/sign_up_entity.dart';
import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class SignUpUseCase {
  final AuthenticationRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, UserCredential>> call(SignUpEntity signup) async {
    return await repository.signUp(signup);
  }
}
