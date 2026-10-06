import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void initSplash() async {
    emit(SplashLoading());

    // انتظار 3 ثوانٍ لمعاينة اللوجو
    await Future.delayed(const Duration(seconds: 3));

    // التوجيه لشاشة الـ Onboarding (OsView)
    emit(SplashNavigateToOnboarding());
  }
}
