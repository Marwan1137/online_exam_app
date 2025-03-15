import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/utils/string_manager.dart';
import 'package:online_exam_app/ui/explorescreen/viewmodel/cubit/explore_cubit.dart';
import 'package:online_exam_app/ui/explorescreen/viewmodel/cubit/explore_state.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Survey',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Browse by subject',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<ExploreCubit, ExploreState>(
                  builder: (context, state) {
                    switch (state) {
                      case ExploreLoadingState():
                        return const Center(child: CircularProgressIndicator());

                      case ExploreLoadedState():
                        return ListView.builder(
                          itemCount: state.subjects.length,
                          itemBuilder: (context, index) {
                            final subject = state.subjects[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 20),
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
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    child: Image.network(
                                      subject.icon,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.subject, size: 30);
                                      },
                                    ),
                                  ),
                                  title: Text(
                                    subject.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onTap: () async {
                                    // First navigate to get all exams screen
                                    Navigator.pushNamed(
                                      context,
                                      AppStrings
                                          .getAllExamsOnSubjectScreenRoute,
                                      arguments: {
                                        'subjectId': subject.id,
                                        'subjectName': subject.name,
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );

                      case ExploreErrorState():
                        return Center(child: Text(state.message));

                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
