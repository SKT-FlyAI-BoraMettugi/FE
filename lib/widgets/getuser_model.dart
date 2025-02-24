class GetuserModel {
  final int character_id, user_id, score;
  final String created_date,
      login_channel,
      profile_image,
      nickname,
      social_token,
      updated_date;

  GetuserModel.fromJson(Map<String, dynamic> json)
      : character_id = json['character_id'],
        user_id = json['user_id'],
        score = json['score'],
        created_date = json['created_date'],
        login_channel = json['login_channel'],
        profile_image = json['profile_image'],
        nickname = json['nickname'],
        social_token = json['social_token'],
        updated_date = json['updated_date'];
}
