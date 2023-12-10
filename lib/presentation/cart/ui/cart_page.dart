import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rajkumarpractice/logic/cart_bloc/cart_state.dart';


import '../../../data/storage/database_helper.dart';
import 'package:rajkumarpractice/data/model/home_model.dart';

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final dbHelper = DatabaseHelper.instance;


  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart list',
            overflow: TextOverflow.ellipsis,
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<CartCubit, CartState>(
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
            print("homeList.length");
            print(homeList.length);
            print("homeList.length");
            return ListView.builder(
                itemCount: homeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(homeList[index].slug!),
                    subtitle: Text(homeList[index].link!),
                  );
                });
          } else {
            return Center(child: Container(child: Text("No Data")));

          }
        },
      ),
    );
  }
}
