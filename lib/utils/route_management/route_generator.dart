

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rajkumarpractice/app_config/app_constant.dart';
import 'package:rajkumarpractice/logic/Home_bloc/home_cubit.dart';
import 'package:rajkumarpractice/logic/cart_bloc/cart_state.dart';


import '../../presentation/cart/ui/cart_page.dart';

import '../../presentation/home/ui/home_page.dart';

class RouteGenerator {

  static Route<dynamic> generateRoutes(RouteSettings settings) {

    switch(settings.name) {
      case '${AppConstant.ROOT_NAME}':
        return MaterialPageRoute(builder: (context) => BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(

          ),
          child: Home(),
        ),);
      case '${AppConstant.CART_NAME}':
        return MaterialPageRoute(builder: (context) => BlocProvider<CartCubit>(
          create: (context) => CartCubit(

          ),
          child: MyCartPage(),
        ),);

      default:
        return MaterialPageRoute(builder: (context) => Scaffold(
          body: Center(
            child: Text("Not found ${settings.name}"),
          ),
        ));
    }
  }
}