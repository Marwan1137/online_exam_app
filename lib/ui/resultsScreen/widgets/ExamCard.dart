// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:online_exam_app/core/Di/di.dart';
import 'package:online_exam_app/core/theme/colors_manager.dart';
import 'package:online_exam_app/core/utils/config.dart';
import 'package:online_exam_app/data/model/Result/ResultModel.dart';
import 'package:online_exam_app/ui/resultsScreen/VeiwModel/result_cubit.dart';
import 'package:online_exam_app/ui/resultsScreen/VeiwModel/result_intent.dart';
import 'package:online_exam_app/ui/resultsScreen/pages/Answers%20Screen.dart';

class ExamCard extends StatelessWidget {
  final ResultModel result;
  Function onDelete;

  ExamCard({required this.result, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => getIt<ResultCubit>()
                ..doIntent(getResultByIdIntent(examId: result.examId ?? "")),
              child: AnswersScreen(examId: result.examId ?? ""),
            ),
          ),
        );
      },
      child: Card(
        color: AppColors.white,
        elevation: 10,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Slidable(
          startActionPane: ActionPane(
            motion: DrawerMotion(),
            extentRatio: .4,
            children: [
              SlidableAction(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                onPressed: (context) {
                  _showDialog(context);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: result.subject?.icon != null
                      ? Image.network(
                          result.subject!.icon!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.image_not_supported_rounded, size: 80),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            result.exam?.title ?? "No Title",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${result.exam?.duration.toString() ?? "0"} Minutes",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1),
                      Text(
                        "${result.questions?.length ?? "0"} Questions",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.blue_base,
                            fontWeight: FontWeight.w600, // Default style
                          ),
                          children: [
                            TextSpan(
                              text: "${result.correctQuestions?.length} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900), // Extra bold
                            ),
                            TextSpan(text: "Corrected answers of "),
                            TextSpan(
                              text: "${result.questions?.length} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900), // Extra bold
                            ),
                            TextSpan(text: "questions"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Warning',
            style: TextStyle(
              color: Colors.red.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'This will permanently delete the result.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red.shade600,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red[500],
              ),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              },
            ),
          ],
        );
      },
    );
  }
}
