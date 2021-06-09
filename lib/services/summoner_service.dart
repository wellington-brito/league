import 'dart:convert';
import 'package:league/models/api_response.dart';
import 'package:league/models/summoner.dart';
import 'package:http/http.dart' as http;
import '../models/summoner.dart';

class SummonerService {
  SummonerService();
  late var summoner = <Summoner>[];
  static const api = 'https://br1.api.riotgames.com/lol/summoner/v4/summoners/by-name/';
  static const headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.128 Safari/537.36 OPR/75.0.3969.282",
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
          print(response.body);
          //summoner = jsonDecode(response.body);
          return APIResponse<List<Summoner>>(data: summoner );
        } else {
          return APIResponse<List<Summoner>>(data: summoner);
        }
    }).catchError((_) => APIResponse<List<Summoner>>(
      data: [], error: true, errorMessage: 'An erro ocurred.'));
  }
}
