import 'package:dnd/blocs/add_character/event.dart';
import 'package:dnd/blocs/add_character/state.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterAddBloc extends Bloc<CharacterAddEvent, CharacterAddState> {
  final Character char = Character();
  final CharacterRepository charRepo;
  CharacterAddBloc({this.charRepo});

  @override
  CharacterAddState get initialState => Initial(character: this.char);

  @override
  Stream<CharacterAddState> mapEventToState(CharacterAddEvent event) async* {
    if (event is Update) {
      char.updateAbility(name: event.ability, value: event.value);
      yield Updated(character: this.char);
    } else if (event is Finish) {
      await charRepo.addCharacter();
      yield Finished();
    }
  }
}
