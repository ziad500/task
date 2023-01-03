import 'package:task/feature/domain/model/user_model.dart';
import 'package:task/feature/domain/model/weight_model.dart';
import 'package:task/feature/domain/repositries/firebase_repo.dart';

class UpdateWeightUseCase {
  final FirebaseRepository repository;
  UpdateWeightUseCase({required this.repository});

  Future<void> execute(WeightEntity weight) async {
    return repository.updateWeight(weight);
  }
}
