import 'package:ecommerce_app/core/app_dialogs/app_dialogs.dart';
import 'package:ecommerce_app/core/base_state/base_state.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/features/auth/presentation/manager/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/config/get_it.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../../../../core/widget/main_text_field.dart';
import '../../../../core/widget/validators.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.registerState is LoadingState) {
              AppDialogs.showLoading();
            } else if (state.registerState is SuccessState) {
              AppDialogs.hideLoading();
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.mainRoute, (route) => false);
            } else if (state.registerState is ErrorState) {
              AppDialogs.hideLoading();
              AppDialogs.showToast(
                  message: state.registerState?.error ?? "",
                  type: ToastType.error);
            }
          },
          builder: (context, state) {
            var cubit = context.watch<AuthCubit>();
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppSize.s40.h,
                        ),
                        Center(child: SvgPicture.asset(SvgAssets.routeLogo)),
                        SizedBox(
                          height: AppSize.s40.h,
                        ),
                        BuildTextField(
                          controller: cubit.nameController,
                          backgroundColor: ColorManager.white,
                          hint: 'enter your full name',
                          label: 'Full Name',
                          textInputType: TextInputType.name,
                          validation: AppValidators.validateFullName,
                        ),
                        SizedBox(
                          height: AppSize.s18.h,
                        ),
                        BuildTextField(
                          maxNumber: 11,
                          controller: cubit.phoneController,
                          hint: 'enter your mobile no.',
                          backgroundColor: ColorManager.white,
                          label: 'Mobile Number',
                          validation: AppValidators.validatePhoneNumber,
                          textInputType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: AppSize.s18.h,
                        ),
                        BuildTextField(
                          controller: cubit.emailController,
                          hint: 'enter your email address',
                          backgroundColor: ColorManager.white,
                          label: 'E-mail address',
                          validation: AppValidators.validateEmail,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: AppSize.s18.h,
                        ),
                        BuildTextField(
                          controller: cubit.passwordController,
                          hint: 'enter your password',
                          backgroundColor: ColorManager.white,
                          label: 'password',
                          validation: AppValidators.validatePassword,
                          isObscured: true,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: AppSize.s18.h,
                        ),
                        BuildTextField(
                          controller: cubit.rePasswordController,
                          hint: 'enter your Re password',
                          backgroundColor: ColorManager.white,
                          label: 'Re-password',
                          validation: (value) {
                            if (value != cubit.passwordController.text) {
                              return "Password Not Match";
                            }
                          },
                          isObscured: true,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: AppSize.s50.h,
                        ),
                        Center(
                          child: SizedBox(
                            height: AppSize.s60.h,
                            width: MediaQuery.of(context).size.width * .9,
                            child: CustomElevatedButton(
                              // borderRadius: AppSize.s8,
                              label: 'Sign Up',
                              backgroundColor: ColorManager.white,
                              textStyle: getBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: AppSize.s20),
                              onTap: () {
                                cubit.register();
                              },
                            ),
                          ),
                        ),
                      ],
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
}
