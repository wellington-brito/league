import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:league/models/api_response.dart';
import 'package:league/models/champion.dart';
import 'package:league/services/champion_service.dart';
import 'package:league/views/search_summoner_view_.dart';

class ChampionList extends StatefulWidget {
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
    setState((){
      _isLoading = true;
    });

    _apiResponse = await service.getChampionList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Champion List'),
            leading: GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => SearchSummonerView())),
              },
              child: Icon(
                Icons.search,
              ),
            ),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return CircularProgressIndicator();
            }
            if (_apiResponse.error) {
              return Center(child: Text(_apiResponse.errorMessage));
            }
              return ListView.separated(
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.blue),
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.blue,
                      backgroundImage: NetworkImage("http://ddragon.leagueoflegends.com/cdn/img/champion/splash/"+_apiResponse.data[index].name.toString() + "_0.jpg"), // no matter how big it is, it won't overflow
                    ),
                    title: Text(
                      _apiResponse.data[index].name + ' - ' + _apiResponse.data[index].key,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                      _apiResponse.data[index].title,
                    ),
                    //onTap: () => Alert(message:  _apiResponse.data[index].blurb, shortDuration: false).show()
                  );
                },
                itemCount: _apiResponse.data.length,
              );
            },
        ));
  }
}
