import 'package:task/feature/domain/model/weight_model.dart';
import 'package:task/feature/domain/model/user_model.dart';
import 'package:task/feature/domain/repositries/firebase_repo.dart';

import '../remote/data_sources/firebase_remote_data_source.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> addNewWeight(WeightEntity weight) async =>
      remoteDataSource.addNewWeight(weight);

  @override
  Future<void> deleteWeight(WeightEntity weight) async =>
      remoteDataSource.deleteWeight(weight);

  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();

  @override
  Stream<List<WeightEntity>> getWeightList(String uid) =>
      remoteDataSource.getWeightList(uid);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);

  @override
  Future<void> updateWeight(WeightEntity weight) async =>
      remoteDataSource.updateWeight(weight);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      remoteDataSource.getCreateCurrentUser(user);
}
