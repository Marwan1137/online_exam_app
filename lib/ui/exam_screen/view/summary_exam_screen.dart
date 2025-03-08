import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/Di/di.dart';
import 'package:online_exam_app/core/utils/config.dart';
import 'package:online_exam_app/core/utils/string_manager.dart';
import 'package:online_exam_app/core/utils/text_style_manger.dart';
import 'package:online_exam_app/ui/exam_screen/view_model/questions_cubit.dart';
import 'package:online_exam_app/ui/exam_screen/widgets/Score_Indicator.dart';
import 'package:online_exam_app/ui/exam_screen/widgets/next&back_customButton.dart';
import 'package:online_exam_app/ui/resultsScreen/VeiwModel/result_cubit.dart';
import 'package:online_exam_app/ui/resultsScreen/VeiwModel/result_intent.dart';
import 'package:online_exam_app/ui/resultsScreen/pages/Answers%20Screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SummaryExamScreen extends StatelessWidget {
  final int countOfQuestions;
  final String examId;

  const SummaryExamScreen({
    required this.examId,
    super.key,
    required this.countOfQuestions,
  });

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    double area = (Config.screenHight! + Config.screenWidth!) * 2;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Exam score",
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppStrings.homeScreenRoute, (route) => false);
            },
          )),
      body: BlocBuilder<QuestionsCubit, QuestionsState>(
        buildWhen: (previous, current) {
          if (current is CheckAnswersSuccessState ||
              current is CheckAnswersErrorState ||
              current is CheckAnswersLoadingState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is CheckAnswersErrorState) {
            return Center(
              child:
                  Text(state.message.toString(), style: AppTextStyle.regular25),
            );
          }

          if (state is CheckAnswersSuccessState) {
            String? totalString =
                state.qestionsResultResponse?.total?.replaceAll("%", "");

            double totalDouble = state.qestionsResultResponse?.total != "NaN%"
                ? double.tryParse(totalString ?? "") ?? 0.0
                : 0.0;
            totalDouble = totalDouble / 100;
            int totalInt = state.qestionsResultResponse?.total != "NaN%"
                ? (double.tryParse(totalString ?? "")?.round() ?? 0)
                : 0;

            return Padding(
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
                          percent: totalDouble,
                          center: Text(
                            "$totalInt%",
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
                                  count: state.qestionsResultResponse?.correct
                                          ?.toInt() ??
                                      0,
                                  isCorrect: true),
                              ScoreIndicator(
                                  label: "Incorrect",
                                  count: state.qestionsResultResponse?.wrong
                                          ?.toInt() ??
                                      0,
                                  isCorrect: false),
                            ]),
                      )
                    ],
                  ),
                  OutlinedFilledButton(
                      text: "Show results",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => getIt<ResultCubit>()
                                ..doIntent(getResultByIdIntent(examId: examId)),
                              child: AnswersScreen(),
                            ),
                          ),
                        );
                      },
                      borderSide: false),
                  OutlinedFilledButton(
                      text: "Start again",
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppStrings.examScreenRoute);
                      },
                      borderSide: true),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
