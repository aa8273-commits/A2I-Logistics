// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'role_state.dart';

// class RoleCubit extends Cubit<RoleState> {
//   RoleCubit() : super(RoleInitial());

//   String selectedRole = 'Shipper';

//   void selectRole(String role) {
//     selectedRole = role;
//     emit(RoleChanged(role));
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';

import 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  RoleCubit() : super(RoleInitial());

  String selectedRole = 'Shipper';

  void selectRole(String role) {
    selectedRole = role;
    emit(RoleChanged(role));
  }
}
