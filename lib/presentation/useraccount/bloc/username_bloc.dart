// UserName_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/useraccount/bloc/username_event.dart';
import 'package:todo_app/presentation/useraccount/bloc/username_state.dart';

export 'username_event.dart';
export 'username_state.dart';


class UserNameBloc extends Bloc<UserNameEvent, UserNameState> {
  UserNameBloc() : super(UserNameState.initial()) {
    on<UpdateUserName>(_onUpdateUserName);
  }

  void _onUpdateUserName(
      UpdateUserName event, Emitter<UserNameState> emit) {
    emit(state.copyWith(userName: event.UserName));
  }
}
