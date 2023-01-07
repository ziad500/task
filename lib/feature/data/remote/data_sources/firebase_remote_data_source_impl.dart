import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/app_const.dart';
import 'package:task/feature/data/remote/models/user_model.dart';
import 'package:task/feature/data/remote/models/weight_model.dart';
import 'package:task/feature/domain/model/weight_model.dart';

import 'package:task/feature/domain/model/user_model.dart';

import 'firebase_remote_data_source.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<void> addNewWeight(WeightEntity weightEntity) async {
    final uid = await getCurrentUid();

    final weightCollectionRef =
        firestore.collection("users").doc(uid).collection("weight");
    final weightId = weightCollectionRef.doc().id;
    weightCollectionRef.doc(weightId).get().then((weight) {
      final newWeight = WeightModel(
              date: weightEntity.date,
              uid: uid0,
              weight: weightEntity.weight,
              weightUid: weightId)
          .toDocument();
      if (!weight.exists) {
        weightCollectionRef.doc(weightId).set(newWeight);
      }
      return;
    });
  }

  @override
  Future<void> deleteWeight(WeightEntity weightEntity) async {
    final weightCollectionRef = firestore
        .collection("users")
        .doc(weightEntity.uid)
        .collection("weight");

    weightCollectionRef.doc(weightEntity.weightUid).get().then((weight) {
      if (weight.exists) {
        weightCollectionRef.doc(weightEntity.weightUid).delete();
      }
    });
  }

  @override
  Future<String> getCurrentUid() async => auth.currentUser!.uid;

  @override
  Stream<List<WeightEntity>> getWeightList(String uid) {
    final weightCollectionRef = firestore
        .collection("users")
        .doc(uid)
        .collection("weight")
        .orderBy('date', descending: true)
        .limit(10);
    return weightCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => WeightModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Stream<List<WeightEntity>> getNextWeightList(String uid, Timestamp date) {
    final weightCollectionRef = firestore
        .collection("users")
        .doc(uid)
        .collection("weight")
        .orderBy('date', descending: true)
        .startAfter([date]).limit(10);

    if (weightCollectionRef.snapshots().length == 0) {
      return Stream.empty();
    } else {
      return weightCollectionRef.snapshots().map((querySnap) {
        return querySnap.docs
            .map((docSnap) => WeightModel.fromSnapshot(docSnap))
            .toList();
      });
    }
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser!.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

  @override
  Future<void> updateWeight(WeightEntity weight) async {
    Map<String, dynamic> weightMap = Map();
    final weightCollectionRef =
        firestore.collection("users").doc(weight.uid).collection("weight");

    if (weight.weight != null) weightMap["weight"] = weight.weight;
    if (weight.date != null) weightMap["date"] = weight.date;

    weightCollectionRef.doc(weight.weightUid).update(weightMap);
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection("users");
    final uid = await getCurrentUid();
    userCollectionRef.doc(user.uid).get().then((value) async {
      final newUser = UserModel(
              uid: uid, email: user.email, mobile: user.mobile, name: user.name)
          .toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
    });
    return;
  }
}
