class GeturlModel {
  final String login_url;

  GeturlModel.fromJson(Map<String, dynamic> json)
      : login_url = json['login_url'];
}
