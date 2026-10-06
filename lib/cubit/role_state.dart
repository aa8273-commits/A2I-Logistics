abstract class RoleState {}

class RoleInitial extends RoleState {}

class RoleChanged extends RoleState {
  final String role;

  RoleChanged(this.role);
}
