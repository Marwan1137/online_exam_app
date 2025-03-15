import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/utils/string_manager.dart';
import 'package:online_exam_app/core/utils/text_style_manger.dart';
import 'package:online_exam_app/data/model/Result/ResultModel.dart';
import 'package:online_exam_app/ui/exam_screen/layouts/desktop/summary_exam_desktop_body.dart';
import 'package:online_exam_app/ui/exam_screen/layouts/layout_builder.dart';
import 'package:online_exam_app/ui/exam_screen/layouts/mobile/summary_exam_body.dart';
import 'package:online_exam_app/ui/exam_screen/view_model/questions_cubit.dart';
import 'package:online_exam_app/ui/exam_screen/view_model/questions_intent.dart';

class SummaryExamScreen extends StatelessWidget {
  final int countOfQuestions;
  final GetQuestionsSuccessState getQuestionsSuccessState;

  const SummaryExamScreen(
      {super.key,
      required this.countOfQuestions,
      required this.getQuestionsSuccessState});

  @override
  Widget build(BuildContext context) {
    final cubit = QuestionsCubit.get(context);
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
            cubit.doIntent(addResultIntent(
              result: ResultModel(
                correctQuestions: cubit.correctQuestions,
                selectedAnswersMap: cubit.selectedAnswersMap,
                wrongQuestions: cubit.wrongQuestions,
                subject: getQuestionsSuccessState
                    .questionResponse?.questions![0].subject,
                examId: getQuestionsSuccessState
                    .questionResponse?.questions?[0].exam?.id,
                message: getQuestionsSuccessState.questionResponse?.message,
                questions: getQuestionsSuccessState.questionResponse?.questions,
                exam: getQuestionsSuccessState
                    .questionResponse?.questions?[0].exam,
              ),
            ));
            return LayoutBuilderWidget(
                mobileLayout: (context) => SummaryExamBody(
                      state: state,
                      examId: getQuestionsSuccessState
                              .questionResponse?.questions?.first.exam?.id ??
                          "",
                    ),
                tabletLayout: (context) => SummaryExamBody(
                      state: state,
                      examId: getQuestionsSuccessState
                              .questionResponse?.questions?[0].exam?.id ??
                          "",
                    ),
                desktopLayout: (context) => SummaryExamDesktopBody(
                      state: state,
                      examId: getQuestionsSuccessState
                              .questionResponse?.questions?[0].exam?.id ??
                          "",
                    ));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
