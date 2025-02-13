import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/utils/app_routes.dart';
import 'package:talabat_online/view/widgets/main_bottom.dart';
import 'package:talabat_online/view_models/auth_cubit/auth_cubit.dart';
import 'package:talabat_online/view_models/auth_cubit/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: authCubit,
          listenWhen: (previous, current) =>
              current is AuthLogedOut || current is AuthLogedOutError,
          listener: (context, state) {
            if (state is AuthLogedOut) {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(
                      AppRoutes.loginRoute, (route) => false);
            } else if (state is AuthLogedOutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          buildWhen: (previous, current) => current is AuthLogingOut,
          builder: (context, state) {
            if (state is AuthLogingOut) {
              return MainBottom(
                isLeading: true,
              );
            }
            return MainBottom(
              text: 'LogOut',
              onTap: () async {
                await authCubit.logOut();
              },
            );
          },
        ),
      ),
    );
  }
}
