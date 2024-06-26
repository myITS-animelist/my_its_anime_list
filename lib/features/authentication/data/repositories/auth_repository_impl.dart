import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/sign_in_model.dart';
import '../models/sign_up_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/sign_in_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/first_page_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';


class AuthenticationRepositoryImp implements AuthenticationRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;
  AuthenticationRepositoryImp(
      {required this.networkInfo, required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserCredential>> signIn(SignInEntity signIn) async {
    if (await networkInfo.isConnected) {
      try {
        final signInModel =
            SignInModel(email: signIn.email, password: signIn.password);
        final userCredential = await authRemoteDataSource.signIn(signInModel);



        return Right(userCredential);
      } on ExistedAccountException {
        return Left(ExistedAccountFailure());
      } on WrongPasswordException {
        return Left(WrongPasswordFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(SignUpEntity signUp) async {
    var uuid = Uuid();
    if (!await networkInfo.isConnected) {
      return Left(OfflineFailure());
    } else if (signUp.password != signUp.repeatedPassword) {
      return Left(UnmatchedPassFailure());
    } else {
      try {
        final signUpModel = SignUpModel(
            id: signUp.id ?? uuid.v4(),
            name: signUp.name,
            email: signUp.email,
            password: signUp.password,
            repeatedPassword: signUp.repeatedPassword,
            role: signUp.role);
        final userCredential = await authRemoteDataSource.signUp(signUpModel);

        if (userCredential.user != null) {
          var uuid = Uuid();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'id': signUp.id ?? uuid.v4(),
            'name': signUp.name,
            'email': signUp.email,
            'profileImageUrl': '',
            'role': signUp.role,
          });
        }

        return Right(userCredential);
      } on WeekPassException {
        return Left(WeekPassFailure());
      } on ExistedAccountException {
        return Left(ExistedAccountFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  FirstPageModel firstPage() {
    final userCredential = FirebaseAuth.instance.currentUser;
    if (userCredential != null && userCredential.emailVerified) {
      return const FirstPageModel(isVerifyingEmail: false, isLoggedIn: true);
    } else if (userCredential != null) {
      return const FirstPageModel(isVerifyingEmail: true, isLoggedIn: false);
    } else {
      return const FirstPageModel(isVerifyingEmail: false, isLoggedIn: false);
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail() async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.verifyEmail();
        return const Right(unit);
      } on TooManyRequestsException {
        return Left(TooManyRequestsFailure());
      } on ServerException {
        return Left(ServerFailure());
      } on NoUserException {
        return Left(NoUserFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<void> waitForVerifiedUser(Completer completer) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        completer.complete();
        timer.cancel();
      }
    });
    await completer.future;
  }

  @override
  Future<Either<Failure, Unit>> checkEmailVerification(
      Completer completer) async {
    try {
      await waitForVerifiedUser(completer).timeout(const Duration(days: 30));
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        GoogleSignIn _googleSignIn = GoogleSignIn();
        await _googleSignIn.signOut();
        await FirebaseAuth.instance.signOut();
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> googleSignIn() async {
    if (!await networkInfo.isConnected) {
      return Left(OfflineFailure());
    } else {
      try {
        final userCredential =
            await authRemoteDataSource.googleAuthentication();

        // fetch user data
        await fetchUser();
        return Right(userCredential);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
   Future<void> fetchUser() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    // setState(() {
    //   user = currentUser;
    //   name = doc['name'];
    //   profileImageUrl = doc['profileImageUrl'];
    // });
  }

}
