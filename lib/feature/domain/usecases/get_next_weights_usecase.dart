import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/feature/domain/model/weight_model.dart';
import 'package:task/feature/domain/repositries/firebase_repo.dart';

class GetNextWeightUseCase {
  final FirebaseRepository repository;
  GetNextWeightUseCase({required this.repository});

  Stream<List<WeightEntity>> execute(String uid, Timestamp date) {
    return repository.getNextWeightList(uid, date);
  }
}
