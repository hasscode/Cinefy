import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  String email;
  String uID;
  String username;

  UserEntity({required this.email,  required this.uID,required this.username});

  @override
  // TODO: implement props
  List<Object?> get props => [email,uID,username];

}