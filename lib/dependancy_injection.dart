import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:task/feature/data/remote/data_sources/firebase_remote_data_source.dart';
import 'package:task/feature/data/remote/data_sources/firebase_remote_data_source_impl.dart';
import 'package:task/feature/data/repositries/firebase_repo_impl.dart';
import 'package:task/feature/domain/usecases/add_new_weight_usecase.dart';
import 'package:task/feature/domain/usecases/delete_weight_usecase.dart';
import 'package:task/feature/domain/usecases/get_create_current_user_usecase.dart';
import 'package:task/feature/domain/usecases/get_current_uid_usecase.dart';
import 'package:task/feature/domain/usecases/get_weight_usecase.dart';
import 'package:task/feature/domain/usecases/is_sign_in_usecase.dart';
import 'package:task/feature/domain/usecases/sign_in_usecase.dart';
import 'package:task/feature/domain/usecases/sign_out_usecase.dart';
import 'package:task/feature/domain/usecases/sign_up_usecase.dart';
import 'package:task/feature/domain/usecases/update_weight_usecase.dart';
import 'package:task/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:task/feature/presentation/cubit/user/user_cubit.dart';
import 'package:task/feature/presentation/cubit/weight/weight_cubit.dart';

import 'feature/domain/repositries/firebase_repo.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUidUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call()));

  sl.registerFactory<UserCubit>(() => UserCubit(
      signInUseCase: sl.call(),
      signUpUseCase: sl.call(),
      getCreateCurrentUserUseCase: sl.call()));

  sl.registerFactory<WeightCubit>(() => WeightCubit(
      updateWeightUseCase: sl.call(),
      deleteWeightUseCase: sl.call(),
      getWeightUseCase: sl.call(),
      addNewWeightUseCase: sl.call()));

  //usecase
  sl.registerLazySingleton<AddNewWeightUseCase>(
      () => AddNewWeightUseCase(repository: sl.call()));

  sl.registerLazySingleton<DeleteWeightUseCase>(
      () => DeleteWeightUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetWeightUseCase>(
      () => GetWeightUseCase(repository: sl.call()));

  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));

  sl.registerLazySingleton<UpdateWeightUseCase>(
      () => UpdateWeightUseCase(repository: sl.call()));

  //repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  //data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  //external
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
