import 'package:equatable/equatable.dart';
import '../../../domain/entities/language.dart';

class LanguageState extends Equatable {
  const LanguageState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.english;

  final Language selectedLanguage;

  @override
  List<Object> get props => [selectedLanguage];

  LanguageState copyWith({Language? selectedLanguage}) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
