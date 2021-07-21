import 'dart:convert';
import 'dart:developer';
import 'package:league/models/summoner.dart';
import 'package:http/http.dart' as http;
import 'package:league/services/match_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/summoner.dart';

class SummonerService {
  static const api =
      'https://br1.api.riotgames.com/lol/summoner/v4/summoners/by-name/';
  static const headers = {
    "Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
    "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
    "Origin": "https://developer.riotgames.com",
    "X-Riot-Token": "RGAPI-40be81fc-fecd-4a8d-904e-061a13976235"
  };

  Future<Summoner> getDataSummoner(nickName) {
    return http
        .get(Uri.parse(api + nickName), headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> summonerFromJson = jsonDecode(response.body);

        Summoner summoner = new Summoner(
          id: summonerFromJson['id'].toString(),
          accountId: summonerFromJson['accountId'].toString(),
          puuid: summonerFromJson['puuid'].toString(),
          name: summonerFromJson['name'].toString(),
          profileIconId: summonerFromJson['profileIconI d'].toString(),
          revisionDate: summonerFromJson['revisionDate'].toString(),
          summonerLevel: summonerFromJson['summonerLevel'].toString(),
          wasPlayed: '',
        );

        storeCache(summoner);
        return summoner;
      } else {
        throw Exception('Failed to load data of your summoner');
      }
    });
  }

  Future getDataEnemy(nickName) async {
    final prefs = await SharedPreferences.getInstance();
    MatchService matchService = new MatchService();
    var respSummoner = await http
        .get(Uri.parse(api + nickName), headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> summonerFromJson = jsonDecode(response.body);
        Summoner summoner = new Summoner(
          id: summonerFromJson['id'].toString(),
          accountId: summonerFromJson['accountId'].toString(),
          puuid: summonerFromJson['puuid'].toString(),
          name: summonerFromJson['name'].toString(),
          profileIconId: summonerFromJson['profileIconId'].toString(),
          revisionDate: summonerFromJson['revisionDate'].toString(),
          summonerLevel: summonerFromJson['summonerLevel'].toString(),
          wasPlayed: '',
        );
        return summoner;
      } else {
        print("RESPONSE " + response.statusCode.toString());
        throw Exception('Failed to load data of Other Summoner');
      }
    });


    var wasPlayed = await matchService.getMatches(respSummoner.puuid.toString());
    print(wasPlayed);
    //print("JA JOGOU COMIGO: "+teste.toString());

    return [respSummoner,wasPlayed];
  }

  Future storeCache(summoner) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('puuid', summoner.puuid);
    await prefs.setString('name', summoner.name);
    await prefs.setString('summonerLevel', summoner.summonerLevel);
    print("PUUID: Saved in cache.");
  }

  clearCacheSummoner() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('puuid', '');
    await prefs.setString('name', '');
    await prefs.setString('summonerLevel', '');
    print("PUUID: clear cache.");
  }
}
