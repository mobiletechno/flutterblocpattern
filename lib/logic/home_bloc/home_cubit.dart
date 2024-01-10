import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rajkumarpractice/data/model/home_model.dart';

import '../../../data/respository/repo.dart';
import '../../../data/respository/repo_impl.dart';
import '../../../data/storage/database_helper.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  ScrollController scrollListenercontroller = ScrollController();
  late final Repo repository;
  HomeCubit() : super(InitialState()) {
    scrollListenercontroller.addListener(_scrollListener);
    this.repository=RepoImpl();
    getTrendingMovies(_paginationIndex);
  }

  Future<void> _scrollListener() async {
    if (scrollListenercontroller.hasClients) {
      if (scrollListenercontroller.position.pixels ==
          scrollListenercontroller.position.maxScrollExtent) {
        _paginationIndex += 10;
        final homeList = await repository.getList(_paginationIndex);
        // if (homeList.toString() != "[]") {
          final resultPort = ReceivePort();
          await Isolate.spawn(
            _IsolateparseJson,
            [resultPort.sendPort, homeList],
          );

          emit(LoadedState(await resultPort.first as List<HomeModel>));
        // }
      }
    }
  }


  int _paginationIndex = 10;
  final dbHelper = DatabaseHelper.instance;
  // late Repo repository;
  // final Repo repository;

  Future<void> getTrendingMovies(int pagination) async {
    try {
      emit(LoadingState());
      // repository = RepoImpl();
      final homeList = await repository.getList(pagination);
      final resultPort = ReceivePort();
      await Isolate.spawn(
        _IsolateparseJson,
        [resultPort.sendPort, homeList],
      );

      emit(LoadedState(await resultPort.first as List<HomeModel>));
    } catch (e) {
      emit(ErrorState());
    }
  }
  void addDB(HomeModel homeModel) async {
    // HomeModel newhomeModel = HomeModel(
    //     id:homeModel.id ,
    //   date:homeModel.date ,link:homeModel.link ,protected:homeModel.protected ,slug:homeModel.slug,type: homeModel.type
    //
    // );
    // int id = await dbHelper.insert(newhomeModel);
    // // int id = await dbHelper.insert(newNote);
    //
    // homeModel.id = id;

    HomeModel newhomeModel = HomeModel(
        id: homeModel.id,
        date: homeModel.date,
        link: homeModel.link,
        protected: homeModel.protected,
        slug: homeModel.slug,
        type: homeModel.type);
    int id = await dbHelper.insert(newhomeModel);

    homeModel.id = id;
    print("id------${homeModel.id}");
      // _notes.add(newNote);

  }

  Future<void> handleRefresh() async {
    _paginationIndex += 10;
    getTrendingMovies(_paginationIndex);
  }
}

Future<List<HomeModel>> _IsolateparseJson(List<dynamic> args) async {
  SendPort resultPort = args[0];
  final List<dynamic> rawData = args[1];
  final parsed = rawData.map((e) => HomeModel.fromJson(e)).toList();
  Isolate.exit(resultPort, parsed);
}
