class GetloginstatModel {
  final int user_id;
  final String message, nickname;

  GetloginstatModel.fromJson(Map<String, dynamic> json)
      : user_id = json['user_id'],
        message = json['message'],
        nickname = json['nickname'];
}
