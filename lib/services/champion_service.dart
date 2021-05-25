import 'dart:developer';
import 'package:league/models/api_response.dart';
import 'package:league/models/champion.dart';
import 'package:http/http.dart' as http;

class ChampionService {

 static const API = 'http://ddragon.leagueoflegends.com/cdn/';
 static const headers = {
   'apikey': 'hash aqui',
 };

  Future<APIResponse<List<Champion>>> getChampionList() {

    return http.get(Uri.https('http://ddragon.leagueoflegends.com/cdn/', '11.10.1/data/en_US/champion.json'))
      .then((data) {
        if(data.statusCode == 200){
          log("REQUISIÇÃO: "+data.body);
        }
        return APIResponse<List<Champion>>(error: true, errorMessage: 'An error ocurred');
      });
  }
}