import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/utils/app_router.dart';
import 'package:talabat_online/utils/app_routes.dart';
import 'package:talabat_online/view_models/auth_cubit/auth_cubit.dart';
import 'package:talabat_online/view_models/auth_cubit/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TalabatOnline());
}

class TalabatOnline extends StatelessWidget {
  const TalabatOnline({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..checkAuth(),
      child: Builder(builder: (context) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        return BlocBuilder<AuthCubit, AuthState>(
          bloc: authCubit,
          buildWhen: (previous, current) =>
              current is AuthInitial || current is AuthDone,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Talabat-Online',
              theme: ThemeData(
                fontFamily: 'OpenSans',
                useMaterial3: true,
                primaryColor: Color(0xff3700b3),
              ),
              initialRoute: state is AuthDone
                  ? AppRoutes.homeRoute
                  : AppRoutes.loginRoute,
              onGenerateRoute: AppRouter.onGenariteRout,
            );
          },
        );
      }),
    );
  }
}
