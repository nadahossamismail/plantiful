import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/cubits/login/login_cubit.dart';
import 'package:plantiful/cubits/visibility_icon/visibility_cubit.dart';
import 'package:plantiful/presentation_layer/screens/login/login_viewmodel.dart';
import 'package:plantiful/presentation_layer/widgets/alert_dialog.dart';
import 'package:plantiful/presentation_layer/widgets/loading.dart';
import 'package:plantiful/presentation_layer/widgets/material_button.dart';
import 'package:plantiful/presentation_layer/widgets/switch_auth_method.dart';
import 'package:plantiful/presentation_layer/widgets/text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel loginViewModel = LoginViewModel();

  @override
  void initState() {
    loginViewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => VisibilityCubit()),
      ],
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginCompleted) {
            Navigator.of(context)
                .pushReplacementNamed(Routes.locationSettingRoute);
          } else if (state is LoginFailure) {
            AppAlertDialog.showAlert(context, state.message);
          }
        },
        builder: (context, state) => SafeArea(
          child: Scaffold(
              body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: height / AppSpacingSizing.s12),
              child: Form(
                key: loginViewModel.formkey,
                child: Column(children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: FontSize.f24),
                  ),
                  const SizedBox(height: AppSpacingSizing.s24),
                  AppTextFormField(
                    label: "Email",
                    validator: loginViewModel.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    controller: loginViewModel.emailController,
                  ),
                  const SizedBox(height: AppSpacingSizing.s24),
                  BlocBuilder<VisibilityCubit, VisibilityState>(
                    builder: (context, state) {
                      return AppTextFormField(
                        label: "Password",
                        validator: loginViewModel.validatePassword,
                        keyboardType: TextInputType.visiblePassword,
                        controller: loginViewModel.passwordContoller,
                        isConfirm: false,
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacingSizing.s4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text("Forgot password?",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor))),
                  ),
                  const SizedBox(height: AppSpacingSizing.s16),
                  AppMaterialButton(
                      text: 'Login',
                      child: state is LoginLoading
                          ? const Loading(
                              color: Colors.white,
                            )
                          : null,
                      onPressed: () => state is LoginLoading
                          ? null
                          : loginViewModel.login(context)),
                  const SizedBox(height: AppSpacingSizing.s4),
                  const SwitchMethod(
                    message: "Don't have an account?",
                    screen: Routes.signUpRoute,
                    method: "Sign up",
                  )
                ]),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
