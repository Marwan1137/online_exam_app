import 'package:flutter/material.dart';
import 'package:online_exam_app/core/utils/string_manager.dart';
import 'package:online_exam_app/data/model/questions_response/exam.dart';

class StartExamScreen extends StatelessWidget {
  final Exam exam;

  const StartExamScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.book, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    exam.title ?? 'Languages',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Duration: ${exam.duration} Minutes',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.question_answer, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Questions: ${exam.numberOfQuestions}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppStrings.examScreenRoute,
                      arguments: exam.id, // Pass just the exam ID
                    );
                  },
                  child: Text('Start'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}