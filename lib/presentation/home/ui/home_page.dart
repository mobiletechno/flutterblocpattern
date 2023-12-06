import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_cubit.dart';
import '../bloc/home_state.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home list'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            print("what is error ${ErrorState}");
            return Center(
              child: Icon(Icons.close),
            );
          } else if (state is LoadedState) {
            final homeList = state.homeList;

            return ListView.builder(
              itemCount: homeList.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(homeList[index].name!),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("https://media.licdn.com/dms/image/C5603AQEMcHiaYqWq7w/profile-displayphoto-shrink_200_200/0/1600714454740?e=1707350400&v=beta&t=Ras_zq0Xfvrts4qqzVL8HkTUNYm1Gv7WFziMjNhpK7k"),
                  ),
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
