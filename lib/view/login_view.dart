// import 'package:a2i_logistics/constants/app_colors.dart';
// import 'package:a2i_logistics/cubit/login_cubit.dart';
// import 'package:a2i_logistics/cubit/login_state.dart';
// import 'package:a2i_logistics/view/home_view.dart';
// import 'package:a2i_logistics/view/register_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final TextEditingController _emailOrPhoneController = TextEditingController();

//   final TextEditingController _passwordController = TextEditingController();

//   late final AnimationController _animationController;
//   late final Animation<double> _fadeAnimation;
//   late final Animation<Offset> _slideAnimation;

//   bool _obscurePassword = true;
//   bool _rememberMe = false;

//   bool _isPhoneLogin = false;

//   String _phoneNumber = '';

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );

//     _fadeAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOut,
//     );

//     _slideAnimation =
//         Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
//           CurvedAnimation(
//             parent: _animationController,
//             curve: Curves.easeOutCubic,
//           ),
//         );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _emailOrPhoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   // ============================================================
//   // LOGIN
//   // ============================================================

//   void _login() {
//     FocusScope.of(context).unfocus();

//     // -------------------------
//     // PHONE LOGIN
//     // -------------------------

//     if (_isPhoneLogin) {
//       if (_phoneNumber.trim().isEmpty) {
//         _showMessage(
//           title: 'Phone Required',
//           message: 'Please enter your phone number.',
//           isSuccess: false,
//         );
//         return;
//       }

//       context.read<LoginCubit>().login(
//         emailOrPhone: _phoneNumber,
//         password: '',
//       );

//       return;
//     }

//     // -------------------------
//     // EMAIL LOGIN
//     // -------------------------

//     final email = _emailOrPhoneController.text.trim();

//     if (email.isEmpty) {
//       _showMessage(
//         title: 'Email Required',
//         message: 'Please enter your email address.',
//         isSuccess: false,
//       );
//       return;
//     }

//     if (_passwordController.text.isEmpty) {
//       _showMessage(
//         title: 'Password Required',
//         message: 'Please enter your password.',
//         isSuccess: false,
//       );
//       return;
//     }

//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     context.read<LoginCubit>().login(
//       emailOrPhone: email,
//       password: _passwordController.text,
//     );
//   }

//   // ============================================================
//   // FORGOT PASSWORD
//   // ============================================================

//   void _forgotPassword() {
//     // Forgot password works with email only.
//     if (_isPhoneLogin) {
//       _showMessage(
//         title: 'Email Required',
//         message: 'Password reset is available using your email address only.',
//         isSuccess: false,
//       );
//       return;
//     }

//     final input = _emailOrPhoneController.text.trim();

//     if (input.isEmpty) {
//       _showMessage(
//         title: 'Email Required',
//         message: 'Please enter your email address to reset your password.',
//         isSuccess: false,
//       );
//       return;
//     }

//     final emailValidation = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

//     if (!emailValidation.hasMatch(input)) {
//       _showMessage(
//         title: 'Invalid Email',
//         message: 'Please enter a valid email address for password reset.',
//         isSuccess: false,
//       );
//       return;
//     }

//     context.read<LoginCubit>().sendPasswordResetEmail(email: input);
//   }

//   // ============================================================
//   // OTP DIALOG
//   // ============================================================

//   void _showOtpDialog() {
//     final TextEditingController otpController = TextEditingController();

//     showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (dialogContext) {
//         return BlocBuilder<LoginCubit, LoginState>(
//           builder: (context, state) {
//             final bool isLoading = state is PhoneVerificationLoading;

//             return AlertDialog(
//               backgroundColor: AppColors.cardBg,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               title: Row(
//                 children: [
//                   Container(
//                     width: 42,
//                     height: 42,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.primaryCyan.withOpacity(0.12),
//                     ),
//                     child: const Icon(
//                       Icons.sms_outlined,
//                       color: AppColors.primaryCyan,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Expanded(
//                     child: Text(
//                       'Verify Phone',
//                       style: TextStyle(
//                         color: AppColors.textWhite,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Enter the 6-digit verification code sent to:',
//                     style: TextStyle(
//                       color: AppColors.textMuted.withOpacity(0.9),
//                       fontSize: 14,
//                       height: 1.5,
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   // IMPORTANT:
//                   // We use _phoneNumber instead of
//                   // _emailOrPhoneController.text.
//                   Text(
//                     _phoneNumber,
//                     style: const TextStyle(
//                       color: AppColors.primaryCyan,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   TextField(
//                     controller: otpController,
//                     autofocus: true,
//                     enabled: !isLoading,
//                     keyboardType: TextInputType.number,
//                     textInputAction: TextInputAction.done,
//                     maxLength: 6,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: AppColors.textWhite,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w800,
//                       letterSpacing: 6,
//                     ),
//                     decoration: InputDecoration(
//                       hintText: '000000',
//                       counterText: '',
//                       hintStyle: TextStyle(
//                         color: AppColors.textMuted.withOpacity(0.35),
//                         fontSize: 22,
//                         fontWeight: FontWeight.w700,
//                         letterSpacing: 6,
//                       ),
//                       filled: true,
//                       fillColor: AppColors.background,
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 16,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide.none,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: const BorderSide(
//                           color: AppColors.primaryCyan,
//                           width: 1.4,
//                         ),
//                       ),
//                     ),
//                     onSubmitted: (_) {
//                       if (!isLoading) {
//                         _verifyOtp(dialogContext, otpController.text);
//                       }
//                     },
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: isLoading
//                       ? null
//                       : () {
//                           Navigator.pop(dialogContext);
//                         },
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(
//                       color: AppColors.textMuted.withOpacity(0.8),
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: isLoading
//                       ? null
//                       : () {
//                           _verifyOtp(dialogContext, otpController.text);
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryCyan,
//                     foregroundColor: AppColors.background,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: isLoading
//                       ? const SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             color: AppColors.background,
//                           ),
//                         )
//                       : const Text(
//                           'Verify',
//                           style: TextStyle(fontWeight: FontWeight.w800),
//                         ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     ).then((_) {
//       otpController.dispose();
//     });
//   }

//   void _verifyOtp(BuildContext dialogContext, String code) {
//     final trimmedCode = code.trim();

//     if (trimmedCode.length != 6) {
//       _showMessage(
//         title: 'Invalid Code',
//         message: 'Please enter the 6-digit verification code.',
//         isSuccess: false,
//       );
//       return;
//     }

//     context.read<LoginCubit>().verifyPhoneCode(smsCode: trimmedCode);
//   }

//   // ============================================================
//   // MESSAGE DIALOG
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
//                   isSuccess
//                       ? Icons.mark_email_read_outlined
//                       : Icons.error_outline,
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
//         child: BlocConsumer<LoginCubit, LoginState>(
//           listener: (context, state) {
//             // -------------------------
//             // LOGIN SUCCESS
//             // -------------------------

//             if (state is LoginSuccess) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const HomeView()),
//               );
//             }

//             // -------------------------
//             // LOGIN ERROR
//             // -------------------------

//             if (state is LoginError) {
//               _showMessage(
//                 title: 'Login Failed',
//                 message: state.message,
//                 isSuccess: false,
//               );
//             }

//             // -------------------------
//             // PHONE CODE SENT
//             // -------------------------

//             if (state is LoginPhoneCodeSent) {
//               _showOtpDialog();
//             }

//             // -------------------------
//             // PHONE VERIFICATION ERROR
//             // -------------------------

//             if (state is PhoneVerificationError) {
//               _showMessage(
//                 title: 'Verification Failed',
//                 message: state.message,
//                 isSuccess: false,
//               );
//             }

//             // -------------------------
//             // PASSWORD RESET SUCCESS
//             // -------------------------

//             if (state is PasswordResetSuccess) {
//               _showMessage(
//                 title: 'Reset Email Sent',
//                 message:
//                     'We sent a password reset link to ${state.email}.\n\n'
//                     'Please check your inbox and follow the link to create a new password.',
//                 isSuccess: true,
//               );
//             }

//             // -------------------------
//             // PASSWORD RESET ERROR
//             // -------------------------

//             if (state is PasswordResetError) {
//               _showMessage(
//                 title: 'Reset Failed',
//                 message: state.message,
//                 isSuccess: false,
//               );
//             }
//           },
//           builder: (context, state) {
//             final bool isLoginLoading =
//                 state is LoginLoading || state is PhoneVerificationLoading;

//             final bool isResetLoading = state is PasswordResetLoading;

//             return Center(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 32,
//                 ),
//                 child: FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: SlideTransition(
//                     position: _slideAnimation,
//                     child: ConstrainedBox(
//                       constraints: const BoxConstraints(maxWidth: 480),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildHeader(),

//                             const SizedBox(height: 38),

//                             _buildEmailOrPhoneField(),

//                             // Password is shown ONLY for email login.
//                             if (!_isPhoneLogin) ...[
//                               const SizedBox(height: 18),
//                               _buildPasswordField(),
//                               const SizedBox(height: 12),
//                               _buildForgotPassword(isLoading: isResetLoading),
//                             ],

//                             const SizedBox(height: 18),

//                             _buildRememberMe(),

//                             const SizedBox(height: 26),

//                             _buildSignInButton(isLoading: isLoginLoading),

//                             const SizedBox(height: 28),

//                             _buildDivider(),

//                             const SizedBox(height: 20),

//                             _buildGoogleButton(isLoading: isLoginLoading),

//                             const SizedBox(height: 24),

//                             _buildCreateAccountButton(),

//                             const SizedBox(height: 32),

//                             _buildFooter(),
//                           ],
//                         ),
//                       ),
//                     ),
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
//   // HEADER
//   // ============================================================

//   Widget _buildHeader() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 58,
//           height: 58,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(18),
//             gradient: LinearGradient(
//               colors: [
//                 AppColors.primaryCyan.withOpacity(0.22),
//                 AppColors.primaryCyan.withOpacity(0.05),
//               ],
//             ),
//             border: Border.all(color: AppColors.primaryCyan.withOpacity(0.35)),
//           ),
//           child: const Icon(
//             Icons.local_shipping_rounded,
//             color: AppColors.primaryCyan,
//             size: 28,
//           ),
//         ),

//         const SizedBox(height: 24),

//         const Text(
//           'Welcome back',
//           style: TextStyle(
//             color: AppColors.textWhite,
//             fontSize: 32,
//             fontWeight: FontWeight.w900,
//             letterSpacing: -0.8,
//           ),
//         ),

//         const SizedBox(height: 8),

//         Text(
//           'Sign in to continue managing your logistics.',
//           style: TextStyle(
//             color: AppColors.textMuted.withOpacity(0.9),
//             fontSize: 14,
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }

//   // ============================================================
//   // EMAIL OR PHONE FIELD
//   // ============================================================

//   Widget _buildEmailOrPhoneField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // EMAIL / PHONE SWITCH
//         Container(
//           height: 48,
//           padding: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: AppColors.cardBg,
//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: _buildLoginTypeButton(
//                   title: 'Email',
//                   icon: Icons.email_outlined,
//                   selected: !_isPhoneLogin,
//                   onTap: () {
//                     setState(() {
//                       _isPhoneLogin = false;
//                       _phoneNumber = '';
//                     });
//                   },
//                 ),
//               ),

//               const SizedBox(width: 4),

//               Expanded(
//                 child: _buildLoginTypeButton(
//                   title: 'Phone',
//                   icon: Icons.phone_outlined,
//                   selected: _isPhoneLogin,
//                   onTap: () {
//                     setState(() {
//                       _isPhoneLogin = true;
//                       _emailOrPhoneController.clear();
//                       _passwordController.clear();
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 14),

//         // -------------------------
//         // PHONE FIELD
//         // -------------------------
//         if (_isPhoneLogin)
//           IntlPhoneField(
//             initialCountryCode: 'EG',
//             keyboardType: TextInputType.phone,
//             style: const TextStyle(color: AppColors.textWhite, fontSize: 14),
//             dropdownTextStyle: const TextStyle(
//               color: AppColors.textWhite,
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//             ),
//             decoration: InputDecoration(
//               labelText: 'Phone Number',
//               hintText: '1012345678',
//               labelStyle: TextStyle(
//                 color: AppColors.textMuted.withOpacity(0.9),
//                 fontSize: 13,
//               ),
//               hintStyle: TextStyle(
//                 color: AppColors.textMuted.withOpacity(0.5),
//                 fontSize: 13,
//               ),
//               filled: true,
//               fillColor: AppColors.cardBg,
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 18,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(color: AppColors.cardBg),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: const BorderSide(
//                   color: AppColors.primaryCyan,
//                   width: 1.4,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: const BorderSide(color: Colors.redAccent),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: const BorderSide(
//                   color: Colors.redAccent,
//                   width: 1.4,
//                 ),
//               ),
//             ),

//             // IMPORTANT:
//             // Do NOT use a controller here.
//             // We only save the complete number in _phoneNumber.
//             onChanged: (phone) {
//               _phoneNumber = phone.completeNumber;
//             },

//             // IMPORTANT:
//             // Safe validator to prevent NumberTooShortException.
//             validator: (phone) {
//               if (phone == null || phone.number.trim().isEmpty) {
//                 return 'Enter your phone number';
//               }

//               try {
//                 if (!phone.isValidNumber()) {
//                   return 'Enter a valid phone number';
//                 }
//               } catch (_) {
//                 return 'Enter a valid phone number';
//               }

//               return null;
//             },
//           )
//         // -------------------------
//         // EMAIL FIELD
//         // -------------------------
//         else
//           TextFormField(
//             controller: _emailOrPhoneController,
//             keyboardType: TextInputType.emailAddress,
//             textInputAction: TextInputAction.next,
//             style: const TextStyle(color: AppColors.textWhite, fontSize: 14),
//             decoration: _inputDecoration(
//               label: 'Email Address',
//               hint: 'Enter your email',
//               icon: Icons.alternate_email_rounded,
//             ),
//             validator: (value) {
//               final email = value?.trim() ?? '';

//               if (email.isEmpty) {
//                 return 'Please enter your email address.';
//               }

//               final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

//               if (!emailRegex.hasMatch(email)) {
//                 return 'Please enter a valid email address.';
//               }

//               return null;
//             },
//           ),
//       ],
//     );
//   }

//   // ============================================================
//   // PASSWORD
//   // ============================================================

//   Widget _buildPasswordField() {
//     return TextFormField(
//       controller: _passwordController,
//       obscureText: _obscurePassword,
//       textInputAction: TextInputAction.done,
//       onFieldSubmitted: (_) => _login(),
//       style: const TextStyle(color: AppColors.textWhite, fontSize: 14),
//       decoration:
//           _inputDecoration(
//             label: 'Password',
//             hint: 'Enter your password',
//             icon: Icons.lock_outline_rounded,
//           ).copyWith(
//             suffixIcon: IconButton(
//               onPressed: () {
//                 setState(() {
//                   _obscurePassword = !_obscurePassword;
//                 });
//               },
//               icon: Icon(
//                 _obscurePassword
//                     ? Icons.visibility_outlined
//                     : Icons.visibility_off_outlined,
//                 color: AppColors.textMuted,
//               ),
//             ),
//           ),
//       validator: (value) {
//         if (_isPhoneLogin) {
//           return null;
//         }

//         if (value == null || value.isEmpty) {
//           return 'Please enter your password.';
//         }

//         if (value.length < 6) {
//           return 'Password must be at least 6 characters.';
//         }

//         return null;
//       },
//     );
//   }

//   // ============================================================
//   // FORGOT PASSWORD
//   // ============================================================

//   Widget _buildForgotPassword({required bool isLoading}) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: TextButton(
//         onPressed: isLoading ? null : _forgotPassword,
//         style: TextButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//         ),
//         child: isLoading
//             ? const SizedBox(
//                 width: 18,
//                 height: 18,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: AppColors.primaryCyan,
//                 ),
//               )
//             : const Text(
//                 'Forgot Password?',
//                 style: TextStyle(
//                   color: AppColors.primaryCyan,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//       ),
//     );
//   }

//   // ============================================================
//   // REMEMBER ME
//   // ============================================================

//   Widget _buildRememberMe() {
//     return Row(
//       children: [
//         SizedBox(
//           width: 24,
//           height: 24,
//           child: Checkbox(
//             value: _rememberMe,
//             onChanged: (value) {
//               setState(() {
//                 _rememberMe = value ?? false;
//               });
//             },
//             activeColor: AppColors.primaryCyan,
//             checkColor: AppColors.background,
//             side: BorderSide(color: AppColors.textMuted.withOpacity(0.5)),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6),
//             ),
//           ),
//         ),

//         const SizedBox(width: 8),

//         Text(
//           'Remember me',
//           style: TextStyle(
//             color: AppColors.textMuted.withOpacity(0.9),
//             fontSize: 13,
//           ),
//         ),
//       ],
//     );
//   }

//   // ============================================================
//   // SIGN IN BUTTON
//   // ============================================================

//   Widget _buildSignInButton({required bool isLoading}) {
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : _login,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primaryCyan,
//           foregroundColor: AppColors.background,
//           disabledBackgroundColor: AppColors.primaryCyan.withOpacity(0.35),
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//         child: isLoading
//             ? const SizedBox(
//                 width: 23,
//                 height: 23,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2.5,
//                   color: AppColors.background,
//                 ),
//               )
//             : const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Sign In',
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
//                   ),
//                   SizedBox(width: 10),
//                   Icon(Icons.arrow_forward_rounded, size: 20),
//                 ],
//               ),
//       ),
//     );
//   }

//   // ============================================================
//   // GOOGLE BUTTON
//   // ============================================================

//   Widget _buildGoogleButton({required bool isLoading}) {
//     return SizedBox(
//       width: double.infinity,
//       height: 54,
//       child: OutlinedButton(
//         onPressed: isLoading
//             ? null
//             : () {
//                 context.read<LoginCubit>().signInWithGoogle();
//               },
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.textWhite,
//           backgroundColor: AppColors.cardBg,
//           side: BorderSide(color: AppColors.cardBg, width: 1.2),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//         child: isLoading
//             ? const SizedBox(
//                 width: 21,
//                 height: 21,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2.2,
//                   color: AppColors.primaryCyan,
//                 ),
//               )
//             : Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 24,
//                     height: 24,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'G',
//                         style: TextStyle(
//                           color: Color(0xFF4285F4),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Continue with Google',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }

//   // ============================================================
//   // DIVIDER
//   // ============================================================

//   Widget _buildDivider() {
//     return Row(
//       children: [
//         Expanded(child: Container(height: 1, color: AppColors.cardBg)),

//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           child: Text(
//             'OR',
//             style: TextStyle(
//               color: AppColors.textMuted.withOpacity(0.65),
//               fontSize: 11,
//               fontWeight: FontWeight.w800,
//               letterSpacing: 1,
//             ),
//           ),
//         ),

//         Expanded(child: Container(height: 1, color: AppColors.cardBg)),
//       ],
//     );
//   }

//   // ============================================================
//   // CREATE ACCOUNT
//   // ============================================================

//   Widget _buildCreateAccountButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 54,
//       child: OutlinedButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             PageRouteBuilder(
//               transitionDuration: const Duration(milliseconds: 450),
//               pageBuilder: (context, animation, secondaryAnimation) =>
//                   const RegisterView(),
//               transitionsBuilder:
//                   (context, animation, secondaryAnimation, child) {
//                     final slideAnimation =
//                         Tween<Offset>(
//                           begin: const Offset(0.08, 0),
//                           end: Offset.zero,
//                         ).animate(
//                           CurvedAnimation(
//                             parent: animation,
//                             curve: Curves.easeOutCubic,
//                           ),
//                         );

//                     return FadeTransition(
//                       opacity: animation,
//                       child: SlideTransition(
//                         position: slideAnimation,
//                         child: child,
//                       ),
//                     );
//                   },
//             ),
//           );
//         },
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.textWhite,
//           side: BorderSide(color: AppColors.cardBg, width: 1.2),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//         child: const Text(
//           'Create Account',
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // FOOTER
//   // ============================================================

//   Widget _buildFooter() {
//     return Center(
//       child: Text(
//         'SECURE • FAST • CONNECTED',
//         style: TextStyle(
//           color: AppColors.textMuted.withOpacity(0.55),
//           fontSize: 10,
//           fontWeight: FontWeight.w800,
//           letterSpacing: 1.8,
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // INPUT DECORATION
//   // ============================================================

//   InputDecoration _inputDecoration({
//     required String label,
//     required String hint,
//     required IconData icon,
//   }) {
//     return InputDecoration(
//       labelText: label,
//       hintText: hint,

//       labelStyle: TextStyle(
//         color: AppColors.textMuted.withOpacity(0.9),
//         fontSize: 13,
//       ),

//       hintStyle: TextStyle(
//         color: AppColors.textMuted.withOpacity(0.5),
//         fontSize: 13,
//       ),

//       prefixIcon: Icon(icon, color: AppColors.textMuted, size: 21),

//       filled: true,
//       fillColor: AppColors.cardBg,

//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide.none,
//       ),

//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: AppColors.cardBg),
//       ),

//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: AppColors.primaryCyan, width: 1.4),
//       ),

//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: Colors.redAccent),
//       ),

//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
//       ),
//     );
//   }

//   // ============================================================
//   // EMAIL / PHONE SWITCH BUTTON
//   // ============================================================

//   Widget _buildLoginTypeButton({
//     required String title,
//     required IconData icon,
//     required bool selected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 220),
//         decoration: BoxDecoration(
//           color: selected
//               ? AppColors.primaryCyan.withOpacity(0.15)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(11),
//           border: selected
//               ? Border.all(color: AppColors.primaryCyan.withOpacity(0.35))
//               : null,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: 17,
//               color: selected ? AppColors.primaryCyan : AppColors.textMuted,
//             ),

//             const SizedBox(width: 7),

//             Text(
//               title,
//               style: TextStyle(
//                 color: selected ? AppColors.primaryCyan : AppColors.textMuted,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:a2i_logistics/constants/app_colors.dart';
import 'package:a2i_logistics/cubit/login_cubit.dart';
import 'package:a2i_logistics/cubit/login_state.dart';
import 'package:a2i_logistics/view/home_view.dart';
import 'package:a2i_logistics/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailOrPhoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _otpController = TextEditingController();

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  bool _obscurePassword = true;
  bool _rememberMe = false;

  bool _isPhoneLogin = false;

  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  // ============================================================
  // LOGIN
  // ============================================================

  void _login() {
    FocusScope.of(context).unfocus();

    // -------------------------
    // PHONE LOGIN
    // -------------------------

    if (_isPhoneLogin) {
      if (_phoneNumber.trim().isEmpty) {
        _showMessage(
          title: 'Phone Required',
          message: 'Please enter your phone number.',
          isSuccess: false,
        );
        return;
      }

      context.read<LoginCubit>().login(
        emailOrPhone: _phoneNumber,
        password: '',
      );

      return;
    }

    // -------------------------
    // EMAIL LOGIN
    // -------------------------

    final email = _emailOrPhoneController.text.trim();

    if (email.isEmpty) {
      _showMessage(
        title: 'Email Required',
        message: 'Please enter your email address.',
        isSuccess: false,
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      _showMessage(
        title: 'Password Required',
        message: 'Please enter your password.',
        isSuccess: false,
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<LoginCubit>().login(
      emailOrPhone: email,
      password: _passwordController.text,
    );
  }

  // ============================================================
  // FORGOT PASSWORD
  // ============================================================

  void _forgotPassword() {
    // Forgot password works with email only.
    if (_isPhoneLogin) {
      _showMessage(
        title: 'Email Required',
        message: 'Password reset is available using your email address only.',
        isSuccess: false,
      );
      return;
    }

    final input = _emailOrPhoneController.text.trim();

    if (input.isEmpty) {
      _showMessage(
        title: 'Email Required',
        message: 'Please enter your email address to reset your password.',
        isSuccess: false,
      );
      return;
    }

    final emailValidation = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailValidation.hasMatch(input)) {
      _showMessage(
        title: 'Invalid Email',
        message: 'Please enter a valid email address for password reset.',
        isSuccess: false,
      );
      return;
    }

    context.read<LoginCubit>().sendPasswordResetEmail(email: input);
  }

  // ============================================================
  // OTP DIALOG
  // ============================================================

  void _showOtpDialog() {
    _otpController.clear();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            final bool isLoading = state is PhoneVerificationLoading;

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

                  // IMPORTANT:
                  // We use _phoneNumber instead of
                  // _emailOrPhoneController.text.
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
                        _verifyOtp(dialogContext, _otpController.text);
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
                          _verifyOtp(dialogContext, _otpController.text);
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
        );
      },
    );
  }

  void _verifyOtp(BuildContext dialogContext, String code) {
    final trimmedCode = code.trim();

    if (trimmedCode.length != 6) {
      _showMessage(
        title: 'Invalid Code',
        message: 'Please enter the 6-digit verification code.',
        isSuccess: false,
      );
      return;
    }

    context.read<LoginCubit>().verifyPhoneCode(smsCode: trimmedCode);
  }

  // ============================================================
  // MESSAGE DIALOG
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
                  isSuccess
                      ? Icons.mark_email_read_outlined
                      : Icons.error_outline,
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
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            // -------------------------
            // LOGIN SUCCESS
            // -------------------------

            if (state is LoginSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeView()),
              );
            }

            // -------------------------
            // LOGIN ERROR
            // -------------------------

            if (state is LoginError) {
              _showMessage(
                title: 'Login Failed',
                message: state.message,
                isSuccess: false,
              );
            }

            // -------------------------
            // PHONE CODE SENT
            // -------------------------

            if (state is LoginPhoneCodeSent) {
              _showOtpDialog();
            }

            // -------------------------
            // PHONE VERIFICATION ERROR
            // -------------------------

            if (state is PhoneVerificationError) {
              _showMessage(
                title: 'Verification Failed',
                message: state.message,
                isSuccess: false,
              );
            }

            // -------------------------
            // PASSWORD RESET SUCCESS
            // -------------------------

            if (state is PasswordResetSuccess) {
              _showMessage(
                title: 'Reset Email Sent',
                message:
                    'We sent a password reset link to ${state.email}.\n\n'
                    'Please check your inbox and follow the link to create a new password.',
                isSuccess: true,
              );
            }

            // -------------------------
            // PASSWORD RESET ERROR
            // -------------------------

            if (state is PasswordResetError) {
              _showMessage(
                title: 'Reset Failed',
                message: state.message,
                isSuccess: false,
              );
            }
          },
          builder: (context, state) {
            final bool isLoginLoading =
                state is LoginLoading || state is PhoneVerificationLoading;

            final bool isResetLoading = state is PasswordResetLoading;

            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(),

                            const SizedBox(height: 38),

                            _buildEmailOrPhoneField(),

                            if (!_isPhoneLogin) ...[
                              const SizedBox(height: 18),
                              _buildPasswordField(),
                              const SizedBox(height: 12),
                              _buildForgotPassword(isLoading: isResetLoading),
                            ],

                            const SizedBox(height: 18),

                            _buildRememberMe(),

                            const SizedBox(height: 26),

                            _buildSignInButton(isLoading: isLoginLoading),

                            const SizedBox(height: 28),

                            _buildDivider(),

                            const SizedBox(height: 20),

                            _buildGoogleButton(isLoading: isLoginLoading),

                            const SizedBox(height: 24),

                            _buildCreateAccountButton(),

                            const SizedBox(height: 32),

                            _buildFooter(),
                          ],
                        ),
                      ),
                    ),
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
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                AppColors.primaryCyan.withOpacity(0.22),
                AppColors.primaryCyan.withOpacity(0.05),
              ],
            ),
            border: Border.all(color: AppColors.primaryCyan.withOpacity(0.35)),
          ),
          child: const Icon(
            Icons.local_shipping_rounded,
            color: AppColors.primaryCyan,
            size: 28,
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Welcome back',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Sign in to continue managing your logistics.',
          style: TextStyle(
            color: AppColors.textMuted.withOpacity(0.9),
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // EMAIL OR PHONE FIELD
  // ============================================================

  Widget _buildEmailOrPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildLoginTypeButton(
                  title: 'Email',
                  icon: Icons.email_outlined,
                  selected: !_isPhoneLogin,
                  onTap: () {
                    setState(() {
                      _isPhoneLogin = false;
                      _phoneNumber = '';
                    });
                  },
                ),
              ),

              const SizedBox(width: 4),

              Expanded(
                child: _buildLoginTypeButton(
                  title: 'Phone',
                  icon: Icons.phone_outlined,
                  selected: _isPhoneLogin,
                  onTap: () {
                    setState(() {
                      _isPhoneLogin = true;
                      _emailOrPhoneController.clear();
                      _passwordController.clear();
                    });
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        if (_isPhoneLogin)
          IntlPhoneField(
            initialCountryCode: 'EG',
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: AppColors.textWhite, fontSize: 14),
            dropdownTextStyle: const TextStyle(
              color: AppColors.textWhite,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: '1012345678',
              labelStyle: TextStyle(
                color: AppColors.textMuted.withOpacity(0.9),
                fontSize: 13,
              ),
              hintStyle: TextStyle(
                color: AppColors.textMuted.withOpacity(0.5),
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
                borderSide: const BorderSide(color: Colors.redAccent),
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
          )
        else
          TextFormField(
            controller: _emailOrPhoneController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: AppColors.textWhite, fontSize: 14),
            decoration: _inputDecoration(
              label: 'Email Address',
              hint: 'Enter your email',
              icon: Icons.alternate_email_rounded,
            ),
            validator: (value) {
              final email = value?.trim() ?? '';

              if (email.isEmpty) {
                return 'Please enter your email address.';
              }

              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

              if (!emailRegex.hasMatch(email)) {
                return 'Please enter a valid email address.';
              }

              return null;
            },
          ),
      ],
    );
  }

  // ============================================================
  // PASSWORD
  // ============================================================

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _login(),
      style: const TextStyle(color: AppColors.textWhite, fontSize: 14),
      decoration:
          _inputDecoration(
            label: 'Password',
            hint: 'Enter your password',
            icon: Icons.lock_outline_rounded,
          ).copyWith(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textMuted,
              ),
            ),
          ),
      validator: (value) {
        if (_isPhoneLogin) {
          return null;
        }

        if (value == null || value.isEmpty) {
          return 'Please enter your password.';
        }

        if (value.length < 6) {
          return 'Password must be at least 6 characters.';
        }

        return null;
      },
    );
  }

  // ============================================================
  // FORGOT PASSWORD
  // ============================================================

  Widget _buildForgotPassword({required bool isLoading}) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: isLoading ? null : _forgotPassword,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        ),
        child: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primaryCyan,
                ),
              )
            : const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: AppColors.primaryCyan,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
      ),
    );
  }

  // ============================================================
  // REMEMBER ME
  // ============================================================

  Widget _buildRememberMe() {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _rememberMe,
            onChanged: (value) {
              setState(() {
                _rememberMe = value ?? false;
              });
            },
            activeColor: AppColors.primaryCyan,
            checkColor: AppColors.background,
            side: BorderSide(color: AppColors.textMuted.withOpacity(0.5)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),

        const SizedBox(width: 8),

        Text(
          'Remember me',
          style: TextStyle(
            color: AppColors.textMuted.withOpacity(0.9),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SIGN IN BUTTON
  // ============================================================

  Widget _buildSignInButton({required bool isLoading}) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryCyan,
          foregroundColor: AppColors.background,
          disabledBackgroundColor: AppColors.primaryCyan.withOpacity(0.35),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 23,
                height: 23,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.background,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
      ),
    );
  }

  // ============================================================
  // GOOGLE BUTTON
  // ============================================================

  Widget _buildGoogleButton({required bool isLoading}) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: isLoading
            ? null
            : () {
                context.read<LoginCubit>().signInWithGoogle();
              },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textWhite,
          backgroundColor: AppColors.cardBg,
          side: BorderSide(color: AppColors.cardBg, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 21,
                height: 21,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: AppColors.primaryCyan,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: Color(0xFF4285F4),
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Continue with Google',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
      ),
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.cardBg)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'OR',
            style: TextStyle(
              color: AppColors.textMuted.withOpacity(0.65),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: AppColors.cardBg)),
      ],
    );
  }

  // ============================================================
  // CREATE ACCOUNT
  // ============================================================

  Widget _buildCreateAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 450),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const RegisterView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    final slideAnimation =
                        Tween<Offset>(
                          begin: const Offset(0.08, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ),
                        );

                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: slideAnimation,
                        child: child,
                      ),
                    );
                  },
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textWhite,
          side: BorderSide(color: AppColors.cardBg, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Create Account',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildFooter() {
    return Center(
      child: Text(
        'SECURE • FAST • CONNECTED',
        style: TextStyle(
          color: AppColors.textMuted.withOpacity(0.55),
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.8,
        ),
      ),
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(
        color: AppColors.textMuted.withOpacity(0.9),
        fontSize: 13,
      ),
      hintStyle: TextStyle(
        color: AppColors.textMuted.withOpacity(0.5),
        fontSize: 13,
      ),
      prefixIcon: Icon(icon, color: AppColors.textMuted, size: 21),
      filled: true,
      fillColor: AppColors.cardBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
        borderSide: const BorderSide(color: AppColors.primaryCyan, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
      ),
    );
  }

  // ============================================================
  // EMAIL / PHONE SWITCH BUTTON
  // ============================================================

  Widget _buildLoginTypeButton({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryCyan.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          border: selected
              ? Border.all(color: AppColors.primaryCyan.withOpacity(0.35))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 17,
              color: selected ? AppColors.primaryCyan : AppColors.textMuted,
            ),
            const SizedBox(width: 7),
            Text(
              title,
              style: TextStyle(
                color: selected ? AppColors.primaryCyan : AppColors.textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
