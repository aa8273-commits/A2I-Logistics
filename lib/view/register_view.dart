// import 'package:a2i_logistics/constants/app_colors.dart';
// import 'package:a2i_logistics/cubit/register_cubit.dart';
// import 'package:a2i_logistics/cubit/register_state.dart';
// import 'package:a2i_logistics/cubit/role_cubit.dart';
// import 'package:a2i_logistics/view/login_view.dart';
// import 'package:a2i_logistics/widgets/custom_text_field_widget.dart';
// import 'package:a2i_logistics/widgets/role_selector_widget.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({super.key});

//   @override
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();

//   final TextEditingController _emailController = TextEditingController();

//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   String _phoneNumber = '';

//   late AnimationController _animationController;

//   bool _otpDialogOpen = false;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _otpController.dispose();
//     super.dispose();
//   }

//   // ============================================================
//   // REGISTER
//   // ============================================================

//   void _register() {
//     FocusScope.of(context).unfocus();

//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     if (_phoneNumber.trim().isEmpty) {
//       _showMessage(
//         title: 'Phone Required',
//         message: 'Please enter your phone number.',
//         isSuccess: false,
//       );
//       return;
//     }

//     final role = context.read<RoleCubit>().selectedRole;

//     if (role.trim().isEmpty) {
//       _showMessage(
//         title: 'Account Type Required',
//         message: 'Please select your account type.',
//         isSuccess: false,
//       );
//       return;
//     }

//     context.read<RegisterCubit>().register(
//       name: _nameController.text.trim(),
//       email: _emailController.text.trim(),
//       password: _passwordController.text,
//       phone: _phoneNumber,
//       role: role,
//     );
//   }

//   // ============================================================
//   // OTP DIALOG
//   // ============================================================

//   void _showOtpDialog() {
//     if (_otpDialogOpen) {
//       return;
//     }

//     _otpDialogOpen = true;

//     final TextEditingController otpController = TextEditingController();

//     showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (dialogContext) {
//         return BlocProvider.value(
//           value: context.read<RegisterCubit>(),
//           child: BlocBuilder<RegisterCubit, RegisterState>(
//             builder: (context, state) {
//               final bool isLoading = state is RegisterPhoneVerificationLoading;

//               return AlertDialog(
//                 backgroundColor: AppColors.cardBg,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 title: Row(
//                   children: [
//                     Container(
//                       width: 42,
//                       height: 42,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColors.primaryCyan.withOpacity(0.12),
//                       ),
//                       child: const Icon(
//                         Icons.sms_outlined,
//                         color: AppColors.primaryCyan,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: Text(
//                         'Verify Phone',
//                         style: TextStyle(
//                           color: AppColors.textWhite,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Enter the 6-digit verification code sent to:',
//                       style: TextStyle(
//                         color: AppColors.textMuted.withOpacity(0.9),
//                         fontSize: 14,
//                         height: 1.5,
//                       ),
//                     ),

//                     const SizedBox(height: 8),

//                     Text(
//                       _phoneNumber,
//                       style: const TextStyle(
//                         color: AppColors.primaryCyan,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     TextField(
//                       controller: otpController,
//                       autofocus: true,
//                       enabled: !isLoading,
//                       keyboardType: TextInputType.number,
//                       textInputAction: TextInputAction.done,
//                       maxLength: 6,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: AppColors.textWhite,
//                         fontSize: 22,
//                         fontWeight: FontWeight.w800,
//                         letterSpacing: 6,
//                       ),
//                       decoration: InputDecoration(
//                         hintText: '000000',
//                         counterText: '',
//                         hintStyle: TextStyle(
//                           color: AppColors.textMuted.withOpacity(0.35),
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 6,
//                         ),
//                         filled: true,
//                         fillColor: AppColors.background,
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 16,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: BorderSide.none,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: BorderSide.none,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: const BorderSide(
//                             color: AppColors.primaryCyan,
//                             width: 1.4,
//                           ),
//                         ),
//                       ),
//                       onSubmitted: (_) {
//                         if (!isLoading) {
//                           _verifyOtp(otpController.text);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: isLoading
//                         ? null
//                         : () {
//                             Navigator.pop(dialogContext);
//                           },
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         color: AppColors.textMuted.withOpacity(0.8),
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),

//                   ElevatedButton(
//                     onPressed: isLoading
//                         ? null
//                         : () {
//                             _verifyOtp(otpController.text);
//                           },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryCyan,
//                       foregroundColor: AppColors.background,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: isLoading
//                         ? const SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: AppColors.background,
//                             ),
//                           )
//                         : const Text(
//                             'Verify',
//                             style: TextStyle(fontWeight: FontWeight.w800),
//                           ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     ).then((_) {
//       _otpDialogOpen = false;
//       otpController.dispose();
//     });
//   }

//   // ============================================================
//   // VERIFY OTP
//   // ============================================================

//   void _verifyOtp(String code) {
//     final trimmedCode = code.trim();

//     if (trimmedCode.length != 6) {
//       _showMessage(
//         title: 'Invalid Code',
//         message: 'Please enter the 6-digit verification code.',
//         isSuccess: false,
//       );
//       return;
//     }

//     context.read<RegisterCubit>().verifyPhoneCode(smsCode: trimmedCode);
//   }

//   // ============================================================
//   // MESSAGE
//   // ============================================================

//   void _showMessage({
//     required String title,
//     required String message,
//     required bool isSuccess,
//   }) {
//     if (!mounted) {
//       return;
//     }

//     showDialog<void>(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           backgroundColor: AppColors.cardBg,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           title: Row(
//             children: [
//               Container(
//                 width: 42,
//                 height: 42,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: isSuccess
//                       ? Colors.green.withOpacity(0.12)
//                       : Colors.red.withOpacity(0.12),
//                 ),
//                 child: Icon(
//                   isSuccess ? Icons.check_circle_outline : Icons.error_outline,
//                   color: isSuccess ? Colors.greenAccent : Colors.redAccent,
//                 ),
//               ),

//               const SizedBox(width: 12),

//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     color: AppColors.textWhite,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           content: Text(
//             message,
//             style: TextStyle(
//               color: AppColors.textMuted.withOpacity(0.9),
//               fontSize: 14,
//               height: 1.5,
//             ),
//           ),

//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext);
//               },
//               child: Text(
//                 'OK',
//                 style: TextStyle(
//                   color: isSuccess ? Colors.greenAccent : AppColors.primaryCyan,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // ============================================================
//   // BUILD
//   // ============================================================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: BlocConsumer<RegisterCubit, RegisterState>(
//           listener: (context, state) {
//             // --------------------------------------------------
//             // SMS SENT
//             // --------------------------------------------------

//             if (state is RegisterPhoneCodeSent) {
//               _showOtpDialog();
//             }

//             // --------------------------------------------------
//             // REGISTRATION SUCCESS
//             // --------------------------------------------------

//             if (state is RegisterSuccess) {
//               if (_otpDialogOpen) {
//                 Navigator.of(context).pop();
//                 _otpDialogOpen = false;
//               }

//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   backgroundColor: const Color(0xFF102B25),
//                   behavior: SnackBarBehavior.floating,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   content: const Row(
//                     children: [
//                       Icon(
//                         Icons.check_circle_rounded,
//                         color: Colors.greenAccent,
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           'Account created successfully.',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );

//               Future.delayed(const Duration(milliseconds: 900), () {
//                 if (!mounted) {
//                   return;
//                 }

//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (_) => const LoginView()),
//                 );
//               });
//             }

//             // --------------------------------------------------
//             // EMAIL REGISTRATION ERROR
//             // --------------------------------------------------

//             if (state is RegisterError) {
//               _showMessage(
//                 title: 'Registration Failed',
//                 message: state.message,
//                 isSuccess: false,
//               );
//             }

//             // --------------------------------------------------
//             // PHONE VERIFICATION ERROR
//             // --------------------------------------------------

//             if (state is RegisterPhoneVerificationError) {
//               _showMessage(
//                 title: 'Phone Verification Failed',
//                 message: state.message,
//                 isSuccess: false,
//               );
//             }
//           },

//           builder: (context, state) {
//             final bool isLoading =
//                 state is RegisterLoading ||
//                 state is RegisterPhoneVerificationLoading;

//             return AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 final animation = Curves.easeOutCubic.transform(
//                   _animationController.value,
//                 );

//                 return Opacity(
//                   opacity: animation,
//                   child: Transform.translate(
//                     offset: Offset(0, 35 * (1 - animation)),
//                     child: child,
//                   ),
//                 );
//               },

//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),

//                 child: Form(
//                   key: _formKey,

//                   child: Column(
//                     children: [
//                       const SizedBox(height: 10),

//                       // ==================================================
//                       // HEADER
//                       // ==================================================
//                       _buildAnimated(
//                         delay: 0.0,
//                         child: Column(
//                           children: [
//                             Container(
//                               width: 82,
//                               height: 82,
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFF101B30),
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: AppColors.primaryCyan.withOpacity(
//                                     0.55,
//                                   ),
//                                   width: 1.3,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: AppColors.primaryCyan.withOpacity(
//                                       0.18,
//                                     ),
//                                     blurRadius: 30,
//                                     spreadRadius: 4,
//                                   ),
//                                 ],
//                               ),
//                               child: const Icon(
//                                 Icons.person_add_alt_1_rounded,
//                                 color: AppColors.primaryCyan,
//                                 size: 42,
//                               ),
//                             ),

//                             const SizedBox(height: 20),

//                             const Text(
//                               'A2I',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 27,
//                                 fontWeight: FontWeight.w900,
//                                 letterSpacing: 7,
//                               ),
//                             ),

//                             const SizedBox(height: 5),

//                             Text(
//                               'SMART LOGISTICS PLATFORM',
//                               style: TextStyle(
//                                 color: AppColors.primaryCyan.withOpacity(0.8),
//                                 fontSize: 9,
//                                 fontWeight: FontWeight.w800,
//                                 letterSpacing: 2.2,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 42),

//                       // ==================================================
//                       // TITLE
//                       // ==================================================
//                       _buildAnimated(
//                         delay: 0.10,
//                         child: const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Create Account',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 31,
//                                   fontWeight: FontWeight.w900,
//                                   height: 1.1,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Create your account and start managing your logistics.',
//                                 style: TextStyle(
//                                   color: Colors.white54,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       // ==================================================
//                       // FULL NAME
//                       // ==================================================
//                       _buildAnimated(
//                         delay: 0.20,
//                         child: CustomTextFieldWidget(
//                           label: 'Full Name',
//                           icon: Icons.person_outline_rounded,
//                           controller: _nameController,
//                           keyboardType: TextInputType.name,
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Enter your full name';
//                             }

//                             if (value.trim().length < 3) {
//                               return 'Name must be at least 3 characters';
//                             }

//                             return null;
//                           },
//                         ),
//                       ),

//                       const SizedBox(height: 17),

//                       // ==================================================
//                       // EMAIL
//                       // ==================================================
//                       _buildAnimated(
//                         delay: 0.30,
//                         child: CustomTextFieldWidget(
//                           label: 'Email Address',
//                           icon: Icons.alternate_email_rounded,
//                           controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Enter your email address';
//                             }

//                             final emailRegex = RegExp(
//                               r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
//                             );

//                             if (!emailRegex.hasMatch(value.trim())) {
//                               return 'Enter a valid email address';
//                             }

//                             return null;
//                           },
//                         ),
//                       ),

//                       const SizedBox(height: 17),

//                       // ==================================================
//                       // PHONE
//                       // ==================================================
//                       _buildAnimated(
//                         delay: 0.40,
//                         child: IntlPhoneField(
//                           initialCountryCode: 'EG',
//                           keyboardType: TextInputType.phone,

//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),

//                           dropdownTextStyle: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),

//                           decoration: InputDecoration(
//                             labelText: 'Phone Number',
//                             hintText: '1012345678',

//                             labelStyle: const TextStyle(
//                               color: Colors.white70,
//                               fontSize: 13,
//                             ),

//                             hintStyle: const TextStyle(
//                               color: Colors.white30,
//                               fontSize: 13,
//                             ),

//                             filled: true,
//                             fillColor: AppColors.cardBg,

//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 18,
//                             ),

//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16),
//                               borderSide: BorderSide.none,
//                             ),

//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16),
//                               borderSide: BorderSide(color: AppColors.cardBg),
//                             ),

//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16),
//                               borderSide: const BorderSide(
//                                 color: AppColors.primaryCyan,
//                                 width: 1.4,
//                               ),
//                             ),

//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16),
//                               borderSide: const BorderSide(
//                                 color: Colors.redAccent,
//                               ),
//                             ),

//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16),
//                               borderSide: const BorderSide(
//                                 color: Colors.redAccent,
//                                 width: 1.4,
//                               ),
//                             ),
//                           ),

//                           onChanged: (phone) {
//                             _phoneNumber = phone.completeNumber;
//                           },

//                           validator: (phone) {
//                             if (phone == null || phone.number.trim().isEmpty) {
//                               return 'Enter your phone number';
//                             }

//                             try {
//                               if (!phone.isValidNumber()) {
//                                 return 'Enter a valid phone number';
//                               }
//                             } catch (_) {
//                               return 'Enter a valid phone number';
//                             }

//                             return null;
//                           },
//                         ),
//                       ),

//                       const SizedBox(height: 17),

//                       // ==================================================
//                       // PASSWORD
//                       // ==================================================
//                       _buildAnimated(
//                         delay: 0.50,
//                         child: CustomTextFieldWidget(
//                           label: 'Password',
//                           icon: Icons.lock_outline_rounded,
//                           isPassword: true,
//                           controller: _passwordController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Enter your password';
//                             }

//                             if (value.length < 8) {
//                               return 'Password must be at least 8 characters';
//                             }

//                             return null;
//                           },
//                         ),
//                       ),

//                       const SizedBox(height: 24),

//                       // ==================================================
//                       // ACCOUNT TYPE
//                       // ==================================================
//                       _buildAnimated(
//                         delay: 0.60,
//                         child: const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Account Type',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 12),

//                       _buildAnimated(
//                         delay: 0.65,
//                         child: const RoleSelectorWidget(),
//                       ),

//                       const SizedBox(height: 24),

//                       // ==================================================
//                       // REGISTER BUTTON
//                       // ==================================================
//                       _buildAnimated(
//                         delay: 0.70,
//                         child: _buildRegisterButton(
//                           isLoading: isLoading,
//                           onPressed: _register,
//                         ),
//                       ),

//                       const SizedBox(height: 22),

//                       // ==================================================
//                       // LOGIN
//                       // ==================================================
//                       _buildAnimated(
//                         delay: 0.80,
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 'Already have an account? ',
//                                 style: TextStyle(
//                                   color: Colors.white54,
//                                   fontSize: 12,
//                                 ),
//                               ),

//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text(
//                                   'Sign In',
//                                   style: TextStyle(
//                                     color: AppColors.primaryCyan,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w800,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 25),

//                       const Text(
//                         'SECURE • FAST • CONNECTED',
//                         style: TextStyle(
//                           color: Colors.white24,
//                           fontSize: 9,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // ANIMATION
//   // ============================================================

//   Widget _buildAnimated({required double delay, required Widget child}) {
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, _) {
//         final start = delay;
//         final end = (delay + 0.3).clamp(0.0, 1.0);

//         final value = CurvedAnimation(
//           parent: _animationController,
//           curve: Interval(start, end, curve: Curves.easeOutCubic),
//         ).value;

//         return Opacity(
//           opacity: value,
//           child: Transform.translate(
//             offset: Offset(0, 25 * (1 - value)),
//             child: child,
//           ),
//         );
//       },
//     );
//   }

//   // ============================================================
//   // REGISTER BUTTON
//   // ============================================================

//   Widget _buildRegisterButton({
//     required bool isLoading,
//     required VoidCallback onPressed,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       height: 58,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primaryCyan,
//           disabledBackgroundColor: AppColors.primaryCyan.withOpacity(0.55),
//           foregroundColor: Colors.black,
//           elevation: 10,
//           shadowColor: AppColors.primaryCyan.withOpacity(0.30),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18),
//           ),
//         ),
//         child: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 250),
//           child: isLoading
//               ? const SizedBox(
//                   key: ValueKey('loading'),
//                   width: 23,
//                   height: 23,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2.5,
//                     color: Colors.black,
//                   ),
//                 )
//               : const Row(
//                   key: ValueKey('register'),
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Create Account',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Icon(Icons.arrow_forward_rounded, size: 21),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
import 'package:a2i_logistics/constants/app_colors.dart';
import 'package:a2i_logistics/cubit/register_cubit.dart';
import 'package:a2i_logistics/cubit/register_state.dart';
import 'package:a2i_logistics/cubit/role_cubit.dart';
import 'package:a2i_logistics/view/login_view.dart';
import 'package:a2i_logistics/widgets/custom_text_field_widget.dart';
import 'package:a2i_logistics/widgets/role_selector_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String _phoneNumber = '';

  late AnimationController _animationController;

  bool _otpDialogOpen = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  // ============================================================
  // REGISTER
  // ============================================================

  void _register() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_phoneNumber.trim().isEmpty) {
      _showMessage(
        title: 'Phone Required',
        message: 'Please enter your phone number.',
        isSuccess: false,
      );
      return;
    }

    final role = context.read<RoleCubit>().selectedRole;

    if (role.trim().isEmpty) {
      _showMessage(
        title: 'Account Type Required',
        message: 'Please select your account type.',
        isSuccess: false,
      );
      return;
    }

    context.read<RegisterCubit>().register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      phone: _phoneNumber,
      role: role,
    );
  }

  // ============================================================
  // OTP DIALOG
  // ============================================================

  void _showOtpDialog() {
    if (_otpDialogOpen) {
      return;
    }

    _otpDialogOpen = true;
    _otpController.clear();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<RegisterCubit>(),
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final bool isLoading = state is RegisterPhoneVerificationLoading;

              return AlertDialog(
                backgroundColor: AppColors.cardBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                title: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryCyan.withOpacity(0.12),
                      ),
                      child: const Icon(
                        Icons.sms_outlined,
                        color: AppColors.primaryCyan,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Verify Phone',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter the 6-digit verification code sent to:',
                      style: TextStyle(
                        color: AppColors.textMuted.withOpacity(0.9),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _phoneNumber,
                      style: const TextStyle(
                        color: AppColors.primaryCyan,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _otpController,
                      autofocus: true,
                      enabled: !isLoading,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 6,
                      ),
                      decoration: InputDecoration(
                        hintText: '000000',
                        counterText: '',
                        hintStyle: TextStyle(
                          color: AppColors.textMuted.withOpacity(0.35),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 6,
                        ),
                        filled: true,
                        fillColor: AppColors.background,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.primaryCyan,
                            width: 1.4,
                          ),
                        ),
                      ),
                      onSubmitted: (_) {
                        if (!isLoading) {
                          _verifyOtp(_otpController.text);
                        }
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            Navigator.pop(dialogContext);
                          },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.textMuted.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            _verifyOtp(_otpController.text);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryCyan,
                      foregroundColor: AppColors.background,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.background,
                            ),
                          )
                        : const Text(
                            'Verify',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                  ),
                ],
              );
            },
          ),
        );
      },
    ).then((_) {
      _otpDialogOpen = false;
    });
  }

  // ============================================================
  // VERIFY OTP
  // ============================================================

  void _verifyOtp(String code) {
    final trimmedCode = code.trim();

    if (trimmedCode.length != 6) {
      _showMessage(
        title: 'Invalid Code',
        message: 'Please enter the 6-digit verification code.',
        isSuccess: false,
      );
      return;
    }

    context.read<RegisterCubit>().verifyPhoneCode(smsCode: trimmedCode);
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage({
    required String title,
    required String message,
    required bool isSuccess,
  }) {
    if (!mounted) {
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSuccess
                      ? Colors.green.withOpacity(0.12)
                      : Colors.red.withOpacity(0.12),
                ),
                child: Icon(
                  isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                  color: isSuccess ? Colors.greenAccent : Colors.redAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(
              color: AppColors.textMuted.withOpacity(0.9),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: isSuccess ? Colors.greenAccent : AppColors.primaryCyan,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            // --------------------------------------------------
            // SMS SENT
            // --------------------------------------------------

            if (state is RegisterPhoneCodeSent) {
              _showOtpDialog();
            }

            // --------------------------------------------------
            // REGISTRATION SUCCESS
            // --------------------------------------------------

            if (state is RegisterSuccess) {
              if (_otpDialogOpen) {
                Navigator.of(context).pop();
                _otpDialogOpen = false;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF102B25),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  content: const Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.greenAccent,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Account created successfully.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              Future.delayed(const Duration(milliseconds: 900), () {
                if (!mounted) {
                  return;
                }

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginView()),
                );
              });
            }

            // --------------------------------------------------
            // EMAIL REGISTRATION ERROR
            // --------------------------------------------------

            if (state is RegisterError) {
              _showMessage(
                title: 'Registration Failed',
                message: state.message,
                isSuccess: false,
              );
            }

            // --------------------------------------------------
            // PHONE VERIFICATION ERROR
            // --------------------------------------------------

            if (state is RegisterPhoneVerificationError) {
              _showMessage(
                title: 'Phone Verification Failed',
                message: state.message,
                isSuccess: false,
              );
            }
          },
          builder: (context, state) {
            final bool isLoading =
                state is RegisterLoading ||
                state is RegisterPhoneVerificationLoading;

            return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final animation = Curves.easeOutCubic.transform(
                  _animationController.value,
                );

                return Opacity(
                  opacity: animation,
                  child: Transform.translate(
                    offset: Offset(0, 35 * (1 - animation)),
                    child: child,
                  ),
                );
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // ==================================================
                      // HEADER
                      // ==================================================
                      _buildAnimated(
                        delay: 0.0,
                        child: Column(
                          children: [
                            Container(
                              width: 82,
                              height: 82,
                              decoration: BoxDecoration(
                                color: const Color(0xFF101B30),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: AppColors.primaryCyan.withOpacity(
                                    0.55,
                                  ),
                                  width: 1.3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryCyan.withOpacity(
                                      0.18,
                                    ),
                                    blurRadius: 30,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person_add_alt_1_rounded,
                                color: AppColors.primaryCyan,
                                size: 42,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'A2I',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 7,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'SMART LOGISTICS PLATFORM',
                              style: TextStyle(
                                color: AppColors.primaryCyan.withOpacity(0.8),
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2.2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 42),

                      // ==================================================
                      // TITLE
                      // ==================================================
                      _buildAnimated(
                        delay: 0.10,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create Account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 31,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Create your account and start managing your logistics.',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ==================================================
                      // FULL NAME
                      // ==================================================
                      _buildAnimated(
                        delay: 0.20,
                        child: CustomTextFieldWidget(
                          label: 'Full Name',
                          icon: Icons.person_outline_rounded,
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your full name';
                            }

                            if (value.trim().length < 3) {
                              return 'Name must be at least 3 characters';
                            }

                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 17),

                      // ==================================================
                      // EMAIL
                      // ==================================================
                      _buildAnimated(
                        delay: 0.30,
                        child: CustomTextFieldWidget(
                          label: 'Email Address',
                          icon: Icons.alternate_email_rounded,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your email address';
                            }

                            final emailRegex = RegExp(
                              r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                            );

                            if (!emailRegex.hasMatch(value.trim())) {
                              return 'Enter a valid email address';
                            }

                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 17),

                      // ==================================================
                      // PHONE
                      // ==================================================
                      _buildAnimated(
                        delay: 0.40,
                        child: IntlPhoneField(
                          initialCountryCode: 'EG',
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          dropdownTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: '1012345678',
                            labelStyle: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white30,
                              fontSize: 13,
                            ),
                            filled: true,
                            fillColor: AppColors.cardBg,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: AppColors.cardBg),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppColors.primaryCyan,
                                width: 1.4,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                                width: 1.4,
                              ),
                            ),
                          ),
                          onChanged: (phone) {
                            _phoneNumber = phone.completeNumber;
                          },
                          validator: (phone) {
                            if (phone == null || phone.number.trim().isEmpty) {
                              return 'Enter your phone number';
                            }

                            try {
                              if (!phone.isValidNumber()) {
                                return 'Enter a valid phone number';
                              }
                            } catch (_) {
                              return 'Enter a valid phone number';
                            }

                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 17),

                      // ==================================================
                      // PASSWORD
                      // ==================================================
                      _buildAnimated(
                        delay: 0.50,
                        child: CustomTextFieldWidget(
                          label: 'Password',
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            }

                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }

                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ==================================================
                      // ACCOUNT TYPE
                      // ==================================================
                      _buildAnimated(
                        delay: 0.60,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Account Type',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      _buildAnimated(
                        delay: 0.65,
                        child: const RoleSelectorWidget(),
                      ),

                      const SizedBox(height: 24),

                      // ==================================================
                      // REGISTER BUTTON
                      // ==================================================
                      _buildAnimated(
                        delay: 0.70,
                        child: _buildRegisterButton(
                          isLoading: isLoading,
                          onPressed: _register,
                        ),
                      ),

                      const SizedBox(height: 22),

                      // ==================================================
                      // LOGIN
                      // ==================================================
                      _buildAnimated(
                        delay: 0.80,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: AppColors.primaryCyan,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        'SECURE • FAST • CONNECTED',
                        style: TextStyle(
                          color: Colors.white24,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // ANIMATION
  // ============================================================

  Widget _buildAnimated({required double delay, required Widget child}) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final start = delay;
        final end = (delay + 0.3).clamp(0.0, 1.0);

        final value = CurvedAnimation(
          parent: _animationController,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ).value;

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 25 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }

  // ============================================================
  // REGISTER BUTTON
  // ============================================================

  Widget _buildRegisterButton({
    required bool isLoading,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryCyan,
          disabledBackgroundColor: AppColors.primaryCyan.withOpacity(0.55),
          foregroundColor: Colors.black,
          elevation: 10,
          shadowColor: AppColors.primaryCyan.withOpacity(0.30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: isLoading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 23,
                  height: 23,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.black,
                  ),
                )
              : const Row(
                  key: ValueKey('register'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_rounded, size: 21),
                  ],
                ),
        ),
      ),
    );
  }
}
