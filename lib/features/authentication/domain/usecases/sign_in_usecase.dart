import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/sign_in_entity.dart';
import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class SignInUseCase {
  final AuthenticationRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, UserCredential>> call(SignInEntity signIn) async {
    return await repository.signIn(signIn);
  }
}
