import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/utils/app_colors.dart';
import 'package:talabat_online/utils/app_routes.dart';
import 'package:talabat_online/view/widgets/lable_with_text_feild.dart';
import 'package:talabat_online/view/widgets/main_bottom.dart';
import 'package:talabat_online/view_models/auth_cubit/auth_cubit.dart';
import 'package:talabat_online/view_models/auth_cubit/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  Text(
                    'Login Account!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Please, login with registerd account!',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                  LableWithTextFeild(
                    hintText: 'Enter your email',
                    icon: Icons.mail,
                    controller: emailController,
                    lable: 'Email',
                  ),
                  LableWithTextFeild(
                    hintText: 'Enter your password',
                    icon: Icons.lock,
                    controller: passwordController,
                    lable: 'Password',
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget password',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: authCubit,
                    listenWhen: (previous, current) =>
                        current is AuthDone || current is AuthError,
                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.pushNamed(context, AppRoutes.homeRoute);
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is AuthDone ||
                        current is AuthError ||
                        current is AuthLoadoing,
                    builder: (context, state) {
                      if (state is AuthLoadoing) {
                        return MainBottom(
                          isLeading: true,
                        );
                      }
                      return MainBottom(
                        text: 'login',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await authCubit.loginWithWmailAndPaasword(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.registerRoute,
                          );
                        },
                        child: Text(
                          'Register',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
