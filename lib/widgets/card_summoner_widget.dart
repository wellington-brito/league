// import 'package:flutter/material.dart';
//
// class CardSummonerWidget extends StatelessWidget {
//
//   final String? nameCache;
//   final String? summonerLevelCache;
//
//   @override
//   Widget build(BuildContext context) {
//     return _showCardSummoner(context);
//   }
//
//   _showCardSummoner(context){
//     return Card(
//               margin: EdgeInsets.all(16.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text(
//                       nameCache == ''
//                           ? "Summoner (you)"
//                           : nameCache.toString() + " (you)",
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const SizedBox(
//                         width: 73,
//                       ),
//                       Text(
//                         "Level " + summonerLevelCache.toString(),
//                         style: const TextStyle(fontWeight: FontWeight.normal),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       const SizedBox(width: 8),
//                       TextButton(
//                         onPressed: () {
//                           service.clearCacheSummoner();
//                           setState(() {
//                             nameCache = '';
//                             summonerLevelCache = '';
//                           });
//                         },
//                         child: Text(
//                           'CLEAR',
//                           style:
//                               TextStyle(color: Theme.of(context).accentColor),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//   }
//
//
//
//
//
//
// }