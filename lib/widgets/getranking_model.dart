class GetrankingModel {
  final int user_id, score, rank;

  GetrankingModel.fromJson(Map<String, dynamic> json)
      : user_id = json['user_id'],
        score = json['score'],
        rank = json['rank'];
}
