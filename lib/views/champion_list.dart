import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:league/models/api_response.dart';
import 'package:league/models/champion.dart';
import 'package:league/services/champion_service.dart';

class ChampionList extends StatefulWidget{

  @override
  _ChampionListState createState() => _ChampionListState();
}

class _ChampionListState extends State<ChampionList> {
  ChampionService get service => GetIt.I<ChampionService>();
  late APIResponse<List<Champion>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchChampions();
    super.initState();
  }

  _fetchChampions() async {
    setState(){
      _isLoading = true;
    }

    _apiResponse = await service.getChampionList();

    // setState(){
    //   _isLoading = false;
    // }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Champion List')),
      body: _isLoading ? CircularProgressIndicator() : ListView.separated(
          separatorBuilder: (_, __) => Divider(height: 1, color: Colors.blue),
          itemBuilder: (_, index){
            return ListTile(
            title: Text(
                //champions[index].name+' - '+champions[index].key,
              'teste',
                style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text(
              // champions[index].title,
              'teste'
            ),
            );
    },
          itemCount: 3,
          //champions.length
      ),
    );
  }
}