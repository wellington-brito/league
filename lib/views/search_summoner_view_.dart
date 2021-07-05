import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:league/models/summoner.dart';
import 'package:league/services/summoner_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? nameCache = "";
String nameCacheConverted = "";
String? summonerLevelCache = "";
String? played = "";
bool _isLoading = false;
String nickName = "";

class SearchSummonerView extends StatefulWidget {
  @override
  _SearchSummonerViewState createState() => _SearchSummonerViewState();
}

class _SearchSummonerViewState extends State<SearchSummonerView> {
  // Create a global key that uniquely identifies the Form widget  and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  SummonerService get service => GetIt.I<SummonerService>();
  var otherSummoner = new Summoner(
      id: '',
      accountId: '',
      puuid: '',
      name: 'Other Summoner',
      profileIconId: '',
      revisionDate: '',
      summonerLevel: '0');
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
    String? playedWithMe = prefs.getString('wasPlayed');

    if (prefsName == null &&
        prefsSummonerLevel == null &&
        playedWithMe == null) {
      prefsName = "Summoner";
      prefsSummonerLevel = "0";
      playedWithMe = "Searching...";
    }

    setState(() {
      nameCache = prefsName;
      summonerLevelCache = prefsSummonerLevel;
      played = playedWithMe;
    });
  }

  Future<void> _fetchSummoner(nickName, otherNickName) async {
    try {
      var respOther;
      setState(() {
        _isLoading = true;
      });

      if (nickName != '') {
        await service.getDataSummoner(nickName);
        _getDataCache();
      }

      if (otherNickName != '') {
        respOther = await service.getDataEnemy(otherNickName);
        _getDataCache();
      }

      setState(() {
        otherSummoner = respOther;
        _isLoading = false;
      });
    } catch (e) {
      _showErrorDialog(e);
    }
  }

  Future<void> _showErrorDialog(e) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error on Load data.'),
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

  _clearInputs() {
    inputTextCtrl.clear();
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.unfocus();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          // Add TextFormFields and ElevatedButton here.
                          TextFormField(
                            cursorColor: Theme.of(context).accentColor,
                            controller: inputTextMyNickCtrl,
                            decoration: InputDecoration(
                              hintText: 'Your summoner name.',
                              fillColor: Theme.of(context).accentColor,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your summoner name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            width: 73,
                            height: 10,
                          ),
                          TextFormField(
                            controller: inputTextCtrl,
                            decoration: InputDecoration(
                              hintText: 'Other Summoner to search.',
                              fillColor: Theme.of(context).accentColor,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter other summoner name.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      nameCache == ''
                          ? "Summoner (you)"
                          : nameCache.toString() + " (you)",
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
                        onPressed: () {
                          service.clearCacheSummoner();
                          setState(() {
                            nameCache = '';
                            summonerLevelCache = '';
                          });
                        },
                        child: Text(
                          'CLEAR',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
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
              style:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(width: 73),
                  ListTile(
                    leading: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Theme.of(context).accentColor),
                          )
                        : Icon(Icons.person),
                    title: Text(
                      otherSummoner.name.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 73,
                      ),
                      Text(
                        "Level " + otherSummoner.summonerLevel,
                        textAlign: TextAlign.left,
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
                        child: const Text(''),
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
          if (_formKey.currentState!.validate())
            {
              // If the form is valid, display a snackbar. In the real world,
              _fetchSummoner(inputTextMyNickCtrl.text, inputTextCtrl.text),
              _getDataCache(),
              _clearInputs(),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(_isLoading
                    ? "Searching in Match history..."
                    : "Other Summoner " + played.toString()),
              )),
            }
        },
        child: _isLoading
            ? Icon(Icons.hourglass_top_sharp)
            : Icon(Icons.manage_search),
      ),
    );
  }
}
