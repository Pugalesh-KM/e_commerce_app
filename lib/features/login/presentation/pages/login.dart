import 'dart:developer';
import 'package:e_commerce_app/core/constants/routes.dart';
import 'package:e_commerce_app/core/dependency_injection/injector.dart';
import 'package:e_commerce_app/features/login/domain/usecases/login_usecase.dart';
import 'package:e_commerce_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:e_commerce_app/shared/config/dimens.dart';
import 'package:e_commerce_app/shared/theme/app_colors.dart';
import 'package:e_commerce_app/shared/theme/text_styles.dart';
import 'package:e_commerce_app/shared/widgets/custom_loader.dart';
import 'package:e_commerce_app/shared/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginCubit _loginCubit;

  final useNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final loginUser = injector<LoginUseCase>();
    _loginCubit = LoginCubit(loginUser);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _loginCubit,
      child: Scaffold(
        backgroundColor: AppColors.appBackGround,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimens.standard_32),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login successful')),
                  );
                  context.go(RoutesName.authPath);
                } else if (state is LoginLoaded && state.isError) {
                  _showErrorSnackBar(context, state.errorMessage);
                  _loginCubit.resetError();
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(child: CustomLoader());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimens.standard_80),

                    Text(
                      "LOGIN".tr,
                      style: AppTextStyles.openSansBold32.copyWith(
                        color: AppColors.color1F2155,
                      ),
                    ),
                    const SizedBox(height: Dimens.standard_12),

                    Text(
                      "Welcome back!".tr,
                      style: AppTextStyles.openSansRegular16.copyWith(
                        color: AppColors.color4F4F4F,
                      ),
                    ),
                    const SizedBox(height: Dimens.standard_60),

                    /// Username Input
                    CustomTextInput(
                      textEditingController: useNameTextController,
                      hintText: "USERNAME".tr,
                      title: "USERNAME".tr,
                      inputType: TextInputType.text,
                      onChange: (value) =>
                          context.read<LoginCubit>().validateName(value),
                    ),
                    if (state is LoginLoaded &&
                        state.usernameError.isNotEmpty)
                      buildFieldValidation(state.usernameError),

                    const SizedBox(height: Dimens.standard_16),

                    /// Password Input
                    CustomTextInput(
                      textEditingController: passwordTextController,
                      hintText: "PASSWORD".tr,
                      title: "PASSWORD".tr,
                      isPassword: true,
                      onChange: (value) =>
                          context.read<LoginCubit>().validatePassword(value),
                    ),
                    if (state is LoginLoaded &&
                        state.passwordError.isNotEmpty)
                      buildFieldValidation(state.passwordError),

                    const SizedBox(height: Dimens.standard_16),

                    /// Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().validate(
                            useNameTextController.text.trim(),
                            passwordTextController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimens.standard_16,
                          ),
                          backgroundColor: AppColors.colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Dimens.standard_12,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "LOGIN".tr.toUpperCase(),
                          style: AppTextStyles.openSansBold16.copyWith(
                            color: AppColors.colorWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Error validation text
  Align buildFieldValidation(String errorValue) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: Dimens.standard_8),
        child: Text(
          errorValue,
          style: AppTextStyles.openSansRegular12.copyWith(
            color: AppColors.colorRed,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    log("ERROR ----- $message");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.colorRed.withOpacity(0.8),
      ),
    );
  }
}
