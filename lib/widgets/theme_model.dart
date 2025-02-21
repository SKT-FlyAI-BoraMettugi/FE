class ThemeModel {
  final theme_id, theme_name, theme_ex, profile_img;

  ThemeModel.fromJson(Map<String, dynamic> json)
      : theme_id = json["theme_id"],
        theme_name = json["theme_name"],
        theme_ex = json["theme_ex"],
        profile_img = json["profile_img"];
}
