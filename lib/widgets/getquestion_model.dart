class GetquestionModel {
  final bool type;
  final String title, description, image_url, level, created_date, updated_date;
  final int theme_id, stage;

  GetquestionModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        title = json['title'],
        description = json['description'],
        image_url = json['image_url'] ?? 'week_challenge.png',
        level = json['level'] ?? "하",
        created_date = json['created_date'],
        updated_date = json['updated_date'],
        theme_id = json['theme_id'] ?? 1,
        stage = json['stage'] ?? 0;
}
