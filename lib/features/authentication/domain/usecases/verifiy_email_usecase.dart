import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class VerifyEmailUseCase {
  final AuthenticationRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.verifyEmail();
  }
}
