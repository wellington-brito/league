import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MatchService {
  static const headers = {
    "Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
    "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
    "Origin": "https://developer.riotgames.com",
    "X-Riot-Token": "RGAPI-8ad19d81-a04d-4a2c-bee7-6a701212701b"
  };

  Future getMatches(puuidOtherSummoner) async{
    var matchesId = [];
    final prefs = await SharedPreferences.getInstance();
    var myPuuid = prefs.getString('puuid');
    return http
        .get(
            Uri.parse(
                'https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/' +
                    myPuuid! +
                    '/ids?start=0&count=5'),
            headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        matchesId = jsonDecode(response.body);
        return getTimeLine(matchesId, puuidOtherSummoner);
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
        return checkPuuid(matchSummoners);
      } else {
        throw Exception('Failed to load data of matches');
      }
    });
  }

  Future checkPuuid(matchSummoners) async {
    final prefs = await SharedPreferences.getInstance();
    var myPuuid = prefs.getString('puuid');
    bool wasPlayed = false;
    var count = 0;
    for (var item in matchSummoners) {
      if (item.toString() == myPuuid.toString()) {
        await prefs.setString('wasPlayed', 'Played With you.');
        return true;
      }
      count ++;
    }
    if(count == matchSummoners.lenght){
      return wasPlayed;
    }
  }
}
