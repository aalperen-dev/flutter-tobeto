import 'package:flutter/material.dart';

import 'package:tobeto_ders/data/question_data.dart';
import 'package:tobeto_ders/screens/result_screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int indexStart = 0;
  int correctAnswerCount = 0;
  List quizAnswers = [];
  List studentAnswers = List.filled(questions.length, [98, 99]);

  @override
  void initState() {
    quizCorrectAnswers();
    super.initState();
  }

  void quizCorrectAnswers() {
    // print(questions.length);
    for (var i = 0; i < questions.length; i++) {
      // print(questions[i].question);
      for (var j = 0; j < questions[i].answers.length; j++) {
        // print(questions[i].answers[j].isCorrect);
        if (questions[i].answers[j].isCorrect == true) {
          quizAnswers.add([
            i,
            j,
          ]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('Soru: ${indexStart + 1} / ${questions.length}'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  questions[indexStart].question,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            //

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: questions[indexStart].answers.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Cevap kaydedildi!'),
                      ));
                      setState(() {
                        studentAnswers[indexStart] = [
                          indexStart,
                          index,
                        ];
                        if (indexStart < questions.length - 1) {
                          indexStart++;
                        }
                      });
                    },
                    child: Text(
                      questions[indexStart].answers[index].answerText,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (indexStart > 0 && indexStart <= questions.length)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        indexStart--;
                      });
                    },
                    label: const Text(
                      "Önceki Soru",
                    ),
                  ),
                if (indexStart >= 0 && indexStart < questions.length - 1)
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          indexStart++;
                        });
                      },
                      label: const Text(
                        "Sonraki Soru",
                      ),
                    ),
                  ),
                //
                if (indexStart == questions.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            quizAnswers: quizAnswers,
                            studentAnswers: studentAnswers,
                          ),
                        ),
                      );
                    },
                    child: const Text('Sonuç Ekranı!'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
