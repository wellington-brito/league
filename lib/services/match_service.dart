import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MatchService {
  static const headers = {
    "Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
    "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
    "Origin": "https://developer.riotgames.com",
    "X-Riot-Token": "RGAPI-befebfc0-23fc-4918-8806-b42591419c54"
  };

  getMatches(puuidOtherSummoner) async {
    final prefs = await SharedPreferences.getInstance();
    var myPuuid = prefs.getString('puuid');
    var count = 0;
    bool respTimeLine = false;
    var matchesId = await http
        .get(
            Uri.parse(
                'https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/' +
                    myPuuid! +
                    '/ids?start=0&count=5'),
            headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data of matches');
      }
    });

    for (var matchId in matchesId) {
      print("match id: " + matchId);
      respTimeLine = await getTimeLine(matchId, puuidOtherSummoner);
      count++;
      if (respTimeLine) break;
    }

    if (count == 5 || respTimeLine) return respTimeLine;
  }

  Future getTimeLine(matchId, puuidOtherSummoner) {
    return http
        .get(
            Uri.parse(
                'https://americas.api.riotgames.com/lol/match/v5/matches/' +
                    matchId +
                    '/timeline'),
            headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        var matchTimeLine = jsonDecode(response.body);
        var matchSummoners = matchTimeLine['metadata']['participants'];
        return checkPuuid(matchSummoners, puuidOtherSummoner);
      } else {
        throw Exception('Failed to load data of matches');
      }
    });
  }

  Future checkPuuid(matchSummoners, puuidOtherSummoner) async {
    final prefs = await SharedPreferences.getInstance();
    var myPuuid = prefs.getString('puuid');
    var count = 0;
    for (var item in matchSummoners) {
      print("COUNT: " + count.toString());
      if (item.toString() == puuidOtherSummoner.toString()) {
        await prefs.setString('wasPlayed', 'Played With you.');
        return true;
      }
      count++;
    }
    if (count == matchSummoners.toList().length) {
      return false;
    }
  }
}
