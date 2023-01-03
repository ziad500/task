import 'package:task/feature/domain/model/user_model.dart';
import 'package:task/feature/domain/model/weight_model.dart';

abstract class FirebaseRemoteDataSource {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<String> getCurrentUid();
  Future<void> addNewWeight(WeightEntity weight);
  Future<void> updateWeight(WeightEntity weight);
  Future<void> deleteWeight(WeightEntity weight);
  Stream<List<WeightEntity>> getWeightList(String uid);
}
