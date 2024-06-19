import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class LogOutUseCase {
  final AuthenticationRepository repository;

  LogOutUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.logOut();
  }
}
