import 'package:equatable/equatable.dart';

class UserNameState extends Equatable {
  final String userName;

  const UserNameState({required this.userName});

  factory UserNameState.initial() {
    return const UserNameState(userName: '');
  }

  UserNameState copyWith({String? userName}) {
    return UserNameState(userName: userName ?? this.userName);
  }

  @override
  List<Object?> get props => [userName];
}
