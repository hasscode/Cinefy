abstract class DeleteAccountState{}
 class DeleteAccountSuccess extends DeleteAccountState{}
 class DeleteAccountLoading extends DeleteAccountState{}
 class DeleteAccountFailure extends DeleteAccountState{
 final String errMessage;
 DeleteAccountFailure(this.errMessage);

 }