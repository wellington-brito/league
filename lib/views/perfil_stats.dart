import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PerfilStats extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nickName = '';
  Object profile = {};
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
              }else{
                nickName = value;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                  getProfile();
                  }
                },
              child: const Text('Search'),
            ),
          ),
        ],
      ),
    );
  }


  getProfile(){
    print("CLICOU: "+ nickName);
    const headers = { "Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
      "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
      "Origin": "https://developer.riotgames.com",
      "X-Riot-Token": "RGAPI-c22ca3dc-3246-4bfc-aa71-837033ed33dd"};

    http.get(Uri.parse(
        'https://br1.api.riotgames.com/lol/summoner/v4/summoners/by-name/'+nickName), headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        profile = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(profile.toString()),
        ));
      } else {
        print(response.statusCode);
      }
    });
  }
}