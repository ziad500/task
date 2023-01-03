import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/app_const.dart';
import 'package:task/dependancy_injection.dart' as di;
import 'package:task/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:task/feature/presentation/cubit/auth/auth_states.dart';
import 'package:task/feature/presentation/cubit/user/user_cubit.dart';
import 'package:task/feature/presentation/cubit/weight/weight_cubit.dart';
import 'package:task/feature/presentation/pages/sign_in_page.dart';
import 'package:task/on_generate_route.dart';

import 'feature/presentation/pages/home_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<UserCubit>(
          create: (context) => di.sl<UserCubit>(),
        ),
        BlocProvider<WeightCubit>(
          create: (context) => di.sl<WeightCubit>()..getWeights(uid: uid0),
        )
      ],
      child: MaterialApp(
        title: 'Weight Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": ((context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return const HomePage();
                }
                if (state is UnAuthenticated) {
                  return SignInPage();
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          })
        },
      ),
    );
  }
}
