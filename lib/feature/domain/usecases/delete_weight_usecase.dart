import 'package:task/feature/domain/model/weight_model.dart';
import 'package:task/feature/domain/repositries/firebase_repo.dart';

class DeleteWeightUseCase {
  final FirebaseRepository repository;
  DeleteWeightUseCase({required this.repository});

  Future<void> execute(WeightEntity weight) async {
    return repository.deleteWeight(weight);
  }
}
