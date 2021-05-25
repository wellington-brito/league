import 'dart:convert';
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
    return http.get(Uri.parse(
        'http://ddragon.leagueoflegends.com/cdn/11.10.1/data/en_US/champion.json'))
        .then((response) {
      if (response.statusCode == 200) {
        final champions  = <Champion>[];
        log("REQUISITION DONE"+ response.body);
        return APIResponse<List<Champion>>(data: champions);
      }
      return APIResponse<List<Champion>>(data: [], error: true, errorMessage: 'An erro ocurred.');
    })
    .catchError((_) => APIResponse<List<Champion>>(data: [], error: true, errorMessage: 'An erro ocurred.') );
  }

// final response = await http.get(Uri.parse('http://ddragon.leagueoflegends.com/cdn/11.10.1/data/en_US/champion.json'));
//
//     if (response.statusCode == 200) {
//       //return Champion.fromJson(jsonDecode(response.body));
//       return ;
//     } else {
//       throw Exception('Failed to load champion list');
//     }
}