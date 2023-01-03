import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/feature/domain/model/weight_model.dart';
import 'package:task/feature/domain/usecases/add_new_weight_usecase.dart';
import 'package:task/feature/domain/usecases/delete_weight_usecase.dart';
import 'package:task/feature/domain/usecases/get_weight_usecase.dart';
import 'package:task/feature/domain/usecases/update_weight_usecase.dart';
import 'package:task/feature/presentation/cubit/weight/weight_states.dart';

class WeightCubit extends Cubit<WeightState> {
  final UpdateWeightUseCase updateWeightUseCase;
  final DeleteWeightUseCase deleteWeightUseCase;
  final GetWeightUseCase getWeightUseCase;
  final AddNewWeightUseCase addNewWeightUseCase;
  WeightCubit(
      {required this.updateWeightUseCase,
      required this.deleteWeightUseCase,
      required this.getWeightUseCase,
      required this.addNewWeightUseCase})
      : super(WeightInitial());

  Future<void> addWeight({required WeightEntity weight}) async {
    try {
      await addNewWeightUseCase.execute(weight);
    } on SocketException catch (_) {
      emit(WeightFailure());
    } catch (_) {
      emit(WeightFailure());
    }
  }

  Future<void> deleteWeight({required WeightEntity weight}) async {
    try {
      await deleteWeightUseCase.execute(weight);
    } on SocketException catch (_) {
      emit(WeightFailure());
    } catch (_) {
      emit(WeightFailure());
    }
  }

  Future<void> updateWeight({required WeightEntity weight}) async {
    try {
      await updateWeightUseCase.execute(weight);
    } on SocketException catch (_) {
      emit(WeightFailure());
    } catch (_) {
      emit(WeightFailure());
    }
  }

  Future<void> getWeights({required String uid}) async {
    emit(WeightLoading());

    try {
      getWeightUseCase.execute(uid).listen((weights) {
        emit(WeightSuccess(weights: weights));
      });
    } on SocketException catch (_) {
      emit(WeightFailure());
    } catch (_) {
      emit(WeightFailure());
    }
  }
}
