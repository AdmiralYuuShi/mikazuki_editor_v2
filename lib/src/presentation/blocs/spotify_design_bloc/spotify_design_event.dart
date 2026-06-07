part of 'spotify_design_bloc.dart';

@freezed
sealed class SpotifyDesignEvent with _$SpotifyDesignEvent {
  const factory SpotifyDesignEvent.initData({KeychainDesignData? data}) = _InitData;
  const factory SpotifyDesignEvent.updateData({required KeychainDesignData data}) = _UpdateData;
  const factory SpotifyDesignEvent.close() = _Close;
}
