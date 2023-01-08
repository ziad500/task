import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/feature/data/remote/models/weight_model.dart';
import 'package:task/feature/domain/model/weight_model.dart';
import 'package:task/feature/domain/usecases/add_new_weight_usecase.dart';
import 'package:task/feature/domain/usecases/delete_weight_usecase.dart';
import 'package:task/feature/domain/usecases/get_next_weights_usecase.dart';
import 'package:task/feature/domain/usecases/get_weight_usecase.dart';
import 'package:task/feature/domain/usecases/update_weight_usecase.dart';
import 'package:task/feature/presentation/cubit/weight/weight_states.dart';

class WeightCubit extends Cubit<WeightState> {
  final UpdateWeightUseCase updateWeightUseCase;
  final DeleteWeightUseCase deleteWeightUseCase;
  final GetWeightUseCase getWeightUseCase;
  final GetNextWeightUseCase getNextWeightUseCase;

  final AddNewWeightUseCase addNewWeightUseCase;
  WeightCubit(
      {required this.updateWeightUseCase,
      required this.deleteWeightUseCase,
      required this.getWeightUseCase,
      required this.getNextWeightUseCase,
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

  List<WeightEntity> weights = [];
  void getWeights({required String uid}) async {
    emit(WeightLoading());

    try {
      getWeightUseCase.execute(uid).listen((event) {
        weights = [];
        for (var element in event) {
          weights.add(element);
          print(weights.length);
          emit(WeightSuccess());
        }
      });
    } on SocketException catch (_) {
      print(_);
      print('error');

      emit(WeightFailure());
    } catch (_) {
      print(_);
      print('error');

      emit(WeightFailure());
    }
  }

  bool moreData = false;

  void getNextWeights({required String uid}) async {
    emit(WeightLoading());
    try {
      getNextWeightUseCase
          .execute(uid, weights[weights.length - 1].date!)
          .listen((event) {
        if (event.isEmpty) {
          moreData = false;
          emit(WeightLoading());
        }
        weights.addAll(event);
        print(weights.length);
        emit(WeightSuccess());
      });
    } on SocketException catch (_) {
      emit(WeightFailure());
      print('error');
    } catch (_) {
      emit(WeightFailure());
      print('error');
    }
  }

  more() {
    moreData = true;
    emit(WeightLoading());
  }
}
