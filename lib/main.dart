import 'package:a2i_logistics/constants/app_colors.dart';
import 'package:a2i_logistics/cubit/auth_gate.dart';
import 'package:a2i_logistics/cubit/login_cubit.dart';

import 'package:a2i_logistics/cubit/register_cubit.dart';
import 'package:a2i_logistics/cubit/role_cubit.dart';

import 'package:a2i_logistics/firebase_options.dart';
import 'package:a2i_logistics/view/login_view.dart';
import 'package:a2i_logistics/view/splashview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const A2ILogisticsApp());
}

class A2ILogisticsApp extends StatelessWidget {
  const A2ILogisticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
        BlocProvider<RegisterCubit>(create: (_) => RegisterCubit()),
        BlocProvider<RoleCubit>(create: (_) => RoleCubit()),
      ],
      child: MaterialApp(
        title: 'A2I Logistics',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          brightness: Brightness.dark,
          fontFamily: 'Roboto',
        ),
        home: const SplashView(),
      ),
    );
  }
}
//abdelrhman@gmail.com   AliAli4@gmail.com