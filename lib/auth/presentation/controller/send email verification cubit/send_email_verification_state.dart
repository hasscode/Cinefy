abstract class SendEmailVerificationState{}
 class SendEmailVerificationSuccess extends SendEmailVerificationState{}
 class SendEmailVerificationLoading extends SendEmailVerificationState{}
 class SendEmailVerificationFailure extends SendEmailVerificationState{
 final String errMessage;
 SendEmailVerificationFailure(this.errMessage);

 }
 class SendEmailVerificationInitial extends SendEmailVerificationState{}