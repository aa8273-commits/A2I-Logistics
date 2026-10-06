// // import 'package:a2i_logistics/constants/app_colors.dart';
// // import 'package:a2i_logistics/cubit/role_cubit.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // class RoleSelectorWidget extends StatelessWidget {
// //   const RoleSelectorWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final selectedRole = context.watch<RoleCubit>().selectedRole;

// //     return Row(
// //       children: [
// //         _buildRoleOption(
// //           context: context,
// //           title: 'Shipper',
// //           subtitle: 'صاحب بضاعة',
// //           roleKey: 'Shipper',
// //           icon: Icons.inventory_2_outlined,
// //           isSelected: selectedRole == 'Shipper',
// //         ),
// //         const SizedBox(width: 12),
// //         _buildRoleOption(
// //           context: context,
// //           title: 'Driver',
// //           subtitle: 'سائق شاحنة',
// //           roleKey: 'Driver',
// //           icon: Icons.local_shipping_outlined,
// //           isSelected: selectedRole == 'Driver',
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildRoleOption({
// //     required BuildContext context,
// //     required String title,
// //     required String subtitle,
// //     required String roleKey,
// //     required IconData icon,
// //     required bool isSelected,
// //   }) {
// //     return Expanded(
// //       child: GestureDetector(
// //         onTap: () {
// //           context.read<RoleCubit>().selectRole(roleKey);
// //         },
// //         child: AnimatedContainer(
// //           duration: const Duration(milliseconds: 300),
// //           curve: Curves.easeOutCubic,
// //           height: 105,
// //           padding: const EdgeInsets.all(14),
// //           decoration: BoxDecoration(
// //             color: isSelected
// //                 ? AppColors.primaryCyan.withOpacity(0.12)
// //                 : AppColors.cardBg,
// //             borderRadius: BorderRadius.circular(18),
// //             border: Border.all(
// //               color: isSelected
// //                   ? AppColors.primaryCyan
// //                   : Colors.white.withOpacity(0.05),
// //               width: isSelected ? 1.2 : 1,
// //             ),
// //             boxShadow: isSelected
// //                 ? [
// //                     BoxShadow(
// //                       color: AppColors.primaryCyan.withOpacity(0.12),
// //                       blurRadius: 20,
// //                       spreadRadius: 1,
// //                     ),
// //                   ]
// //                 : [],
// //           ),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               AnimatedContainer(
// //                 duration: const Duration(milliseconds: 250),
// //                 width: 32,
// //                 height: 32,
// //                 decoration: BoxDecoration(
// //                   color: isSelected
// //                       ? AppColors.primaryCyan.withOpacity(0.16)
// //                       : Colors.white.withOpacity(0.04),
// //                   borderRadius: BorderRadius.circular(13),
// //                 ),
// //                 child: Icon(
// //                   icon,
// //                   color: isSelected
// //                       ? AppColors.primaryCyan
// //                       : AppColors.textMuted,
// //                   size: 22,
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 title,
// //                 style: TextStyle(
// //                   color: isSelected ? AppColors.textWhite : AppColors.textMuted,
// //                   fontSize: 12,
// //                   fontWeight: FontWeight.w800,
// //                 ),
// //               ),
// //               const SizedBox(height: 2),
// //               Text(
// //                 subtitle,
// //                 style: TextStyle(
// //                   color: isSelected ? AppColors.primaryCyan : Colors.white38,
// //                   fontSize: 9,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:a2i_logistics/constants/app_colors.dart';
// import 'package:a2i_logistics/cubit/role_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RoleSelectorWidget extends StatelessWidget {
//   const RoleSelectorWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final selectedRole = context.watch<RoleCubit>().selectedRole;

//     return Column(
//       children: [
//         Row(
//           children: [
//             _buildRoleOption(
//               context: context,
//               title: 'Shipper',
//               subtitle: 'صاحب البضاعة',
//               roleKey: 'Shipper',
//               icon: Icons.inventory_2_outlined,
//               isSelected: selectedRole == 'Shipper',
//             ),
//             const SizedBox(width: 12),
//             _buildRoleOption(
//               context: context,
//               title: 'Transport',
//               subtitle: 'شركة النقل',
//               roleKey: 'Transport',
//               icon: Icons.local_shipping_outlined,
//               isSelected: selectedRole == 'Transport',
//             ),
//           ],
//         ),

//         const SizedBox(height: 12),

//         Row(
//           children: [
//             _buildRoleOption(
//               context: context,
//               title: 'Driver',
//               subtitle: 'السائق',
//               roleKey: 'Driver',
//               icon: Icons.drive_eta_outlined,
//               isSelected: selectedRole == 'Driver',
//             ),
//             const SizedBox(width: 12),
//             _buildRoleOption(
//               context: context,
//               title: 'Warehouse',
//               subtitle: 'المستودع / المخزن',
//               roleKey: 'Warehouse',
//               icon: Icons.warehouse_outlined,
//               isSelected: selectedRole == 'Warehouse',
//             ),
//           ],
//         ),

//         const SizedBox(height: 12),

//         Row(
//           children: [
//             _buildRoleOption(
//               context: context,
//               title: 'Admin',
//               subtitle: 'مدير النظام',
//               roleKey: 'Admin',
//               icon: Icons.admin_panel_settings_outlined,
//               isSelected: selectedRole == 'Admin',
//             ),
//             const SizedBox(width: 12),
//             const Expanded(child: SizedBox(height: 105)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildRoleOption({
//     required BuildContext context,
//     required String title,
//     required String subtitle,
//     required String roleKey,
//     required IconData icon,
//     required bool isSelected,
//   }) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           context.read<RoleCubit>().selectRole(roleKey);
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOutCubic,
//           height: 105,
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? AppColors.primaryCyan.withOpacity(0.12)
//                 : AppColors.cardBg,
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(
//               color: isSelected
//                   ? AppColors.primaryCyan
//                   : Colors.white.withOpacity(0.05),
//               width: isSelected ? 1.2 : 1,
//             ),
//             boxShadow: isSelected
//                 ? [
//                     BoxShadow(
//                       color: AppColors.primaryCyan.withOpacity(0.12),
//                       blurRadius: 20,
//                       spreadRadius: 1,
//                     ),
//                   ]
//                 : [],
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 250),
//                 width: 32,
//                 height: 32,
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? AppColors.primaryCyan.withOpacity(0.16)
//                       : Colors.white.withOpacity(0.04),
//                   borderRadius: BorderRadius.circular(13),
//                 ),
//                 child: Icon(
//                   icon,
//                   color: isSelected
//                       ? AppColors.primaryCyan
//                       : AppColors.textMuted,
//                   size: 22,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: isSelected ? AppColors.textWhite : AppColors.textMuted,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 subtitle,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: isSelected ? AppColors.primaryCyan : Colors.white38,
//                   fontSize: 9,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:a2i_logistics/constants/app_colors.dart';
import 'package:a2i_logistics/cubit/role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleSelectorWidget extends StatelessWidget {
  const RoleSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedRole = context.watch<RoleCubit>().selectedRole;

    return Column(
      children: [
        Row(
          children: [
            _buildRoleOption(
              context: context,
              title: 'Shipper',
              subtitle: 'صاحب البضاعة',
              roleKey: 'Shipper',
              icon: Icons.inventory_2_outlined,
              isSelected: selectedRole == 'Shipper',
            ),
            const SizedBox(width: 12),
            _buildRoleOption(
              context: context,
              title: 'Transport',
              subtitle: 'شركة النقل',
              roleKey: 'Transport',
              icon: Icons.local_shipping_outlined,
              isSelected: selectedRole == 'Transport',
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildRoleOption(
              context: context,
              title: 'Driver',
              subtitle: 'السائق',
              roleKey: 'Driver',
              icon: Icons.drive_eta_outlined,
              isSelected: selectedRole == 'Driver',
            ),
            const SizedBox(width: 12),
            _buildRoleOption(
              context: context,
              title: 'Warehouse',
              subtitle: 'المستودع / المخزن',
              roleKey: 'Warehouse',
              icon: Icons.warehouse_outlined,
              isSelected: selectedRole == 'Warehouse',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String roleKey,
    required IconData icon,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<RoleCubit>().selectRole(roleKey);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          height: 105,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryCyan.withOpacity(0.12)
                : AppColors.cardBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryCyan
                  : Colors.white.withOpacity(0.05),
              width: isSelected ? 1.2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primaryCyan.withOpacity(0.12),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryCyan.withOpacity(0.16)
                      : Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? AppColors.primaryCyan
                      : AppColors.textMuted,
                  size: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColors.textWhite : AppColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? AppColors.primaryCyan : Colors.white38,
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
