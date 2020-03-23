import 'dart:async';

import 'package:dnd/blocs/list_character/event.dart';
import 'package:dnd/blocs/list_character/state.dart';
import 'package:dnd/blocs/repository.dart';
import 'package:dnd/models/char.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterListingBloc
    extends Bloc<CharacterListingEvent, ListCharacterState> {
  final CharacterRepository charRepo;
  StreamSubscription subscription;

  CharacterListingBloc({this.charRepo}) : assert(charRepo != null);

  @override
  ListCharacterState get initialState => Initial();

  @override
  Stream<ListCharacterState> mapEventToState(
    CharacterListingEvent event,
  ) async* {
    if (event is StartFetchEvent) {
      subscription?.cancel();
      subscription = charRepo.getCharacters().listen(
        (List<Character> characters) {
          add(FetchedEvent(characters: characters));
        },
      );
    } else if (event is FetchedEvent) {
      yield Update(characters: event.characters);
    }
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
