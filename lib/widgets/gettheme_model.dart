// 전체 테마 불러오는 모델

class GetthemeModel {
  final int theme_id;
  final String theme_name;
  final String theme_ex;
  final String profile_img, background_img;

  GetthemeModel.fromJson(Map<String, dynamic> json)
      : theme_id = json['theme_id'],
        theme_name = json['theme_name'],
        theme_ex = json['theme_ex'] ?? "준비되지 않음",
        profile_img = json['profile_img'],
        background_img = json['background_img'];
}
