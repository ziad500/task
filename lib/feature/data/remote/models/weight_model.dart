import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/feature/domain/model/weight_model.dart';

class WeightModel extends WeightEntity {
  const WeightModel(
      {final String? weight,
      final Timestamp? date,
      final String? uid,
      final String? weightUid})
      : super(weight: weight, date: date, uid: uid, weightUid: weightUid);

  factory WeightModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return WeightModel(
        weight: documentSnapshot.get('weight'),
        date: documentSnapshot.get('date'),
        uid: documentSnapshot.get('uid'),
        weightUid: documentSnapshot.get('weightUid'));
  }

  Map<String, dynamic> toDocument() {
    return {"weight": weight, "date": date, "uid": uid, "weightUid": weightUid};
  }
}
