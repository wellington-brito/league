import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:league/models/api_response.dart';
import 'package:league/models/summoner.dart';
import 'package:league/services/summoner_service.dart';

class SearchSummonerView extends StatefulWidget {
  @override
  _SearchSummonerViewState createState() => _SearchSummonerViewState();
}

class _SearchSummonerViewState extends State<SearchSummonerView> {
  SummonerService get service => GetIt.I<SummonerService>();
  late APIResponse<Summoner> _apiResponse;
  String nickName = "";
  bool _isLoading = false;
  final myInputTextController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }

  _fetchSummoner(nickName) async {
    setState((){
      _isLoading = true;
    });

    _apiResponse = await service.getDataSummoner(nickName);

    setState(() {
      _isLoading = false;
    });
  }


  // Create a text controller and use it to retrieve the current value
  // of the TextField.


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myInputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: myInputTextController,
          ),
          Text(
            "summonerLevel: "+_apiResponse.data.summonerLevel,
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "name: "+_apiResponse.data.name,
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _fetchSummoner(myInputTextController.text),
        //print(_apiResponse.data.puuid),
        },
        child: Icon(Icons.text_fields),
      ),
    );
  }

}
