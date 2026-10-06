abstract class OsState {}

class OsInitial extends OsState {}

class OsPageChanged extends OsState {
  final int pageIndex;

  OsPageChanged(this.pageIndex);
}

class OsCompleted extends OsState {}
