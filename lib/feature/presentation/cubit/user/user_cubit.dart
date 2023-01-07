import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/feature/domain/model/user_model.dart';
import 'package:task/feature/domain/usecases/get_create_current_user_usecase.dart';
import 'package:task/feature/domain/usecases/sign_in_usecase.dart';
import 'package:task/feature/domain/usecases/sign_up_usecase.dart';
import 'package:task/feature/presentation/cubit/user/user_states.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;
  UserCubit(
      {required this.signInUseCase,
      required this.signUpUseCase,
      required this.getCreateCurrentUserUseCase})
      : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signInUseCase.execute(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      print("error");
      emit(UserFailure());
    } catch (_) {
      print("error");
      emit(UserFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signUpUseCase.execute(user);
      await getCreateCurrentUserUseCase.execute(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
