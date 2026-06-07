import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:universal_html/html.dart' as html;

import '../../../data/data.dart';
import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class SpotifyDesignPage extends StatefulWidget {
  const SpotifyDesignPage({super.key});

  @override
  State<SpotifyDesignPage> createState() => _SpotifyDesignPageState();
}

class _SpotifyDesignPageState extends State<SpotifyDesignPage> {
  WidgetsToImageController imageController = WidgetsToImageController();

  bool isKeychainDesign = false;

  Future<void> saveImage(String? filename, Uint8List bytes) async {
    if (kIsWeb) {
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor =
          html.document.createElement('a') as html.AnchorElement
            ..href = url
            ..style.display = 'none'
            ..download = '${filename == null || filename.isEmpty ? 'kasih nama kek' : filename}.png';
      html.document.body?.children.add(anchor);
      anchor.click();
      html.Url.revokeObjectUrl(url);
      // final File image = await File('screenshots/$screenshotName.png').create(recursive: true);
      // image.writeAsBytesSync(screenshotBytes);

      // File('my_image.jpg').writeAsBytes(bodyBytes);
    } else {
      // await Gal.putImageBytes(bytes, album: 'Mikazuki', name: filename ?? 'kasih nama kek');

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Saved to Pictures/Mikazuki/$filename'),
      //     action: SnackBarAction(
      //       label: 'OK',
      //       onPressed: () {
      //         // Code to execute.
      //       },
      //     ),
      //   ),
      // );
    }
  }

  void showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double designWidth = 320;
    final double designHeight = 490;

    return BlocBuilder<SpotifyDesignBloc, SpotifyDesignState>(
      builder: (context, state) {
        KeychainDesignData? activeDesign = state.activeDesign;
        if (activeDesign == null || (activeDesign.coverUrl).isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.wallpaper), SizedBox(height: 20), Text('No Active Design')],
          );
        }
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: WidgetsToImage(
                controller: imageController,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Padding(
                      padding:
                          isKeychainDesign
                              ? EdgeInsets.only(top: 290.0, right: 46, left: 16, bottom: 32)
                              : EdgeInsets.zero,
                      child: Container(
                        height: designHeight,
                        width: designWidth,
                        decoration: BoxDecoration(
                          color: activeDesign.dominantColor ?? Colors.white,
                          border:
                              isKeychainDesign
                                  ? Border.all(
                                    width: 16,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: const Color.fromARGB(255, 210, 210, 210),
                                  )
                                  : null,
                        ),
                        child: Column(
                          children: [
                            ImageNetworkWidget(imageUrl: activeDesign.coverUrl),
                            ImageNetworkWidget(
                              imageUrl:
                                  'https://scannables.scdn.co/uri/plain/jpeg/${(activeDesign.dominantColor ?? Colors.white).toSpotifyColor}/${activeDesign.spotifyBarcodeBlack ? 'black' : 'white'}/640/spotify:track:${parseSpotifyUrl(activeDesign.spotifyUrl)}',
                            ),
                            SizedBox(
                              height: 80 * (activeDesign.titleFontSize),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  activeDesign.title,
                                  style: TextStyle(
                                    color: activeDesign.textColor ?? Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80 * (activeDesign.artistFontSize),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  activeDesign.artist,
                                  style: GoogleFonts.bebasNeue(
                                    color: activeDesign.textColor ?? Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isKeychainDesign)
                      Positioned(
                        top: 248,
                        left: 164,
                        child: Center(
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                width: 14,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: const Color.fromARGB(255, 210, 210, 210),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (isKeychainDesign)
                      Positioned(
                        left: 136,
                        top: 10,
                        child: ImageAssetWidget(width: 260, height: 260, path: 'assets/img/keychain_ring.png'),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        isKeychainDesign = !isKeychainDesign;
                      });
                    },
                    icon: Icon(isKeychainDesign ? Icons.anchor : Icons.account_box_rounded),
                  ),
                  IconButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'Downloading...');
                      final result = await imageController.capture();
                      if (result != null) {
                        await saveImage(DateTime.now().millisecondsSinceEpoch.toString(), result);
                      }
                      EasyLoading.dismiss();
                      showSnackbar('Downloaded');
                    },
                    icon: Icon(Icons.download),
                  ),
                  IconButton(
                    onPressed: () {
                      _showLogs(activeDesign.toString());
                    },
                    icon: Icon(Icons.list_alt),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLogs(String logs) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 16.0),
          title: const Text('Details'),
          children: <Widget>[
            Text(logs),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
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
  static Color? toColor(String? hexString) {
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
