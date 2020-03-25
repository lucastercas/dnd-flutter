import 'package:dnd/blocs/add_character/event.dart';
import 'package:dnd/blocs/add_character/state.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCharacterBloc extends Bloc<AddCharacterEvent, AddCharacterState> {
  final Character character = Character();
  final CharacterRepository charRepo;

  AddCharacterBloc({this.charRepo});

  @override
  AddCharacterState get initialState => Initial(character: this.character);

  @override
  Stream<AddCharacterState> mapEventToState(AddCharacterEvent event) async* {
    if (event is Update) {
      if (event.key == 'ability') {
        Map<String, int> ability = event.value;
        String key = ability.keys.elementAt(0);
        character.updateAbility(name: key, value: ability[key]);
      } else if (event.key == 'avatar') {
        character.avatar = event.value;
      }
      yield Updated(character: this.character);
    } else if (event is Finish) {
      await charRepo.addCharacter(character: this.character);
      yield Finished();
    }
  }
}
