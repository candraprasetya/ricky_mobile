import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ricky_mobile/core/size_config/config.dart';
import 'package:ricky_mobile/features/home/presentation/pages/home_page.dart';
import 'package:ricky_mobile/features/authentication/presentation/pages/login_page.dart';
import 'package:ricky_mobile/features/authentication/presentation/pages/register_page.dart';

GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    redirect: (context, state) {
      final auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        return '/home';
      } else {
        return '/register';
      }
    },
    builder: (context, state) {
      return Container();
    },
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) {
      SizeConfig.init(context);
      return const HomePage();
    },
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) {
      return const RegisterPage();
    },
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) {
      return const LoginPage();
    },
  )
]);
