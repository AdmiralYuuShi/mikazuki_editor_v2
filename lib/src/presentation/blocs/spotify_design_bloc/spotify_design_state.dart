part of 'spotify_design_bloc.dart';

@freezed
abstract class SpotifyDesignState with _$SpotifyDesignState {
  const factory SpotifyDesignState({KeychainDesignData? activeDesign}) = _SpotifyDesignState;
}
