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
      character.updateAbility(name: event.ability, value: event.value);
      yield Updated(character: this.character);
    } else if (event is Finish) {
      print("[AddCharacterBloc] - Finish Event Received");
      await charRepo.addCharacter();
      yield Finished();
    }
  }
}
