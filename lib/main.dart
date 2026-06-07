import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'src/presentation/blocs/blocs.dart';
import 'src/presentation/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      title: 'MIKAZUKI MK.II',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)),
      home: MultiBlocProvider(
        providers: [BlocProvider<SpotifyDesignBloc>(create: (BuildContext context) => SpotifyDesignBloc())],
        child: HomePage(),
      ),
    );
  }
}
