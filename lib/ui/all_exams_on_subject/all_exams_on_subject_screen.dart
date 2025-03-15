import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/utils/string_manager.dart';
import 'package:online_exam_app/ui/all_exams_on_subject/viewmodel/get_all_exams_on_subject_cubit.dart';
import 'package:online_exam_app/ui/all_exams_on_subject/viewmodel/get_all_exams_on_subject_state.dart';

class AllExamsOnSubjectScreen extends StatelessWidget {
  final String subjectId;
  final String subjectName;

  const AllExamsOnSubjectScreen({
    super.key,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(subjectName),
      ),
      body: BlocBuilder<AllExamsCubit, AllExamsState>(
        builder: (context, state) {
          switch (state) {
            case AllExamsLoadingState():
              return const Center(child: CircularProgressIndicator());

            case AllExamsLoadedState():
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.exams.length,
                itemBuilder: (context, index) {
                  final exam = state.exams[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          exam.title ?? 'No Title',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text('${exam.numberOfQuestions ?? 0} Questions'),
                            Text('From: 1.00  To: ${exam.duration ?? 0}.00'),
                          ],
                        ),
                        trailing: Text(
                          '${exam.duration ?? 0} Minutes',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppStrings.startExamScreenRoute,
                            arguments: {
                              'exam': exam,
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );

            case AllExamsErrorState():
              return Center(child: Text(state.message));

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
