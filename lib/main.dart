import 'package:flutter/material.dart';
import 'utils/route_management/navigation_service.dart';
import 'utils/route_management/route_generator.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Plugin',
      onGenerateRoute: RouteGenerator.generateRoutes,
      initialRoute: '/',
      navigatorKey: NavigationService.instance.navigatorKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blueAccent,centerTitle: true,elevation: 10,actionsIconTheme: IconThemeData(color: Colors.white)),
        backgroundColor: Colors.white,
        errorColor: Colors.grey,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: BlocProvider<HomeCubit>(
      //   create: (context) => HomeCubit(
      //
      //   ),
      //   child: Home(),
      // ),
    );
  }
}

