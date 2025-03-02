import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/data/model/questions_response/question_response.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/repo_contract/questions_repo_contract/get_questions_repo_contract.dart';
import 'package:online_exam_app/domain/use_cases/get_questions_usecase.dart';

import 'get_questions_usecase_test.mocks.dart';

@GenerateMocks([GetQuestionsRepoContract])
void main() {
  group('GetQuestionsUseCase', () {});

  test(
    'when calling call function from GetQuestionsUseCase should call getQuestions function from GetQuestionsRepoContract',
    () async {
      // setUp() {

      // }

      var result = Success<QuestionResponse>(QuestionResponse());
      var repo = MockGetQuestionsRepoContract();
      provideDummy<Result<QuestionResponse>>(result);
      when(repo.getQuestions('670070a830a3c3c1944a9c63'))
          .thenAnswer((_) async => result);
      GetQuestionsUseCase useCase = GetQuestionsUseCase(repo);
      var actual = await useCase.call('670070a830a3c3c1944a9c63');
      verify(repo.getQuestions("670070a830a3c3c1944a9c63")).called(1);
      expect(actual, equals(result));
    },
  );
}
