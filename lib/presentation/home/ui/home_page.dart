import 'package:flutter/cupertino.dart';
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
        title: Text('Home list'),
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
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage("${homeList[index].link!}"),
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
