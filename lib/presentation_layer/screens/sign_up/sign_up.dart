import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/cubits/sign_up/sign_up_cubit.dart';
import 'package:plantiful/cubits/visibility_icon/visibility_cubit.dart';
import 'package:plantiful/presentation_layer/screens/sign_up/sign_up_viewmodel.dart';
import 'package:plantiful/presentation_layer/widgets/loading.dart';
import 'package:plantiful/presentation_layer/widgets/material_button.dart';
import 'package:plantiful/presentation_layer/widgets/text_form_field.dart';
import '../../widgets/switch_auth_method.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var signUpViewModel = SignUpViewModel();

  @override
  void initState() {
    signUpViewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    signUpViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => VisibilityCubit()),
      ],
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: signUpViewModel.listener,
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSpacingSizing.s48,
                      horizontal: AppSpacingSizing.s28),
                  child: Form(
                      key: signUpViewModel.formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Sign Up",
                              style: GoogleFonts.patrickHand(
                                  textStyle: const TextStyle(
                                fontSize: 32,
                                color: AppColors.text,
                              )),
                            ),
                            const SizedBox(height: AppSpacingSizing.s32),
                            AppTextFormField(
                              label: "Name",
                              controller: signUpViewModel.usernameController,
                              keyboardType: TextInputType.name,
                              validator: signUpViewModel.validateUserName,
                            ),
                            const SizedBox(height: AppSpacingSizing.s24),
                            AppTextFormField(
                              label: "Email",
                              controller: signUpViewModel.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: signUpViewModel.validateEmail,
                            ),
                            const SizedBox(height: AppSpacingSizing.s24),
                            BlocBuilder<VisibilityCubit, VisibilityState>(
                                builder: (context, state) {
                              return Column(children: [
                                AppTextFormField(
                                  label: "Password",
                                  isConfirm: false,
                                  validator: signUpViewModel.validatePassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller:
                                      signUpViewModel.passwordController,
                                ),
                                const SizedBox(height: AppSpacingSizing.s24),
                                AppTextFormField(
                                  isConfirm: true,
                                  label: "Confirm Password",
                                  keyboardType: TextInputType.visiblePassword,
                                  validator:
                                      signUpViewModel.validateConfirmPassword,
                                  controller:
                                      signUpViewModel.confirmPasswordController,
                                )
                              ]);
                            }),
                            const SizedBox(height: AppSpacingSizing.s32),
                            AppMaterialButton(
                                text: 'Sign up',
                                child: state is SignUpLoading
                                    ? const Loading(color: Colors.white)
                                    : null,
                                onPressed: () => state is SignUpLoading
                                    ? null
                                    : signUpViewModel.signUp(context)),
                            const SizedBox(height: AppSpacingSizing.s4),
                            const SwitchMethod(
                                message: "Have an account?",
                                screen: Routes.loginRoute,
                                method: "Login")
                          ])),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
