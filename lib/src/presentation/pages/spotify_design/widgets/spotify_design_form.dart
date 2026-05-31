import 'package:flutter/material.dart';
import 'package:mikazuki_editor_v2/src/presentation/pages/spotify_design/spotify_design_page.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../widgets/widgets.dart';

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
    titleFontSize: .0,
    artistFontSize: .0,
    verticalPosition: .0,
    spotifyBarcodeBlack: true,
  );

  @override
  String toString() {
    return '''
spotifyUrl: $spotifyUrl,
youtubeUrl: $youtubeUrl,
spotifyBarcodeUrl: $spotifyBarcodeUrl,
coverUrl: $coverUrl,
title: $title,
album: $album,
artist: $artist,
createdAt: $createdAt,
titleFontSize: $titleFontSize,
artistFontSize: $artistFontSize,
verticalPosition: $verticalPosition,
dominantColor: ${dominantColor?.toSpotifyColor} || $dominantColor,
spotifyBarcodeBlack: $spotifyBarcodeBlack,
textColor: $textColor,
''';
  }
}

class SpotifyDesignForm extends StatefulWidget {
  final KeychainDesignData? initData;
  final Function(KeychainDesignData data) onUpdate;
  const SpotifyDesignForm({super.key, this.initData, required this.onUpdate});

  @override
  State<SpotifyDesignForm> createState() => _SpotifyDesignFormState();
}

class _SpotifyDesignFormState extends State<SpotifyDesignForm> {
  late TextEditingController spotifyUrlController;
  late TextEditingController coverUrlController;
  late TextEditingController titleController;
  late TextEditingController artistController;

  late KeychainDesignData updatedData;

  @override
  void initState() {
    spotifyUrlController = TextEditingController(text: widget.initData?.spotifyUrl);
    coverUrlController = TextEditingController(text: widget.initData?.coverUrl);
    titleController = TextEditingController(text: widget.initData?.title);
    artistController = TextEditingController(text: widget.initData?.artist);

    updatedData = widget.initData ?? KeychainDesignData.init();

    super.initState();
  }

  void _onUpdate() {
    widget.onUpdate(updatedData);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              TextFieldWidget(label: 'Spotify Url', controller: spotifyUrlController),
              SizedBox(height: 16),
              TextFieldWidget(label: 'Image Url', controller: coverUrlController),
              SizedBox(height: 16),
              TextFieldWidget(label: 'Title', controller: titleController),
              SizedBox(height: 16),
              TextFieldWidget(label: 'Artists', controller: artistController),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  label: Text('SET'),
                  icon: Icon(Icons.play_arrow),
                  onPressed: () async {
                    Color? updatedDominantColor = updatedData.dominantColor;

                    if (coverUrlController.text != updatedData.coverUrl || updatedData.dominantColor == null) {
                      updatedDominantColor = await _getColor(coverUrlController.text);
                      print('GET COLOR = $updatedDominantColor');
                    }

                    setState(() {
                      updatedData = updatedData.copyWith(
                        dominantColor: updatedDominantColor,
                        title: titleController.text,
                        coverUrl: coverUrlController.text,
                        spotifyUrl: spotifyUrlController.text,
                        artist: artistController.text,
                      );
                    });
                    _onUpdate();
                  },
                ),
              ),
              SizedBox(height: 16),
              Text('Background Color'),
              SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        updatedData = updatedData.copyWith(dominantColor: Colors.black);
                      });
                      _onUpdate();
                    },
                    icon: Icon(Icons.palette, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        updatedData = updatedData.copyWith(dominantColor: Colors.white);
                      });
                      _onUpdate();
                    },
                    icon: Icon(Icons.palette_outlined, color: Colors.grey),
                  ),
                  SizedBox(width: 8),
                  OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.palette), label: Text('Custom')),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () async {
                      Color? updatedDominantColor = await _getColor(coverUrlController.text);

                      setState(() {
                        updatedData = updatedData.copyWith(dominantColor: updatedDominantColor);
                      });
                      _onUpdate();
                    },
                    icon: Icon(Icons.replay, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Barcode Color'),
              SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        updatedData = updatedData.copyWith(spotifyBarcodeBlack: true);
                      });
                      _onUpdate();
                    },
                    icon: Icon(Icons.palette, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        updatedData = updatedData.copyWith(spotifyBarcodeBlack: false);
                      });
                      _onUpdate();
                    },
                    icon: Icon(Icons.palette_outlined, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Text Color'),
              SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        updatedData = updatedData.copyWith(textColor: Colors.black);
                      });
                      _onUpdate();
                    },
                    icon: Icon(Icons.palette, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        updatedData = updatedData.copyWith(textColor: Colors.white);
                      });
                      _onUpdate();
                    },
                    icon: Icon(Icons.palette_outlined, color: Colors.grey),
                  ),
                  SizedBox(width: 8),
                  OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.palette), label: Text('Custom')),
                ],
              ),
              SizedBox(height: 16),
              SliderWidget(
                label: 'Title Font Size',
                value: updatedData.titleFontSize,
                onChanged: (val) {
                  setState(() {
                    updatedData = updatedData.copyWith(titleFontSize: val);
                  });
                  _onUpdate();
                },
              ),
              SizedBox(height: 16),
              SliderWidget(
                label: 'Artists Font Size',
                value: updatedData.artistFontSize,
                onChanged: (val) {
                  setState(() {
                    updatedData = updatedData.copyWith(artistFontSize: val);
                  });
                  _onUpdate();
                },
              ),
              SizedBox(height: 16),
              SliderWidget(
                label: 'Vertical Position',
                value: updatedData.verticalPosition,
                onChanged: (val) {
                  setState(() {
                    updatedData = updatedData.copyWith(verticalPosition: val);
                  });
                },
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 0,
          child: IconButton(
            onPressed: () {
              _onUpdate();
            },
            icon: Icon(Icons.refresh),
          ),
        ),
      ],
    );
  }

  Future<Color?> _getColor(String? imgUrl) async {
    try {
      if (imgUrl == null || imgUrl.isEmpty) return null;
      var paletteGenerator = await PaletteGenerator.fromImageProvider(Image.network(imgUrl).image);
      return paletteGenerator.dominantColor?.color;
    } catch (e) {
      return null;
    }
  }
}
