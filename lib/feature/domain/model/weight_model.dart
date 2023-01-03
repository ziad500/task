import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WeightEntity extends Equatable {
  final String? uid;
  final String? weightUid;
  final String? weight;
  final Timestamp? date;

  const WeightEntity({this.weight, this.date, this.uid, this.weightUid});

  @override
  List<Object?> get props => [weight, date, uid, weightUid];
}
