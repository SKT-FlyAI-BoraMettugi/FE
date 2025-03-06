// 테마의 세부 정보를 가져오는 모델
class GetthemedetailModel {
  final int theme_id, user_id, stage, question_id;
  final String theme_name,
      high_succ_color,
      high_fail_color,
      mid_succ_color,
      mid_fail_color,
      low_succ_color,
      low_fail_color;

  GetthemedetailModel.fromJson(Map<String, dynamic> json)
      : theme_id = json['theme_id'],
        user_id = json['user_id'],
        stage = json['stage'],
        question_id = json['question_id'],
        theme_name = json['theme_name'],
        high_succ_color = json['high_succ_color'] ?? "#FFFFFF",
        high_fail_color = json['high_fail_color'] ?? "#FFFFFF",
        mid_succ_color = json['mid_succ_color'] ?? "#FFFFFF",
        mid_fail_color = json['mid_fail_color'] ?? "#FFFFFF",
        low_succ_color = json['low_succ_color'] ?? "#FFFFFF",
        low_fail_color = json['low_fail_color'] ?? "#FFFFFF";
}
