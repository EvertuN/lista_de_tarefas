import 'package:aplicativo_de_lista/pages/signUpPage.dart';
import 'package:flutter/cupertino.dart';

import '../homePage.dart';
import 'forgotPage.dart';
import 'loginPage.dart';
import 'taskList.dart';

class AppRoutes {
  static const homePage = '/homePage';
  static const forgotPage = '/forgotPage';
  static const loginPage = '/loginPage';
  static const signUpPage = '/signUpPage';
  static const taskList = '/taskList';
  // static const taskList = '/taskList';

  static Map<String, WidgetBuilder> define(){
    return{
      homePage: (BuildContext context) => const HomePage(),
      forgotPage: (BuildContext context) => const ForgotPassword(),
      loginPage: (BuildContext context) => const LoginPage(),
      signUpPage: (BuildContext context) => const SignUp(),
      taskList: (BuildContext context) => const TaskList(),
      // taskList: (BuildContext context) => const TaskList(),
    };
  }
}