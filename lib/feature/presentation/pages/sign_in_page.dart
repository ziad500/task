import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/app_const.dart';
import 'package:task/feature/domain/model/user_model.dart';
import 'package:task/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:task/feature/presentation/cubit/user/user_cubit.dart';
import 'package:task/feature/presentation/cubit/user/user_states.dart';
import 'package:task/main.dart';

import '../cubit/auth/auth_states.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, state) {
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return const HomePage();
              } else {
                return _bodyWidget(context);
              }
            },
          );
          return _bodyWidget(context);
        },
        listener: (context, state) {
          if (state is UserSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (state is UserFailure) {
            return;
          }
        },
      ),
    );
  }

  _bodyWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
                hintText: "Enter Your Email", border: InputBorder.none),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
                hintText: "Enter Your Password", border: InputBorder.none),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            submitSignIn();
          },
          child: Container(
            height: 45,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(.8),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PageConst.signUpPage);
          },
          child: Container(
            height: 45,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(.8),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  void submitSignIn() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(
          user: UserEntity(
              email: _emailController.text,
              password: _passwordController.text));
    }
  }
}
