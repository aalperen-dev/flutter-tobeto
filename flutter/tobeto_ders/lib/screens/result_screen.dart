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
  int correctAnswers = 0;

  @override
  void initState() {
    correctAnswerCount();
    super.initState();
  }

  void correctAnswerCount() {
    for (var i = 0; i < widget.quizAnswers.length; i++) {
      if (widget.quizAnswers[i][1] == widget.studentAnswers[i][1]) {
        setState(() {
          correctAnswers++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${correctAnswers}'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(widget.quizAnswers);
          print(widget.studentAnswers);
          setState(() {});
        },
      ),
    );
  }
}
