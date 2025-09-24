abstract class CheckEmailVerificationState{}
class EmailVerified extends CheckEmailVerificationState {

}
class EmailNotVerified extends CheckEmailVerificationState {

}
class FailureState extends CheckEmailVerificationState{
  final String errMessage;
  FailureState(this.errMessage);

}
class LoadingState extends CheckEmailVerificationState{}
class InitialState extends CheckEmailVerificationState{}