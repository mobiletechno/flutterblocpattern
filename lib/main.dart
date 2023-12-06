import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rajkumarpractice/presentation/home/bloc/home_cubit.dart';
import 'package:rajkumarpractice/presentation/home/ui/home_page.dart';

import 'data/respository/repo.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<HomeCubit>(
        create: (context) => HomeCubit(

        ),
        child: Home(),
      ),
    );
  }
}

