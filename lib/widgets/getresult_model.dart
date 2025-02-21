class GetresultModel {
  final int creativity, logic, thinking, persuasion, depth, total_score;
  final String creativity_review,
      logic_review,
      thinking_review,
      persuasion_review,
      depth_review;

  GetresultModel.fromJson(Map<String, dynamic> json)
      : creativity = json['creativity'],
        logic = json['logic'],
        thinking = json['thinking'],
        persuasion = json['persuasion'],
        depth = json['depth'],
        total_score = json['total_score'],
        creativity_review = json['creativity_review'],
        logic_review = json['logic_review'],
        thinking_review = json['thinking_review'],
        persuasion_review = json['persuasion_review'],
        depth_review = json['depth_review'];
}
