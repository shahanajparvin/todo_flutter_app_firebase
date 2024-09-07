import 'package:equatable/equatable.dart';

abstract class UserNameEvent extends Equatable {
  const UserNameEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserName extends UserNameEvent {
  final String UserName;

  const UpdateUserName(this.UserName);

  @override
  List<Object?> get props => [UserName];
}
