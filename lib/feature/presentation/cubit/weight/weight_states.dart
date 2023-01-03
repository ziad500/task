import 'package:equatable/equatable.dart';
import 'package:task/feature/domain/model/weight_model.dart';

abstract class WeightState extends Equatable {
  const WeightState();
}

class WeightInitial extends WeightState {
  @override
  List<Object?> get props => [];
}

class WeightLoading extends WeightState {
  @override
  List<Object?> get props => [];
}

class WeightFailure extends WeightState {
  @override
  List<Object?> get props => [];
}

class WeightSuccess extends WeightState {
  final List<WeightEntity> weights;

  const WeightSuccess({required this.weights});
  @override
  List<Object?> get props => [];
}
