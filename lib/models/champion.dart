class Champion {
  String version;
  String id;
  String key;
  String name;
  String title;

  Champion({
    required this.version,
    required this.id,
    required this.key,
    required this.name,
    required this.title,
  });

  factory Champion.fromJson(Map<String, dynamic> json) {
    return Champion(
      version: json['version'],
      id: json['id'],
      key: json['key'],
      name: json['name'],
      title: json['title'],
    );
  }
}
