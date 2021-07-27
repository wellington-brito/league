class Summoner {

  String id = '', accountId = '', puuid = '', name = '', profileIconId = '', revisionDate = '', summonerLevel = '', wasPlayed = '';

  Summoner({
    required this.id,
    required this.accountId,
    required this.puuid, 
    required this.name,
    required this.profileIconId,
    required this.revisionDate,
    required this.summonerLevel,
    required this.wasPlayed
  });


  factory Summoner.fromJson(Map<String, dynamic> json) {
    return Summoner(

      id: json['id'],
      accountId: json['accountId'],
      puuid: json['puuid'],
      name: json['name'],
      profileIconId: json['profileIconId'],
      revisionDate: json['revisionDate'],
      summonerLevel: json['summonerLevel'],
      wasPlayed: json['wasPlayed'],
    );

  }
}
