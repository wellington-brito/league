import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:league/models/summoner.dart';
import 'package:league/services/summoner_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? nameCache = "";
String? summonerLevelCache = "";
bool _isLoading = false;
String nickName = "";

class SearchSummonerView extends StatefulWidget {
  @override
  _SearchSummonerViewState createState() => _SearchSummonerViewState();
}

class _SearchSummonerViewState extends State<SearchSummonerView> {
  SummonerService get service => GetIt.I<SummonerService>();
  var otherSummoner = new Summoner(
      id: '',
      accountId: '',
      puuid: '',
      name: '',
      profileIconId: '',
      revisionDate: '',
      summonerLevel: '');
  var summoner = new Summoner(
      id: '',
      accountId: '',
      puuid: '',
      name: '',
      profileIconId: '',
      revisionDate: '',
      summonerLevel: '');
  final inputTextMyNickCtrl = TextEditingController();
  final inputTextCtrl = TextEditingController();

  @override
  void initState() {
    _getDataCache().whenComplete(() async => null);
    super.initState();
  }

  Future _getDataCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prefsName = prefs.getString('name');
    String? prefsSummonerLevel = prefs.getString('summonerLevel');

    setState(() {
      nameCache = prefsName;
      summonerLevelCache = prefsSummonerLevel;
    });
  }

  Future<void> _fetchSummoner(nickName, otherNickName) async {
    setState(() {
      _isLoading = true;
    });

    if (nameCache == '') await service.getDataSummoner(nickName);

    var respOther = await service.getDataEnemy(otherNickName);

    setState(() {
      if (otherNickName != '') otherSummoner = respOther;
      _isLoading = false;
    });
  }

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputTextMyNickCtrl.dispose();
    inputTextCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
                controller: inputTextMyNickCtrl,
                decoration: InputDecoration(
                  hintText: 'Your summoner name.',
                )),
            TextField(
              controller: inputTextCtrl,
              decoration: InputDecoration(
                hintText: 'Summoner name to search in your matches history.',
              ),
            ),
            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : Text(
                    "Other summonerLevel: " + otherSummoner.summonerLevel,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
            _isLoading
                ? CircularProgressIndicator()
                : Text(
                    "Other Nickname: " + otherSummoner.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            Text(
              "Cache nickName: " + nameCache.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Cache level: " + summonerLevelCache.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _fetchSummoner(inputTextMyNickCtrl.text, inputTextCtrl.text),
          _getDataCache(),
        },
        child: Icon(Icons.text_fields),
      ),
    );
  }
}
