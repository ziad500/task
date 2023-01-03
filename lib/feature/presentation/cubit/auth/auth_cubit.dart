import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/app_const.dart';
import 'package:task/feature/domain/usecases/get_current_uid_usecase.dart';
import 'package:task/feature/domain/usecases/is_sign_in_usecase.dart';
import 'package:task/feature/domain/usecases/sign_out_usecase.dart';
import 'package:task/feature/presentation/cubit/auth/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  AuthCubit(
      {required this.getCurrentUidUseCase,
      required this.isSignInUseCase,
      required this.signOutUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase.execute();
      if (isSignIn) {
        final uid = await getCurrentUidUseCase.execute();
        uid0 = uid;
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      print(_);
      emit(UnAuthenticated());
    } catch (e) {
      print(e);
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.execute();
      emit(Authenticated(uid: uid));
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.execute();
      emit(UnAuthenticated());
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }
}
