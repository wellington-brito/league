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
  final primaryColor = const Color(0xFFC19B4F);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League',
      theme: ThemeData(
        // brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF101516),
        primaryColor: Color(0xFFC19B4F),
        secondaryHeaderColor: Color(0xFFC19B4F),
        accentColor: Color(0xFFC19B4F),
        cardTheme: CardTheme(
          color: Color(0xFF11282A),
          shadowColor: Color(0xFF088A9F),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF088A9F), elevation: 12),
        // Define the default font family.
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC19B4F)),
          headline6: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              color: Color(0xFFC19B4F)),
          bodyText1: TextStyle(
              fontSize: 14.0, fontFamily: 'Roboto', color: Color(0xFFC19B4F)),
          bodyText2: TextStyle(
              fontSize: 14.0, fontFamily: 'Roboto', color: Color(0xFFC19B4F)),
          subtitle1: TextStyle(
            color: Color(0xFFC19B4F),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color(0xFFC19B4F),
          hintStyle: TextStyle(color: Color(0xFF604518)),
        ),
      ),
      home: SearchSummonerView(),
      //home: ChampionList(),
    );
  }
}
