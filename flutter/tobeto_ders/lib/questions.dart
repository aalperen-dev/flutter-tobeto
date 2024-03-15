import 'package:flutter/material.dart';
import 'package:tobeto_ders/data/question_data.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int indexSart = 0;
  List quizAnsers = [];
  List studentAnsers = [];
  void quizAnswers() {
    // print(questions.length);
    for (var i = 0; i < questions.length; i++) {
      // print(questions[i].question);
      for (var j = 0; j < questions[i].answers.length; j++) {
        // print(questions[i].answers[j].isCorrect);
        if (questions[i].answers[j].isCorrect == true) {
          quizAnsers.add([
            i,
            j,
          ]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    while (indexSart < questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  questions[indexSart].question,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //
              Expanded(
                child: ListView.builder(
                  itemCount: questions[indexSart].answers.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        studentAnsers.add([
                          indexSart,
                          index,
                        ]);
                        setState(() {
                          indexSart++;
                        });
                      },
                      child: Text(
                        questions[indexSart].answers[index].answerText,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            quizAnswers();
            print(quizAnsers);
            setState(() {});
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      );
    }
    print(studentAnsers);
    return const Scaffold(
      body: Center(
        child: Text('text'),
      ),
    );
  }
}
