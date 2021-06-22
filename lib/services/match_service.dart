import 'package:http/http.dart' as http;

class MatchService {
  static const headers = {
    "Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
    "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
    "Origin": "https://developer.riotgames.com",
    "X-Riot-Token": ""
  };

  getMatches(puuid) {
    //print(puuid);
    return http
        .get(
            Uri.parse(
                'https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/' +
                    puuid +
                    '/ids?start=0&count=5'),
            headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        throw Exception('Failed to load data of summoner');
      }
    });
  }
}
