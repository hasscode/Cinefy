import 'package:movie_app/auth/domain/entities/user_entity.dart';

abstract class SignUpState{}
class SignUpInitial extends SignUpState{}
class SignUpLoading extends SignUpState{}
class SignUpSuccess extends SignUpState{
  final UserEntity  user;

  SignUpSuccess(this.user);
}
class SignUpFailure extends SignUpState{
  final String errMessage;

  SignUpFailure(this.errMessage);

}