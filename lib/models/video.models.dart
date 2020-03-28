class Video {
  final String id;

  Video({this.id});

  factory Video.fromVideoJson(Map<String, dynamic> json) {
    return Video(
      id: json['key'],
    );
  }
}
