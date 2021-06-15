import 'dart:convert';
import 'package:league/models/api_response.dart';
import 'package:league/models/champion.dart';
import 'package:http/http.dart' as http;
import 'package:league/models/summoner.dart';
import '../models/champion.dart';

class MatchService {
  //static const API = 'https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/'+ puuid +'/ids?start=0&count=5';
  static const headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36 OPR/76.0.4017.177 (Edition Campaign 34)",
    "Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
    "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
    "Origin": "https://developer.riotgames.com",
    "X-Riot-Token": ""
  };

  getMatches(puuid) {
    return http
        .get(Uri.parse(
        'https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/'+ puuid +'/ids?start=0&count=5'), headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        throw Exception('Failed to load data of summoner');
      }
    });
  }
}
