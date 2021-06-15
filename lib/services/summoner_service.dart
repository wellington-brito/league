import 'dart:convert';
import 'package:league/models/api_response.dart';
import 'package:league/models/summoner.dart';
import 'package:http/http.dart' as http;
import 'package:league/services/match_service.dart';
import '../models/summoner.dart';

class SummonerService {

  static const api = 'https://br1.api.riotgames.com/lol/summoner/v4/summoners/by-name/';
  static const headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36 OPR/76.0.4017.177 (Edition Campaign 34)",
    "Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
    "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
    "Origin": "https://developer.riotgames.com",
    "X-Riot-Token": ""
  };

  Future<APIResponse<List<Summoner>>> getDataSummoner(nickName) {
    return http
        .get(Uri.parse(api + nickName), headers: headers)
        .then((response) {
        if (response.statusCode == 200) {

          Map<String, dynamic> summonerFromJson = jsonDecode(response.body);
          MatchService matchService = new MatchService();
          Summoner summoner = new Summoner(
              id: summonerFromJson['id'].toString(),
              accountId: summonerFromJson['accountId'].toString(),
              puuid: summonerFromJson['puuid'].toString(),
              name: summonerFromJson['name'].toString(),
              profileIconId: summonerFromJson['profileIconId'].toString(),
              revisionDate: summonerFromJson['revisionDate'].toString(),
              summonerLevel: summonerFromJson['summonerLevel'].toString()
          );
          final summoners = <Summoner>[];
          summoners.add(summoner);
          matchService.getMatches(summoner.puuid);
          return APIResponse<List<Summoner>>(data: summoners );
        } else {
          ///print("RESPONSE "+response.statusCode.toString());
          throw Exception('Failed to load data of summoner');
        }
    });
  }
}
