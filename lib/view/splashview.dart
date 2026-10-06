import 'package:a2i_logistics/cubit/splash_cubit.dart';
import 'package:a2i_logistics/cubit/splash_state.dart';
import 'package:a2i_logistics/view/onboarding_view.dart';
import 'package:a2i_logistics/widgets/splash_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..initSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToOnboarding) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const OsView()),
            );
          } else if (state is SplashNavigateToLogin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginView()),
            );
          }
        },
        child: const Scaffold(
          backgroundColor: Color(0xFF080E1E),
          body: SplashLogoWidget(),
        ),
      ),
    );
  }
}
