import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.uID, required super.username});

factory UserModel.fromFirebaseUser(User userCredential){
  return UserModel(
    uID: userCredential!.uid,
    email: userCredential!.email!,
    username: userCredential!.displayName! ??'nousername'
  );
}
}