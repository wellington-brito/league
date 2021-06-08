import 'dart:convert';
import 'dart:developer';
import 'package:league/models/api_response.dart';
import 'package:league/models/champion.dart';
import 'package:http/http.dart' as http;
import '../models/champion.dart';

class ChampionService {
  static const API = 'http://ddragon.leagueoflegends.com/cdn/';
  static const headers = {"content-type":"application/json; charset=utf-8"};

  Future<APIResponse<List<Champion>>> getChampionList() {
    return http
        .get(Uri.parse(
            'http://ddragon.leagueoflegends.com/cdn/11.11.1/data/pt_BR/champion.json'), headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        final champions = <Champion>[];
        Map<String, dynamic> list = jsonDecode(response.body);

        for (Object data in list['data'].keys) {
          Map<String, dynamic> ch = list['data'][data];
          Champion champion = new Champion(
            version: ch['version'],
            id: ch['id'],
            key: ch['key'],
            name: ch['name'],
            title: ch['title'],
            blurb: ch['blurb'],
          );
          champions.add(champion);
        }
        return APIResponse<List<Champion>>(data: champions);
      } else {
        return APIResponse<List<Champion>>(
            data: [], error: true, errorMessage: 'An erro ocurred. Status code');
      }
    }).catchError((_) => APIResponse<List<Champion>>(
        data: [], error: true, errorMessage: 'An erro ocurred. Status code'));
  }
}
