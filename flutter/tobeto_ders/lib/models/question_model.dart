import 'package:tobeto_ders/models/question_answer_model.dart';

class QuestionModel {
  final String question;
  final List<QuestionAnswer> answers;

  QuestionModel({
    required this.question,
    required this.answers,
  });
}
