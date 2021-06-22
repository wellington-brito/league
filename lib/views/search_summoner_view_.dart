import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:league/models/summoner.dart';
import 'package:league/services/summoner_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? nameCache = "";
String nameCacheConverted = "";
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

  //Start states and data from cache.
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
    try {
      setState(() {
        _isLoading = true;
      });

      if (nameCache == null) {
        await service.getDataSummoner(nickName);
        _getDataCache();
      }

      var respOther = await service.getDataEnemy(otherNickName);

      setState(() {
        if (otherNickName != '') otherSummoner = respOther;
        _isLoading = false;
      });
    } catch (e) {
      _showMyDialog(e);
    }
  }

  Future<void> _showMyDialog(e) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(e.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                        controller: inputTextMyNickCtrl,
                        decoration: InputDecoration(
                          hintText: 'Your summoner name.',
                        )),
                    TextField(
                      controller: inputTextCtrl,
                      decoration: InputDecoration(
                        hintText:
                            'Summoner name to search in your matches history.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      nameCache.toString() + " (you)",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 73,
                      ),
                      Text(
                        "Level " + summonerLevelCache.toString(),
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text('LIMPAR'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "played with",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.blueGrey),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _isLoading
                      ? const SizedBox(width: 73)
                      : ListTile(
                          leading: Icon(Icons.person),
                          title: _isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  _isLoading ? "Summoner" : otherSummoner.name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 73,
                      ),
                      _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              _isLoading
                                  ? "Level "
                                  : "Level " + otherSummoner.summonerLevel,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text('LIMPAR'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _fetchSummoner(inputTextMyNickCtrl.text, inputTextCtrl.text),
          _getDataCache(),
        },
        child: Icon(Icons.manage_search),
      ),
    );
  }
}
