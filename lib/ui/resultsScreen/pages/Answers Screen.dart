import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Shared/widgets/toast_message.dart';
import 'package:online_exam_app/core/theme/colors_manager.dart';
import 'package:online_exam_app/data/model/questions_response/question.dart';
import 'package:online_exam_app/ui/resultsScreen/VeiwModel/result_cubit.dart';
import 'package:online_exam_app/ui/resultsScreen/VeiwModel/result_intent.dart';
import 'package:online_exam_app/ui/resultsScreen/widgets/Answer%20Builder%20Result.dart';
import 'package:online_exam_app/ui/resultsScreen/widgets/Result%20Choice%20Widget.dart';

class AnswersScreen extends StatelessWidget {
  final String examId;
  const AnswersScreen({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    // Initialize the cubit and trigger the state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = ResultCubit.get(context);
      if (cubit.state is ResultInitial) {
        cubit.doIntent(getResultByIdIntent(examId: examId));
      }
      print("ExamId received: $examId");
    });

    return Scaffold(
      appBar: AppBar(title: Text("Answers")),
      body: BlocConsumer<ResultCubit, ResultState>(
        listener: (context, state) {
          if (state is GetResultByIdStateLoading) {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: CircularProgressIndicator(
                  color: AppColors.blue_base,
                ),
              ),
            );
          }
          if (state is GetResultByIdStateError) {
            toastMessage(
                message: state.message, tybeMessage: TybeMessage.negative);
          }
        },
        builder: (context, state) {
          if (state is GetResultByIdStateSuccess) {
            // Extract all questions
            List<Question> allQuestions = state.result?.questions ?? [];

            // Classify questions
            List<Map<String, dynamic>> combinedList = [];

            for (var question in allQuestions) {
              if (state.result?.correctQuestions
                      ?.any((cq) => cq.qid == question.id) ??
                  false) {
                //the correct answers
                combinedList.add({
                  "question": question,
                  "type": ChoiceType.correct,
                });
              }

              //the wrong answers
              else if (state.result?.wrongQuestions
                      ?.any((wq) => wq.qid == question.id) ??
                  false) {
                combinedList.add({
                  "question": question,
                  "type": ChoiceType.wrong,
                });
              }
              //the empty answers
              else {
                combinedList.add({
                  "question": question,
                  "type": ChoiceType.empty,
                });
              }
            }

            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: combinedList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              // Add spacing between items
              itemBuilder: (context, index) {
                final questionData = combinedList[index];
                final Question question = questionData["question"];
                final ChoiceType type = questionData["type"];

                final String? studentAnswerKey =
                    state.result?.selectedAnswersMap?[question.id];

                return ResultAnswerBuilder(
                  studentAnswerKey: studentAnswerKey ?? "",
                  questionType: type,
                  answers: question.answers ?? [],
                  correctAnswerKey: question.correct ?? '',
                  question: question.question ?? '',
                );
              },
            );
          }

          return Text("Something went wrong");
        },
      ),
    );
  }
}
