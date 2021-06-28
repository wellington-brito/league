import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:league/services/champion_service.dart';
import 'package:league/services/summoner_service.dart';
import 'package:league/views/search_summoner_view_.dart';

final GetIt getIt = GetIt.I;

main() {
  setUpLocator();
  runApp(MyApp());
}

void setUpLocator() {
  getIt.registerLazySingleton(() => ChampionService());
  getIt.registerFactory(() => SummonerService());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        accentColor: Colors.deepPurpleAccent,

        // Define the default font family.
        fontFamily: 'Oxygen',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        // textTheme: TextTheme(
        //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
      ),
      home: SearchSummonerView(),
      //home: ChampionList(),
    );
  }
}
