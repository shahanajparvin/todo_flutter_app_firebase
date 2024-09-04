import 'package:bloc/bloc.dart';
import '../../../domain/entities/language.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  Language? currentLanguage;

  LanguageBloc(this.currentLanguage)
      : super(LanguageState(selectedLanguage: currentLanguage)) {
    on<ChangeLanguage>(onChangeLanguage);
  }

  onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) {
    print('----------cxvxvxc '+ event.selectedLanguage.toString());
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }
}
