import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../data/data.dart';
import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class SpotifyDesignFormPage extends StatefulWidget {
  const SpotifyDesignFormPage({super.key});

  @override
  State<SpotifyDesignFormPage> createState() => _SpotifyDesignFormPageState();
}

class _SpotifyDesignFormPageState extends State<SpotifyDesignFormPage> {
  void _updateDate(KeychainDesignData data) {
    if (context.mounted) {
      context.read<SpotifyDesignBloc>().add(SpotifyDesignEvent.updateData(data: data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotifyDesignBloc, SpotifyDesignState>(
      builder: (context, state) {
        KeychainDesignData? activeDesign = state.activeDesign;

        if (activeDesign == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.wallpaper), SizedBox(height: 20), Text('No Active Design')],
          );
        }

        return Column(
          children: [
            SizedBox(height: 20),
            Text('Spotify Design Editor'),
            SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6),
                        TextFieldWidget(label: 'Spotify Url', controller: activeDesign.spotifyUrlController),
                        SizedBox(height: 16),
                        TextFieldWidget(label: 'Image Url', controller: activeDesign.coverUrlController),
                        SizedBox(height: 16),
                        TextFieldWidget(label: 'Title', controller: activeDesign.titleController),
                        SizedBox(height: 16),
                        TextFieldWidget(label: 'Artists', controller: activeDesign.artistController),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            label: Text('SET'),
                            icon: Icon(Icons.play_arrow),
                            onPressed: () async {
                              Color? updatedDominantColor = activeDesign.dominantColor;

                              if (activeDesign.coverUrlController.text != activeDesign.coverUrl ||
                                  activeDesign.dominantColor == null) {
                                updatedDominantColor = await _getColor(activeDesign.coverUrlController.text);
                                print('GET COLOR = $updatedDominantColor = title:${activeDesign.titleController.text}');
                              }

                              _updateDate(
                                activeDesign.copyWith(
                                  dominantColor: updatedDominantColor,
                                  title: activeDesign.titleController.text,
                                  coverUrl: activeDesign.coverUrlController.text,
                                  spotifyUrl: activeDesign.spotifyUrlController.text,
                                  artist: activeDesign.artistController.text,
                                ),
                              );
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
                                _updateDate(activeDesign.copyWith(dominantColor: Colors.black));
                              },
                              icon: Icon(Icons.palette, color: Colors.black),
                            ),
                            IconButton(
                              onPressed: () {
                                _updateDate(activeDesign.copyWith(dominantColor: Colors.white));
                              },
                              icon: Icon(Icons.palette_outlined, color: Colors.grey),
                            ),
                            SizedBox(width: 8),
                            OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.palette), label: Text('Custom')),
                            SizedBox(width: 8),
                            IconButton(
                              onPressed: () async {
                                Color? updatedDominantColor = await _getColor(activeDesign.coverUrlController.text);
                                _updateDate(activeDesign.copyWith(dominantColor: updatedDominantColor));
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
                                _updateDate(activeDesign.copyWith(spotifyBarcodeBlack: true));
                              },
                              icon: Icon(Icons.palette, color: Colors.black),
                            ),
                            IconButton(
                              onPressed: () {
                                _updateDate(activeDesign.copyWith(spotifyBarcodeBlack: false));
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
                                _updateDate(activeDesign.copyWith(textColor: Colors.black));
                              },
                              icon: Icon(Icons.palette, color: Colors.black),
                            ),
                            IconButton(
                              onPressed: () {
                                _updateDate(activeDesign.copyWith(textColor: Colors.white));
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
                          value: activeDesign.titleFontSize,
                          onChanged: (val) {
                            _updateDate(activeDesign.copyWith(titleFontSize: val));
                          },
                        ),
                        SizedBox(height: 16),
                        SliderWidget(
                          label: 'Artists Font Size',
                          value: activeDesign.artistFontSize,
                          onChanged: (val) {
                            _updateDate(activeDesign.copyWith(artistFontSize: val));
                          },
                        ),
                        SizedBox(height: 16),
                        SliderWidget(
                          label: 'Vertical Position',
                          value: activeDesign.verticalPosition,
                          onChanged: (val) {
                            _updateDate(activeDesign.copyWith(verticalPosition: val));
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
                SizedBox(width: 16),
                ElevatedButton(onPressed: () {}, child: Text('Save')),
              ],
            ),
            SizedBox(height: 20),
          ],
        );
      },
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
