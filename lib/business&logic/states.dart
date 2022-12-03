abstract class NewStates{}

class IntiState extends NewStates{}

class GetAllUserSuccess extends NewStates{}
class GetAllUserFailed extends NewStates{
  final String error ;
  GetAllUserFailed(this.error);
}

class InsertDataSuccess extends NewStates{}
class DeleteNote extends NewStates {}


class UpdateNote extends NewStates {}
