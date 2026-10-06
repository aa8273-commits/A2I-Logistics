import 'package:a2i_logistics/cubit/login_cubit.dart';
import 'package:a2i_logistics/cubit/os_cubit.dart';
import 'package:a2i_logistics/cubit/os_state.dart';
import 'package:a2i_logistics/view/login_view.dart';
import 'package:a2i_logistics/widgets/onboarding_hero_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OsView extends StatelessWidget {
  const OsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OsCubit(),
      child: BlocConsumer<OsCubit, OsState>(
        listener: (context, state) {
          if (state is OsCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => LoginCubit(),
                  child: const LoginView(),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<OsCubit>();

          return OsHeroCardWidget(onGetStarted: cubit.completeOnboarding);
        },
      ),
    );
  }
}
