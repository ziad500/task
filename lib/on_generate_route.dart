import 'package:flutter/material.dart';
import 'package:task/app_const.dart';
import 'package:task/feature/presentation/pages/add_weight_page.dart';
import 'package:task/feature/presentation/pages/sign_in_page.dart';
import 'package:task/feature/presentation/pages/sign_up_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case PageConst.addWeightPage:
        {
          return materialBuilder(
              widget: AddNewWeightPage(
            uid: uid0,
          ));
          break;
        }
      case PageConst.signUpPage:
        {
          return materialBuilder(widget: SignUpPage());
          break;
        }

      case PageConst.signInPage:
        {
          return materialBuilder(widget: SignInPage());
          break;
        }

      default:
        return materialBuilder(widget: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
