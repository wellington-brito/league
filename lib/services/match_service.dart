import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:league/models/played_summoner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchService {
  static const headers = {
    "Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
    "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
    "Origin": "https://developer.riotgames.com",
    "X-Riot-Token": ""
  };

  Future getMatches(puuidOtherSummoner) {
    var matchesId = [];
    return http
        .get(
            Uri.parse(
                'https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/' +
                    puuidOtherSummoner +
                    '/ids?start=0&count=5'),
            headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        matchesId = jsonDecode(response.body);
        var playedSummoner = getTimeLine(matchesId, puuidOtherSummoner);
        return playedSummoner;
      } else {
        throw Exception('Failed to load data of matches');
      }
    });
  }

  Future getTimeLine(matchesId, puuidOtherSummoner) {
    return http
        .get(
            Uri.parse(
                'https://americas.api.riotgames.com/lol/match/v5/matches/' +
                    matchesId[0] +
                    '/timeline'),
            headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        var matchTimeLine = jsonDecode(response.body);
        var matchSummoners = matchTimeLine['metadata']['participants'];
        print(matchSummoners);
        return checkPuuid(matchSummoners);
      } else {
        throw Exception('Failed to load data of matches');
      }
    });
  }

  Future checkPuuid(matchSummoners) async {
    final prefs = await SharedPreferences.getInstance();
    var myPuuid = prefs.getString('puuid');
    var myName = prefs.getString('name');
    PlayedSummoner playedSummoner = new PlayedSummoner(
        wasPlayed: "", puuid: myPuuid.toString(), name: myName.toString());

    for (var item in matchSummoners) {
      print("MATCHSUMMONERS: " + item);
      if (item.toString() == myPuuid.toString()) {
        // print(item + " this player was played with you!");
        // print("Other Puuid: " + item.toString());
        // print("My Puuid: " + myPuuid.toString());
        // storeCache(item, 'Played With you.');
        // break;
        playedSummoner.wasPlayed = 'Played With you.';
        return playedSummoner;
      } else {
        playedSummoner.wasPlayed = 'Not played With you.';
        return playedSummoner;
      }
    }
  }

  Future storeCache(summoner, msg) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('wasPlayed', msg);
    print("WasPlayed: Saved in cache.");
  }
}
