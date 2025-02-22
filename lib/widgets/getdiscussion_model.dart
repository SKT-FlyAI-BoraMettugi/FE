// 토론을 불러오는 모델
class GetdiscussionModel {
  final int user_id, discussion_id, like;
  final String content, created_date;
  final bool comment_exist;

  GetdiscussionModel.fromJson(Map<String, dynamic> json)
      : user_id = json['user_id'],
        discussion_id = json['discussion_id'],
        like = json['like'],
        content = json['content'],
        created_date = json['created_date'],
        comment_exist = json['comment_exist'];
}
