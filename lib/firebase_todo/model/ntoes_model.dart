class Notes {
  String? title, description, createdTime, userId, id;
  bool? loader;

  Notes(
      {this.title,
      this.description,
      this.createdTime,
      this.userId,
      this.id,
      this.loader});

  factory Notes.fromJson(Map<String, dynamic> json, String id) {
    return Notes(
        title: json["title"],
        createdTime: json["created_time"],
        description: json["description"],
        userId: json["user_id"],
        id: id,
        loader: false);
  }
}
