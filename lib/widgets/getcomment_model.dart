class GetcommentModel {
  final int comment_id, like;
  final String content, created_date, updated_date;

  GetcommentModel.fromJson(Map<String, dynamic> json)
      : comment_id = json['comment_id'],
        like = json['like'],
        content = json['content'],
        created_date = json['created_date'],
        updated_date = json['updated_date'];
}
