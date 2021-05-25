import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:league/models/champion.dart';
import 'package:league/services/champion_service.dart';

class ChampionList extends StatefulWidget{

  @override
  _ChampionListState createState() => _ChampionListState();
}

class _ChampionListState extends State<ChampionList> {
  ChampionService get service => GetIt.I<ChampionService>();

  List<Champion> champions = [];

  @override
  void initState() {
    champions = service.getChampionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Champion List')),
      body: ListView.separated(
          separatorBuilder: (_, __) => Divider(height: 1, color: Colors.blue),
          itemBuilder: (_, index){
            return ListTile(
            title: Text(
                champions[index].name+' - '+champions[index].key,
                style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text(
              champions[index].title,
            ),
            );
    },
          itemCount: champions.length,
      ),
    );
  }
}