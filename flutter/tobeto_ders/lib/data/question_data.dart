import 'package:tobeto_ders/models/question_answer_model.dart';
import 'package:tobeto_ders/models/question_model.dart';

List<QuestionModel> questions = [
  QuestionModel(
    question: 'Soru 1 text',
    answers: [
      QuestionAnswer(
        answerText: 'Cevap 1 true',
        isCorrect: true,
      ),
      QuestionAnswer(
        answerText: 'Cevap 2 false',
        isCorrect: false,
      ),
      QuestionAnswer(
        answerText: 'Cevap 3 false',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    question: 'Soru 2 text',
    answers: [
      QuestionAnswer(
        answerText: 'Cevap 1 false',
        isCorrect: false,
      ),
      QuestionAnswer(
        answerText: 'Cevap 2 false',
        isCorrect: false,
      ),
      QuestionAnswer(
        answerText: 'Cevap 3 false',
        isCorrect: false,
      ),
      QuestionAnswer(
        answerText: 'Cevap 4 true',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    question: 'Soru 3 text',
    answers: [
      QuestionAnswer(
        answerText: 'Cevap 1 false',
        isCorrect: false,
      ),
      QuestionAnswer(
        answerText: 'Cevap 2 true',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    question: 'Soru 4 text',
    answers: [
      QuestionAnswer(
        answerText: 'Cevap 1 false',
        isCorrect: false,
      ),
      QuestionAnswer(
        answerText: 'Cevap 2 true',
        isCorrect: true,
      ),
      QuestionAnswer(
        answerText: 'Cevap 3 false',
        isCorrect: false,
      ),
      QuestionAnswer(
        answerText: 'Cevap 4 false',
        isCorrect: false,
      ),
      QuestionAnswer(
        answerText: 'Cevap 5 false',
        isCorrect: false,
      ),
      QuestionAnswer(
        answerText: 'Cevap 6 false',
        isCorrect: false,
      ),
    ],
  ),
];
