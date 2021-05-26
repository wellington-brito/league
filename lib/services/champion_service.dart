import 'dart:convert';
import 'dart:developer';
import 'package:league/models/api_response.dart';
import 'package:league/models/champion.dart';
import 'package:http/http.dart' as http;

import '../models/champion.dart';

class ChampionService {

  static const API = 'http://ddragon.leagueoflegends.com/cdn/';
  static const headers = {
    'apikey': 'hash aqui',
  };

  Future<APIResponse<List<Champion>>> getChampionList() {
    return http.get(Uri.parse(
        'http://ddragon.leagueoflegends.com/cdn/11.11.1/data/pt_BR/champion.json'))
        .then((response) {
      if (response.statusCode == 200) {
        final champions  = <Champion>[];
        Map<String, dynamic> list = jsonDecode(response.body);

        //final teste = Champion.fromJson(list).toList();
        //log('LOG'+teste.toString());
        log('nome, ${list['data']}');
        //log("REQUISITION DONE"+list.toString());
        return APIResponse<List<Champion>>(data: champions);
      }
      return APIResponse<List<Champion>>(data: [], error: true, errorMessage: 'An erro ocurred.');
    })
    .catchError((_) => APIResponse<List<Champion>>(data: [], error: true, errorMessage: 'An erro ocurred.') );
  }

}