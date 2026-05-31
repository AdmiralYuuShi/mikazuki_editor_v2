import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../widgets/slider_widget.dart';
import '../../widgets/widgets.dart';
import 'widgets/spotify_design_form.dart';

class SpotifyDesignPage extends StatefulWidget {
  const SpotifyDesignPage({super.key});

  @override
  State<SpotifyDesignPage> createState() => _SpotifyDesignPageState();
}

class _SpotifyDesignPageState extends State<SpotifyDesignPage> {
  late KeychainDesignData designData;

  @override
  void initState() {
    designData = KeychainDesignData.init().copyWith(
      title: '泥濘鳴鳴',
      artist: 'CoMETIK',
      spotifyUrl: 'https://open.spotify.com/track/6liJqMNGkVPJMjmwEjkrpB',
      youtubeUrl: 'https://music.youtube.com/watch?v=CuRIuFRD1zI&si=Qjc_MzwyDBY4bZ2g',
      coverUrl: 'https://i.scdn.co/image/ab67616d0000b27382a2b6bdfbcc2dbf29ab3748',
      titleFontSize: 0.5,
      artistFontSize: 0.5,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double designWidth = 320;
    double designHeight = 490;

    return Scaffold(
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 304 * 3)
            Container(
              width: 304,
              decoration: BoxDecoration(border: Border(right: BorderSide())),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text('MIKAZUKI EDITOR'),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(title: Text('Spotify Design'), onTap: () {}, selected: true),
                        ListTile(title: Text('Youtube Design'), onTap: () {}),
                        ListTile(title: Text('T-Shirt Design'), onTap: () {}),
                        Padding(padding: const EdgeInsets.all(16.0), child: Text(designData.toString())),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: designData.dominantColor ?? Colors.white,
                    height: designHeight,
                    width: designWidth,
                    child: Column(
                      children: [
                        ImageNetworkWidget(imageUrl: designData.coverUrl),
                        ImageNetworkWidget(
                          imageUrl:
                              'https://scannables.scdn.co/uri/plain/jpeg/${(designData.dominantColor ?? Colors.white).toSpotifyColor}/${designData.spotifyBarcodeBlack ? 'black' : 'white'}/640/spotify:track:${parseSpotifyUrl(designData.spotifyUrl)}',
                        ),
                        SizedBox(
                          height: 80 * (designData.titleFontSize),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              designData.title,
                              style: TextStyle(
                                color: designData.textColor ?? Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80 * (designData.artistFontSize),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              designData.artist,
                              style: GoogleFonts.bebasNeue(
                                color: designData.textColor ?? Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border(left: BorderSide())),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text('Spotify Design Editor'),
                  SizedBox(height: 20),
                  Expanded(
                    child: SpotifyDesignForm(
                      initData: designData,
                      onUpdate: (data) async {
                        print('ON UPDATE = GET');
                        KeychainDesignData updatedData = data;
                        setState(() {
                          designData = updatedData;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text('Save')),
                      SizedBox(width: 16),
                      ElevatedButton(onPressed: () {}, child: Text('Download')),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String parseSpotifyUrl(String url) {
    return url.split('/').lastOrNull?.split('?').firstOrNull ?? '';
  }
}

extension HexColor on Color {
  /// Converts a hexadecimal string to a [Color] object.
  ///
  /// The [hexString] should be in the format "aabbcc" or "ffaabbcc" with an
  /// optional leading "#". Returns `null` if the input is `null` or invalid.
  static Color? fromHex(String? hexString) {
    if (hexString == null) {
      return null;
    }
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) {
        buffer.write('ff');
      }
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return null;
    }
  }

  /// Converts this [Color] object to a hexadecimal string representation.
  ///
  /// The returned string is in the format "#aarrggbb" if [leadingHashSign] is
  /// `true`, otherwise "aarrggbb".
  String toHex({bool leadingHashSign = true}) {
    final hexA = (a * 255).round().toRadixString(16).padLeft(2, '0');
    final hexR = (r * 255).round().toRadixString(16).padLeft(2, '0');
    final hexG = (g * 255).round().toRadixString(16).padLeft(2, '0');
    final hexB = (b * 255).round().toRadixString(16).padLeft(2, '0');

    return '${leadingHashSign ? '#' : ''}$hexA$hexR$hexG$hexB';
  }

  String get toSpotifyColor {
    return toHex().replaceFirst('#ff', '');
  }
}
