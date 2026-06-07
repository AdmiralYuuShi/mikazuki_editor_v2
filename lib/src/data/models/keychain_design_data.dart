import 'package:flutter/material.dart';

class KeychainDesignData {
  final String spotifyUrl;
  final String youtubeUrl;
  final String spotifyBarcodeUrl;
  final String coverUrl;
  final String title;
  final String album;
  final String artist;
  final DateTime createdAt;
  final double titleFontSize;
  final double artistFontSize;
  final double verticalPosition;
  final Color? dominantColor;
  final Color? textColor;
  final bool spotifyBarcodeBlack;

  final TextEditingController spotifyUrlController;
  final TextEditingController coverUrlController;
  final TextEditingController titleController;
  final TextEditingController artistController;

  KeychainDesignData({
    required this.spotifyUrl,
    required this.youtubeUrl,
    required this.spotifyBarcodeUrl,
    required this.coverUrl,
    required this.title,
    required this.album,
    required this.artist,
    required this.createdAt,
    required this.titleFontSize,
    required this.artistFontSize,
    required this.verticalPosition,
    this.dominantColor,
    this.textColor,
    required this.spotifyBarcodeBlack,
    required this.spotifyUrlController,
    required this.coverUrlController,
    required this.titleController,
    required this.artistController,
  });

  KeychainDesignData copyWith({
    String? spotifyUrl,
    String? youtubeUrl,
    String? spotifyBarcodeUrl,
    String? coverUrl,
    String? title,
    String? album,
    String? artist,
    DateTime? createdAt,
    double? titleFontSize,
    double? artistFontSize,
    double? verticalPosition,
    Color? dominantColor,
    Color? textColor,
    bool? spotifyBarcodeBlack,
    TextEditingController? spotifyUrlController,
    TextEditingController? coverUrlController,
    TextEditingController? titleController,
    TextEditingController? artistController,
  }) {
    return KeychainDesignData(
      spotifyUrl: spotifyUrl ?? this.spotifyUrl,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      spotifyBarcodeUrl: spotifyBarcodeUrl ?? this.spotifyBarcodeUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      title: title ?? this.title,
      album: album ?? this.album,
      artist: artist ?? this.artist,
      createdAt: createdAt ?? this.createdAt,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      artistFontSize: artistFontSize ?? this.artistFontSize,
      verticalPosition: verticalPosition ?? this.verticalPosition,
      dominantColor: dominantColor ?? this.dominantColor,
      textColor: textColor ?? this.textColor,
      spotifyBarcodeBlack: spotifyBarcodeBlack ?? this.spotifyBarcodeBlack,
      spotifyUrlController: spotifyUrlController ?? this.spotifyUrlController,
      coverUrlController: coverUrlController ?? this.coverUrlController,
      titleController: titleController ?? this.titleController,
      artistController: artistController ?? this.artistController,
    );
  }

  static KeychainDesignData init() => KeychainDesignData(
    spotifyUrl: '',
    youtubeUrl: '',
    spotifyBarcodeUrl: '',
    coverUrl: '',
    title: '',
    album: '',
    artist: '',
    createdAt: DateTime.now(),
    titleFontSize: .5,
    artistFontSize: .4,
    verticalPosition: .5,
    spotifyBarcodeBlack: true,
    spotifyUrlController: TextEditingController(),
    coverUrlController: TextEditingController(),
    titleController: TextEditingController(),
    artistController: TextEditingController(),
  );
}
