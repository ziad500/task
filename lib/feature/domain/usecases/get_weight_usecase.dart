import 'package:task/feature/domain/model/weight_model.dart';
import 'package:task/feature/domain/repositries/firebase_repo.dart';

class GetWeightUseCase {
  final FirebaseRepository repository;
  GetWeightUseCase({required this.repository});

  Stream<List<WeightEntity>> execute(String uid) {
    return repository.getWeightList(uid);
  }
}
