import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/models.dart';

part 'spotify_design_event.dart';
part 'spotify_design_state.dart';
part 'spotify_design_bloc.freezed.dart';

final _initState = SpotifyDesignState();

class SpotifyDesignBloc extends Bloc<SpotifyDesignEvent, SpotifyDesignState> {
  SpotifyDesignBloc() : super(_initState) {
    on<SpotifyDesignEvent>(_onEvent);
  }

  Future<void> _onEvent(SpotifyDesignEvent event, Emitter<SpotifyDesignState> emit) async {
    await event.when(
      initData: (data) {
        emit(state.copyWith(activeDesign: data ?? KeychainDesignData.init()));
      },
      updateData: (data) {
        emit(state.copyWith(activeDesign: data));
      },
      close: () {
        emit(_initState);
      },
    );
  }
}
