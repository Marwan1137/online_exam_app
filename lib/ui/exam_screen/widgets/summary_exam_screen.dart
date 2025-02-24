import 'package:flutter/material.dart';
import 'package:online_exam_app/core/utils/config.dart';
import 'package:online_exam_app/core/utils/text_style_manger.dart';
import 'package:online_exam_app/ui/exam_screen/widgets/Score_Indicator.dart';
import 'package:online_exam_app/ui/exam_screen/widgets/next&back_customButton.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SummaryExamScreen extends StatelessWidget {
  final int conrrectAnswers;
  final int inConrrectAnswers;
  const SummaryExamScreen(
      {super.key,
      required this.conrrectAnswers,
      required this.inConrrectAnswers});

  @override
  Widget build(BuildContext context) {
    double percentGrade =
        (conrrectAnswers / (conrrectAnswers + inConrrectAnswers));

    Config().init(context);
    double area = (Config.screenHight! + Config.screenWidth!) * 2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam score"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Your score",
              style: AppTextStyle.medium20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CircularPercentIndicator(
                    radius: area * 0.03,
                    lineWidth: 10,
                    percent: 1.0,
                    center: Text(
                      "${(percentGrade * 100).toInt()} %",
                      style: AppTextStyle.medium20,
                    ),
                    progressColor: Theme.of(context).colorScheme.primary,
                    animation: true,
                  ),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ScoreIndicator(
                            label: "Correct",
                            count: conrrectAnswers,
                            isCorrect: true),
                        ScoreIndicator(
                            label: "Incorrect",
                            count: inConrrectAnswers,
                            isCorrect: false),
                      ]),
                )
              ],
            ),
            OutlinedFilledButton(
                text: "Show results", onTap: () {}, borderSide: false),
            OutlinedFilledButton(
                text: "Start again", onTap: () {}, borderSide: true),
          ],
        ),
      ),
    );
  }
}
