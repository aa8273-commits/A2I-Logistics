import 'package:flutter_bloc/flutter_bloc.dart';

import 'os_state.dart';

class OsCubit extends Cubit<OsState> {
  OsCubit() : super(OsInitial());

  int currentPage = 0;

  void changePage(int index) {
    currentPage = index;
    emit(OsPageChanged(index));
  }

  void nextPage(int totalPages) {
    if (currentPage < totalPages - 1) {
      currentPage++;
      emit(OsPageChanged(currentPage));
    } else {
      completeOnboarding();
    }
  }

  void completeOnboarding() {
    emit(OsCompleted());
  }

  void skip() {
    completeOnboarding();
  }
}
