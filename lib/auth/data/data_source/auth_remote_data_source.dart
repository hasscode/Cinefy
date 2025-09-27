import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error handling/failures.dart';
import '../models/user_model.dart';

abstract class AuthBaseDataSource{
  Future<Either<Failures,UserModel>>createAccount(String email,String password,String username);
  Future<Either<Failures,UserModel>>login(String email,String password);
  Future<Either<Failures,Unit>>resetPassword(String email);
  Future<Either<Failures,Unit>>logout();
  Future<Either<Failures,Unit>>sendEmailVerification();
  Future<Either<Failures,bool>>checkVerification();
  Future<Either<Failures,UserModel>>checkLogged();
  Future<Either<Failures,Unit>>deleteAccount();
  Future<Either<Failures,Unit>>addAccountToUsersCollections(String email,String username,String uid);

}

class AuthDataSource implements AuthBaseDataSource{
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
  AuthDataSource(this.firebaseAuth);
  final FirebaseAuth firebaseAuth ;
  @override
  Future<Either<Failures,UserModel>> createAccount(String email, String password,String username) async {
 try {
   final result =  await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
   await result.user!.updateDisplayName(username);
   await result.user!.reload();
   final updatedUser = firebaseAuth.currentUser!;
   await sendEmailVerification() ;
   await addAccountToUsersCollections(email, username, updatedUser.uid);
   return right(UserModel.fromFirebaseUser(updatedUser));
 } on FirebaseAuthException catch (e) {
     return left(ServerFailure.fromFirebaseAuth(e));
 }

  }

  @override
  Future<Either<Failures,Unit>> resetPassword(String email) async{
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuth(e));
    }
  }

  @override
  Future<Either<Failures,UserModel>> login(String email, String password) async{
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return right(UserModel.fromFirebaseUser(result.user!));
    }  on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuth(e));
    }

  }

  @override
  Future<Either<Failures,Unit>> logout() async{
   try {
     final result = await firebaseAuth.signOut();
     return right(unit);
   } on FirebaseAuthException catch (e) {
     return left(ServerFailure.fromFirebaseAuth(e));
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
        return left(ServerFailure('No user logged in'));
      }
    } on FirebaseAuthException catch (e){
      return left(ServerFailure.fromFirebaseAuth(e));
    }
  }
  @override
  Future<Either<Failures,Unit>> sendEmailVerification() async{
    try {
      final result = await firebaseAuth.currentUser!.sendEmailVerification();
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuth(e));
    }
  }

  @override
  Future<Either<Failures, bool>> checkVerification() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        return left(ServerFailure("No user logged in"));
      }

      await user.reload();
      final result = user.emailVerified;
      return right(result);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuth(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Unit>> deleteAccount() async{
    try {
      final result = await firebaseAuth.currentUser!.delete();
        return right(unit);
    } on FirebaseAuthException catch (e) {
     return left(ServerFailure.fromFirebaseAuth(e));
    }
  }

  @override
  Future<Either<Failures, Unit>> addAccountToUsersCollections(String email,String username,String uid) async{
    try {
      final results = await  usersCollection.doc(uid).set({
        'userID':uid,
        'username':username,
        'email':email
      });
      return right(unit);
    } on Exception catch (e) {
      print("Firestore Error: $e");
      return left(ServerFailure(e.toString()));
    }

  }
}