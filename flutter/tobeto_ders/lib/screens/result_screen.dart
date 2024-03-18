import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final List quizAnswers;
  final List studentAnswers;

  const ResultScreen({
    super.key,
    required this.quizAnswers,
    required this.studentAnswers,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List correctAnsweredQuestions = [];
  List wrongAnsweredQuestions = [];
  String correctAnsweredQuestionsString = '';
  String wrongAnsweredQuestionsString = '';

  @override
  void initState() {
    answerSeperator();
    correctAnsweredQuestionsString = answersString(correctAnsweredQuestions);
    wrongAnsweredQuestionsString = answersString(wrongAnsweredQuestions);
    super.initState();
  }

  void answerSeperator() {
    for (var i = 0; i < widget.quizAnswers.length; i++) {
      if (widget.quizAnswers[i][1] == widget.studentAnswers[i][1]) {
        correctAnsweredQuestions.add(widget.quizAnswers[i]);
      } else {
        wrongAnsweredQuestions.add(widget.quizAnswers[i]);
      }
    }
  }

  String answersString(List answers) {
    String retVal = '';
    for (var i = 0; i < answers.length; i++) {
      retVal += '${(answers[i][0] as int) + 1} ';
    }
    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz Results'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('---Sınav Sonucu---'),
              Text('Toplam Soru : ${widget.quizAnswers.length}'),
              Text('Doğru Cevap Sayısı : ${correctAnsweredQuestions.length}'),
              Text(
                  'Doğru Cevaplanan Sorular : $correctAnsweredQuestionsString'),
              Text(
                  'Yanlış/Boş Cevap Sayısı : ${wrongAnsweredQuestions.length}'),
              Text(
                  'Yanlış/Boş Cevaplanan Sorular : $wrongAnsweredQuestionsString'),
            ],
          ),
        ),
      ),
    );
  }
}
