import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error handling/failures.dart';
import '../models/user_model.dart';

abstract class AuthBaseDataSource{
  Future<Either<Failures,UserModel>>createAccount(String email,String password,String username);
  Future<Either<Failures,UserModel>>login(String email,String password);
  Future<Either<Failures,Unit>>resetPassword(String email);
  Future<Either<Failures,Unit>>logout();
  Future<Either<Failures,UserModel>>checkLogged();
}

class AuthDataSource implements AuthBaseDataSource{
  AuthDataSource(this.firebaseAuth);
  final FirebaseAuth firebaseAuth ;
  @override
  Future<Either<Failures,UserModel>> createAccount(String email, String password,String username) async {
 try {
   final result =  await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
   await result.user!.updateDisplayName(username);
   await result.user!.reload();
   final updatedUser = firebaseAuth.currentUser!;
   return right(UserModel.fromFirebaseUser(updatedUser));
 } on FirebaseAuthException catch (e) {
     return Left(ServerFailure.fromFirebaseAuth(e));
 }

  }

  @override
  Future<Either<Failures,Unit>> resetPassword(String email) async{
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuth(e));
    }
  }

  @override
  Future<Either<Failures,UserModel>> login(String email, String password) async{
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return right(UserModel.fromFirebaseUser(result.user!));
    }  on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuth(e));
    }

  }

  @override
  Future<Either<Failures,Unit>> logout() async{
   try {
     final result = await firebaseAuth.signOut();
     return right(unit);
   } on FirebaseAuthException catch (e) {
     return Left(ServerFailure.fromFirebaseAuth(e));
   }
  }

  @override
  Future<Either<Failures, UserModel>> checkLogged() async{
    try {
      await firebaseAuth.currentUser?.reload();
      final user = firebaseAuth.currentUser;

      if (user != null) {
        return right(UserModel.fromFirebaseUser(user));
      } else {
        return Left(ServerFailure('No user logged in'));
      }
    } on FirebaseAuthException catch (e){
      return Left(ServerFailure.fromFirebaseAuth(e));
    }
  }
}