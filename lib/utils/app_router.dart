import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/utils/app_routes.dart';
import 'package:talabat_online/view/pages/add_new_cart_page.dart';
import 'package:talabat_online/view/pages/checkout_page.dart';
import 'package:talabat_online/view/pages/chose_location_page.dart';
import 'package:talabat_online/view/pages/nav_bar.dart';
import 'package:talabat_online/view/pages/prudact_details_page.dart';
import 'package:talabat_online/view_models/chose_location_cubit/chose_location_cubit.dart';
import 'package:talabat_online/view_models/home_details_cubit/home_details_cubit.dart';
import 'package:talabat_online/view_models/payment_methods_cubit/pyament_methods_cubit.dart';

class AppRouter {
  static Route<dynamic> onGenariteRout(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => NavBar(),
        );
      case AppRoutes.checkoutRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CheckoutPage(),
        );
      case AppRoutes.choseLocationRaoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => ChoseLocationCubit()..fetchLocation(),
            child: ChoseLocationPage(),
          ),
        );
      case AppRoutes.addNewCartRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => PyamentMethodsCubit(),
            child: AddNewCartPage(),
          ),
        );
      case AppRoutes.prudactDetailsRoute:
        final String prudactId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) =>
                PrudactDetailsCubit()..getPrudactDetails(prudactId),
            child: PrudactDetailsPage(
              prudactId: prudactId,
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Rout defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
