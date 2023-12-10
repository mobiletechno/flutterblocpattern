import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rajkumarpractice/logic/Home_bloc/home_cubit.dart';
import 'package:rajkumarpractice/logic/Home_bloc/home_state.dart';

import '../../../utils/route_management/navigation_service.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // NavigationService service = NavigationService();
  final _routeService = NavigationService.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,

        title: Text('Home list',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),

        actions: [

          GestureDetector(onTap: (){
            _routeService.routeTo('/cart');
            print("navigated--------------------------");
          },child:Icon(Icons.shopping_cart)),
          SizedBox(width: 10,)
        ],

      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Icon(Icons.close),
            );
          } else if (state is LoadedState) {
            final homeList = state.homeList;

            return ListView.builder(
              controller: context.read<HomeCubit>().scrollListenercontroller,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: homeList.length + 1,
              itemBuilder: (context, index) =>

                       Card(
                          child:  index > state.homeList!.length - 1
                              ? Container(
                            color: Colors.transparent,
                            child: Center(child: CupertinoActivityIndicator()),
                          ):ListTile(
                            title: Text(homeList[index].slug!),

                            trailing: GestureDetector(onTap: (){
                              context.read<HomeCubit>().addDB(homeList[index]);
                              print("newdata in DB--------------------------");
                            },child:Icon(Icons.shopping_cart)),
                          ),
                        ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
