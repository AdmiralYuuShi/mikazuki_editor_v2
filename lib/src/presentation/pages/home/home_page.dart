import 'package:flutter/material.dart';

import '../product/product_form_page.dart';
import '../product/product_list_page.dart';
import '../spotify_design/spotify_design_form_page.dart';
import '../spotify_design/spotify_design_page.dart';

enum PrimaryPageList {
  productList('Product List'),
  spotifyDesign('Spotify Design'),
  youtubeDesign('Youtube Design'),
  tShirtDesign('T-Shirt Design');

  final String title;

  const PrimaryPageList(this.title);
}

enum SecondaryPageList {
  productForm('Product Form'),
  spotifyDesignForm('Spotify Design Form'),
  youtubeDesignForm('Youtube Design Form'),
  tShirtDesignForm('T-Shirt Design Form');

  final String title;

  const SecondaryPageList(this.title);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PrimaryPageList selectedPage = PrimaryPageList.productList;
  SecondaryPageList? selectedSecondPage;
  late KeychainDesignData activeDesignData;

  @override
  void initState() {
    activeDesignData = KeychainDesignData.init().copyWith(
      title: '泥濘鳴鳴',
      artist: 'CoMETIK',
      spotifyUrl: 'https://open.spotify.com/track/6liJqMNGkVPJMjmwEjkrpB',
      youtubeUrl: 'https://music.youtube.com/watch?v=CuRIuFRD1zI&si=Qjc_MzwyDBY4bZ2g',
      coverUrl: 'https://i.scdn.co/image/ab67616d0000b27382a2b6bdfbcc2dbf29ab3748',
      titleFontSize: 0.5,
      artistFontSize: 0.5,
      dominantColor: HexColor.toColor('ffdde6ec'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      children:
                          PrimaryPageList.values
                              .map(
                                (e) => ListTile(
                                  title: Text(e.title),
                                  selected: selectedPage == e,
                                  onTap: () {
                                    setState(() {
                                      selectedPage = e;

                                      switch (selectedPage) {
                                        case PrimaryPageList.productList:
                                          selectedSecondPage = null;
                                        case PrimaryPageList.spotifyDesign:
                                          selectedSecondPage = SecondaryPageList.spotifyDesignForm;
                                          break;
                                        default:
                                      }
                                    });
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: switch (selectedPage) {
              PrimaryPageList.productList => ProductListPage(
                onSelectProduct: (productId) {
                  setState(() {
                    selectedSecondPage = SecondaryPageList.productForm;
                  });
                },
              ),
              PrimaryPageList.spotifyDesign => SpotifyDesignPage(designData: activeDesignData),
              _ => SizedBox(),
            },
          ),
          if (selectedSecondPage != null)
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border(left: BorderSide())),
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height,
                child: switch (selectedSecondPage) {
                  SecondaryPageList.productForm => ProductFormPage(),
                  SecondaryPageList.spotifyDesignForm => SpotifyDesignFormPage(
                    initData: activeDesignData,
                    onUpdate: (KeychainDesignData data) {
                      setState(() {
                        activeDesignData = data;
                      });
                    },
                  ),
                  _ => SizedBox(),
                },
              ),
            ),
        ],
      ),
    );
  }
}
