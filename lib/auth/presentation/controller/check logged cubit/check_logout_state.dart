import 'package:equatable/equatable.dart';
import 'package:movie_app/auth/domain/entities/user_entity.dart';


abstract class CheckLoggedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckLoggedInitial extends CheckLoggedState {}

class CheckLoggedLoading extends CheckLoggedState {}

class CheckLoggedAuthenticated extends CheckLoggedState {
  final UserEntity user;
  CheckLoggedAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class CheckLoggedUnauthenticated extends CheckLoggedState {
  final String message;
  CheckLoggedUnauthenticated(this.message);

  @override
  List<Object?> get props => [message];
}