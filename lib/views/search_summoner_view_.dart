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
  late APIResponse<List<Summoner>> _apiResponse;
  String nickName = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Champion List')),
        body: Builder(
            builder: (_){
              return Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter the nick name',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter nick name from server BR';
                        } else {
                          nickName = value;
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.

                          // Process data.
                          _apiResponse = service.getDataSummoner(nickName) as APIResponse<List<Summoner>>;
                          // print(_apiResponse.toString());

                        },
                        child: const Text('Search'),
                      ),
                    ),
                  ],
                ),
              );
            },
            ));
  }



}
