import 'package:alome/src/features/authentication/models/app_user.dart';
import 'package:alome/src/features/authentication/views/login_view.dart';
import 'package:alome/src/features/authentication/views/register_view.dart';
import 'package:alome/src/features/home/views/dashbaord_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const login = '/loginView';
  static const register = '/registerView';
  static const alome = '/AlomeHome';
  static const home = '/homeView';
  static const cards = '/cardView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case alome:
        final appUser = settings.arguments as AppUser;
        return MaterialPageRoute(builder: (_) => DashboardView(user: appUser));
      // case verifyEmail:
      //   return MaterialPageRoute(builder: (_) => const VerifyEmailView());
      // case add:
      //   return MaterialPageRoute(builder: (_) => const AddForumView());
      // case fView:
      //   final forum = settings.arguments as Forum;
      //   return MaterialPageRoute(builder: (_) => ForumView(forum: forum));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
