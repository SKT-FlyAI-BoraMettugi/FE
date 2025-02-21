// 문제 출제 응답을 받기 위한 모델

class ExamModel {
  final String message, question_id;

  ExamModel.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        question_id = json['question_id'];
}
