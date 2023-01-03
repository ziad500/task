import 'package:task/feature/domain/model/weight_model.dart';
import 'package:task/feature/domain/repositries/firebase_repo.dart';

class AddNewWeightUseCase {
  final FirebaseRepository repository;
  AddNewWeightUseCase({required this.repository});

  Future<void> execute(WeightEntity weight) async {
    return repository.addNewWeight(weight);
  }
}
