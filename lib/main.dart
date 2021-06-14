import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:league/services/champion_service.dart';
import 'package:league/services/summoner_service.dart';
import 'package:league/views/champion_list.dart';
import 'package:get_it/get_it.dart';
import 'package:league/views/search_summoner_view_.dart';


final GetIt getIt = GetIt.I;

void main() {
  setUpLocator();
  runApp(MyApp());
}

void setUpLocator(){
  getIt.registerLazySingleton(() => ChampionService());
  getIt.registerFactory<SummonerService>(() => SummonerService());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SearchSummonerView(),
    );
  }
}
